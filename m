From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Tue, 28 Apr 2009 11:56:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904281131440.25064@eeebox2.perex-int.cz>
References: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
	<20090427151512.GI20591@sirena.org.uk>
	<alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
	<s5hiqkp16w6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A59124425
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 11:56:21 +0200 (CEST)
In-Reply-To: <s5hiqkp16w6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Apr 2009, Takashi Iwai wrote:

>> - leave current fifo_size without change (there will be only small FIFO
>>    values to notify applications about small extra delays before samples
>>    reaches DAC or leaves ADC)
>
> fifo_size field is supposed to be constant, and shouldn't be changed
> dynamically after open.  This is a problem if the FIFO size varies
> depending on the parameter.

The alsa-lib's documentation states that one configuration must be chosen 
(thus hw_params should be called) to obtain fifo_size. It might depend on 
hardware parameters, but is static then. I would not propose to change 
anything with it.

>> - add cache_size value to snd_pcm_hardware struct - here will be
>>    stored area of buffer which might be cached in the hardware for large
>>    FIFOs including prepared USB's URBs (the upper layer should not work
>>    with this buffer area - rewind operation etc.)
>
> I already submitted a similar patch quite ago.  Actually, it exposes
> the delay account in snd_pcm_status() delay calculation.  The delay
> value can be dynamically changed.
>
> The current test patches are found on sound unstable tree
> topic/pcm-delay branch.
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git

Looks good. Could you pick these patches to your stable tree so we can 
stack other patches on top? I need to add 'delay' to hdelta in current 
elapsed callback to avoid false alarms.

Also, John should initialize this runtime->delay to correct value in 
frames in the mpc driver.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
