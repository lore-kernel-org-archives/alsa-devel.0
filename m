From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver and tools update
Date: Mon, 3 Nov 2003 14:31:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044.217.184.8.24.1067866262.squirrel@www.undata.org>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
        <3FA61C74.1090101@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FA61C74.1090101@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: roslyn.hoskin@nautronix.com.au
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Hello all,
>
> I'm a friend of Nick Arnold who has previously posted to the alsa -devel
>  regarding problems with the hdsp9652 card. I am using the same system
> as  him.
>
> Whereby we are running
>
> RME Hammerfall HDSP 9652 card working
>> with ALSA 0.9.8 on a SMP redhat 9 box.  We're trying to use 12 input
>> channels and three output channels, running at 48Khz
>
> and interleaving our the channels in our code to run at 96kHz. we are
> syncing against an external word clock. and the system clock needs to be
>  set as a slave
>
> I'm trying to get the card to run at 96 kHz with the sample sync source
>  (using the 0.9.8 driver and thomas patches and hdpsconf and hdspmixer).
>
> When i change to autosync running @ 96kHz the system source clock
> changes to master and the card will not open.
> below is the error I get?
>
> .ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
> failed: Operation not permitted
> ACCESS:  MMAP_NONINTERLEAVED
> FORMAT:  S32_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 32
> FRAME_BITS: 448
> CHANNELS: 14
> RATE: NONE
> PERIOD_TIME: (85333 85334)
> PERIOD_SIZE: 8192
> PERIOD_BYTES: 458752
> PERIODS: 2
> BUFFER_TIME: (170666 170667)
> BUFFER_SIZE: 16384
> BUFFER_BYTES: 917504
> TICK_TIME: 10000
>
> When I changed to autosync @ 96 kHz the hdspmixer shows 26 input
> channels and not 14?
>
>
> When I change to internal 96kHz the hdspmixer shows 14 channels but the
> sync check on ADAT1 In, ADAT2 In, ADAT3 IN and WordClock change from
> Sync to lock and vice versa constanty.
>
>
> Any Help on this would be great??

Here is how things are supposed to work :
You have the choice between AutoSync mode and Internal clock modes. For
the card to successfully switch to AutoSync mode there must be a valid
clock source in the range of the speed mode you're using, that is SR <=
48000 for normal mode and SR > 48000 for double speed mode. So if the card
is set up on Internal 44.1 kHz and you want to sync on a 96 kHz external
clock, you first have to manually switch to Internal 96 kHz, make sure you
have a valid 96 kHz external clock signal, and then you can switch to
AutoSync.
The constant switch between Sync and Lock your describing is caused by
slight skewing between the external and internal clocks.

>
> Thomas the hdspconf looks great, much easier to use than amixer!!!
> Thankyou and thanks also for the Patches!!
>
My pleasure :)

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
