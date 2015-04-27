From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 3/7] Asoc: sti: add CPU DAI driver for
	playback
Date: Mon, 27 Apr 2015 15:58:56 +0200
Message-ID: <553E40A0.4030904@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-4-git-send-email-arnaud.pouliquen@st.com>
 <20150424181528.GF22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B73C2260604
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 15:59:02 +0200 (CEST)
In-Reply-To: <20150424181528.GF22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 04/24/2015 08:15 PM, Mark Brown wrote:
> On Tue, Apr 14, 2015 at 03:35:27PM +0200, Arnaud Pouliquen wrote:
>
>> +const struct snd_pcm_hardware uni_player_pcm_hw = {
>> +	.info		= (
>> +	SNDRV_PCM_INFO_INTERLEAVED |
>> +	SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +	SNDRV_PCM_INFO_PAUSE),
>> +	.formats	= (SNDRV_PCM_FMTBIT_S32_LE |
>> +	SNDRV_PCM_FMTBIT_S16_LE),
> Please use the normal kernel coding style, standard indentation and no
> brackets.
>
>> +	.rates		= SNDRV_PCM_RATE_CONTINUOUS,
>> +	.rate_min	= UNIPERIF_MIN_RATE,
>> +	.rate_max	= UNIPERIF_MAX_RATE,
>> +
>> +	.channels_min	= UNIPERIF_MIN_CHANNELS,
>> +	.channels_max	= UNIPERIF_MAX_CHANNELS,
>> +
>> +	.periods_min	= UNIPERIF_PERIODS_MIN,
>> +	.periods_max	= UNIPERIF_PERIODS_MAX,
>> +
>> +	.period_bytes_min = UNIPERIF_PERIODS_BYTES_MIN,
>> +	.period_bytes_max = UNIPERIF_PERIODS_BYTES_MAX,
>> +	.buffer_bytes_max = UNIPERIF_BUFFER_BYTES_MAX
> Just use the values directly, the indirection is just making it harder
> to find what's actually set.
>
>> +static inline int reset_player(struct uniperif *player)
>> +{
>> +	int count = 10;
>> +
>> +	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
>> +		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(player) && count) {
>> +			udelay(5);
>> +			count--;
>> +		}
> Braces for the if too.  A cpu_relax() wouldn't go amiss in here either.
>
>> +static inline int get_property_hdl(struct device *dev, struct device_node *np,
>> +				   const char *prop, int idx)
>> +{
> This is very suspicous - why do you need this and if you need it why not
> add it to the generic DT code?
>
>> +static void uni_player_work(struct work_struct *work)
>> +{
>> +	struct uniperif *player =
>> +		container_of(work, struct uniperif, delayed_work.work);
>> +
>> +	spin_lock(&player->lock);
>> +	if (uni_player_suspend(player))
>> +		dev_err(player->dev, "%s: failed to suspend player", __func__);
>> +	spin_unlock(&player->lock);
>> +}
> What is this for, and why is there a spinlock which isn't IRQ safe?  If
> it's sensible to do this under a spinlock it seems like it might not
> need to be done in a workqueue...
>
> There's a lot of very coarse grained spinlock usage in this driver which
> I'm having a hard time understanding, at the very least the decisions
> about locking need to be documented much more clearly and I suspect that
> either things need to be finer grained, we should be using mutexes more
> or both.
>
This part is linked to the standby mode described in binding ( patch[1/7])
it manage a runtime suspend, because ASOC runtime suspend is dedicated 
to DAPM.
As you recommend i will try to change it by a DAPM linked to CPU_DAI. 
Just need to find a wait
to retrieve CPU_DAI context in DAPM..
Concerning spinlock
I use it to protect context ( called by IRQ, on suspend, by user...). As 
some code is called in atomic i can not use mutex.
I will review it and document it.
>> +static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
>> +{
>> +	irqreturn_t ret = IRQ_NONE;
>> +	struct uniperif *player = dev_id;
>> +	unsigned int status;
>> +	unsigned int tmp;
>> +
>> +	/* Get interrupt status & clear them immediately */
>> +	preempt_disable();
>> +	status = GET_UNIPERIF_ITS(player);
>> +	SET_UNIPERIF_ITS_BCLR(player, status);
>> +	preempt_enable();
> preempt_disable()?  Why is this being done, if you're doing unusual
> stuff like this the code needs to be very clear about what the locking
> rules are?
This is used to be sure to not miss an interrupt. If preempted between both
instruction i can clear an interruption flag before treat it. In this 
case i will receive
a second interrupt with all flag to 0.

>
>> +
>> +	if ((player->state == UNIPERIF_STATE_STANDBY) ||
>> +	    (player->state == UNIPERIF_STATE_STOPPED)) {
>> +		/* unexpected IRQ: do nothing */
>> +		dev_warn(player->dev, "unexpected IRQ: status flag: %#x",
>> +			 status);
>> +		return IRQ_HANDLED;
> We didn't handle it, we ignored it (after acknowledging it...).  I'd
> expect this check to be before we look at the hardware if it's needed.
>
>> +	};
> Extra semicolon here.
>
>> +	snd_pcm_stream_lock(player->substream);
> Again please explain the locking if we're doing something unusual.
This protect from a race condition, if application request a stop while 
we receive Error from IP.
I call it here to avoid toprotect all snd_pcm_stop calls... but i can  
protect only the snd_pcm_stop
calls if more clear
>
>> +	/* Check for fifo error (under run) */
>> +	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
>> +		dev_err(player->dev, "FIFO underflow error detected");
>> +
>> +		/* Interrupt is just for information when underflow recovery */
>> +		if (player->info->underflow_enabled) {
>> +			/* Update state to underflow */
>> +			player->state = UNIPERIF_STATE_UNDERFLOW;
> Why would underflow recovery be optional?
To propose 2 strategies:
- stop on underrun ( because plop will occurs)
- try to recover it:  time is recovered when new data is available ( 
sample dropping)

>
>> +	if (clk_set_rate(player->clk, rate_adjusted) < 0) {
>> +		dev_err(player->dev, "Failed to clk set rate %d !\n",
>> +			rate_adjusted);
>> +		return -EINVAL;
>> +	}
> Pass back the error code you got.
>
>> +	rate_achieved = clk_get_rate(player->clk);
>> +	if (!rate_achieved)
>> +		return -EINVAL;
> That check doesn't seem right - if the clock was set to 1Hz instead of
> 1MHz it'll report success.  Either trust that clk_set_rate() will give
> you an error if it fails or have some sort of reasonable check on the
> actual set value if that's important.

>
>> +static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
>> +				      struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct uniperif *player = snd_kcontrol_chip(kcontrol);
>> +
>> +	spin_lock(&player->lock);
>> +	ucontrol->value.integer.value[0] = player->clk_adj;
>> +	spin_unlock(&player->lock);
>> +
>> +	return 0;
>> +}
> There was some discussion of interfaces for fine tuning clock rates with
> some other drivers recently, we need to think about this in some
> standard fashion.  Please split this out into a separate patch.  In
> general it's best to introduce unusual/new things like this and the IEC
> setting in separate patches to simplify review and allow the easy bits
> to get merged without being held up by complicated things like this.
Ok i will add Clk and IEC controls in separate patches
>> +	of_property_read_u32(pnode, "version", &info->ver);
>> +
>> +	of_property_read_u32(pnode, "uniperiph-id", &info->uni_num);
> We can't read this stuff from the hardware?
Unfortunately No...
