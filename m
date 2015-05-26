From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 3/9] ASoC: sti: Add CPU DAI driver for
	playback
Date: Tue, 26 May 2015 15:51:55 +0200
Message-ID: <55647A7B.2050400@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-4-git-send-email-arnaud.pouliquen@st.com>
 <20150525123745.GO21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A19A1261735
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 15:51:59 +0200 (CEST)
In-Reply-To: <20150525123745.GO21391@sirena.org.uk>
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



On 05/25/2015 02:37 PM, Mark Brown wrote:
> On Mon, May 18, 2015 at 02:12:50PM +0200, Arnaud Pouliquen wrote:
>
>> Add code to manage Uniperipheral player IP instances.
>> These DAIs are dedicated to playback and support I2S and IEC mode.
>
> There's some small things below but the main thing is that I'm still
> unclear about the driver internal abstraction layers.  Perhaps that will
> become obvious later in the series...
Abstraction layers are used to have same interface for uniperiph player 
and uniperiph reader DAIs.
I think there are two points to discuss before i rework it:

1) Are you still ok that i keep 2 separate files for player and reader 
IP management?
Just for remind here is discussion started on V1 patch set:

Arnaud: I splitted reader and player code,because it is 2 different IPs 
with some specific features and behavior ( clock, master/slave mode, 
IEC, standby ...).  From my point of view is is more clear like this, 
but It is feasible to merge both code adding conditions on direction in 
most functions. Please tell me what you prefer.
I case of merge i suppose that the best is to not define uniperif_ops 
struct but externalize functions...

Marc: That's reasonable, we just shouldn't be seeing large chunks of 
obvious code duplication.

First I just see that i proposed to remove uniperif_ops, I forgot...my 
apologize
Then to complete discussion, I'm aware that code seems similar regarding 
patches 3 and 4 with some duplications.
but patches 8 & 9 add controls on uniperiph player, that make add 
differences.
I also plan to re-implement the standby mode available only on uniperif 
player IP (after driver acceptation). This specific mode will allows to 
to keep player on to send silence on bus when PCM stream is stopped.

2) If both files are kept what could be done is to:
- suppress sti_platform_dai structure and call directly functions
- use directly snd_soc_dai_ops in to replace uniperif_ops and keep 
common functions in sti_platform.c
This could be ok for you?


>> +static void uni_player_set_channel_status(struct uniperif *player,
>> +					  struct snd_pcm_runtime *runtime)
>> +{
>> +	int n;
>> +	unsigned int status;
>> +
>> +	/*
>> +	 * Some AVRs and TVs require the channel status to contain a correct
>> +	 * sampling frequency. If no sample rate is already specified, then
>> +	 * set one.
>> +	 */
>
> Please take a look at Russell King's patch "sound/core: add IEC958
> channel status helper" (currently in review though I'd expect it to hit
> -next the next time it's built) - it does this (or most of it anyway) in
> a factored out function that can be shared between drivers.
>
I will check Russell King's code, and try to use helper functions.
>
>> +	switch (player->daifmt & SND_SOC_DAIFMT_INV_MASK) {
>> +	case SND_SOC_DAIFMT_IB_IF:
>> +	case SND_SOC_DAIFMT_NB_IF:
>> +		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
>> +		break;
>
> I didn't spot the code where the inverted and normal bit clock
> polarities are handled?
>
yes missing, i will rework this...
Just a question what do you consider as normal clock?
data output on rising edge?
