From: Roslyn Hoskin <roslyn.hoskin@nautronix.com.au>
Subject: Re: hdsp driver and tools update
Date: Wed, 05 Nov 2003 10:38:31 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA862A7.1000703@nautronix.com.au>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm a friend of Nick Arnold who has previously posted to the alsa -devel 
regarding problems with the hdsp9652 card. I am using the same system as 
him.

Whereby we are running

RME Hammerfall HDSP 9652 card working

> with ALSA 0.9.8 on a SMP redhat 9 box.  We're trying to use 12 input
> channels and three output channels, running at 48Khz 


We are interleaving our the channels in our code to run at 96kHz. we are 
syncing against an external word clock. and the system clock needs to be 
set as a slave

I'm trying to get the card to run at 96 kHz with the sample sync source  
(using the 0.9.8 driver and thomas patches and hdpsconf and hdspmixer).

When i change to autosync running @ 96kHz the system source clock 
changes to master and the card will not open.
below is the error I get?

.ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS 
failed: Operation not permitted
ACCESS:  MMAP_NONINTERLEAVED
FORMAT:  S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: 32
FRAME_BITS: 448
CHANNELS: 14
RATE: NONE
PERIOD_TIME: (85333 85334)
PERIOD_SIZE: 8192
PERIOD_BYTES: 458752
PERIODS: 2
BUFFER_TIME: (170666 170667)
BUFFER_SIZE: 16384
BUFFER_BYTES: 917504
TICK_TIME: 10000

When I changed to autosync @ 96 kHz the hdspmixer shows 26 input 
channels and not 14?

When I change to internal 96kHz the hdspmixer shows 14 channels but the 
sync check on ADAT1 In, ADAT2 In, ADAT3 IN and WordClock change from 
Sync to lock and vice versa constanty.

Any Help on this would be great??

Thomas the hdspconf looks great, much easier to use than amixer!!! 
Thankyou and thanks also for the Patches!!

Roslyn Hoskin


Thomas Charbonnel wrote:

>Hi,
>
>I apologize for having been so silent the last few weeks, I was in the
>process of moving from Lyon, France to Berlin, Germany. This is now done,
>and I resumed my work on the hdsp driver and tools.
>Latest patches and tools can be found here :
>http://www.undata.org/~thomas/
>Mojor changes include support for hdsp 9632 cards and bugfixes for hdsp
>9652 cards.
>Hdspconf and hdspmixer now support 96xx cards, though this needs testing
>as I do not have the hardware.
>
>People testing this should remove their asound.state file from the way
>because the number or numid of ctls may have change.
>
>Takashi, I noticed that though it's been in cvs for some time now,
>hdspconf is still not included in alsa-tools releases, is there a reason
>for this ?
>
>Thomas
>
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: SF.net Giveback Program.
>Does SourceForge.net help you be more productive?  Does it
>help you create better code?   SHARE THE LOVE, and help us help
>YOU!  Click Here: http://sourceforge.net/donate/
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>


-- 

NAUTRONIX LTD
MARINE TECHNOLOGY SOLUTIONS

Roslyn Hoskin
Software Engineer

Nautronix Ltd ABN 28 009 019 603
108 Marine Terrace, Fremantle, WA 6160, Australia
T +61 (0) 8 9431 0000, F +61 (0) 8 9430 5901, http://www.nautronix.com 

E roslyn.hoskin@nautronix.com.au


--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
