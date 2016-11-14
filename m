From: Nicholas Bailey <Nicholas.Bailey@glasgow.ac.uk>
Subject: Re: working with a Tascam US-122mkII
Date: Mon, 14 Nov 2016 12:39:29 +0000
Message-ID: <1693542.mlt8WcSkMN@ariel>
References: <5d70e7e5-bb61-2574-b133-3864b913a629@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id DA322266B63
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 13:39:31 +0100 (CET)
Received: from hub01.campus.gla.ac.uk ([130.209.14.19])
 by plockton.cent.gla.ac.uk with esmtp (Exim 4.72)
 (envelope-from <Nicholas.Bailey@glasgow.ac.uk>) id 1c6GXq-0001uE-UW
 for alsa-devel@alsa-project.org; Mon, 14 Nov 2016 12:39:30 +0000
In-Reply-To: <5d70e7e5-bb61-2574-b133-3864b913a629@orange.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have a bunch of US122 (originals) which stopped working in the manner you 
describe several years ago. I made a half-hearted attempt to fix them at the 
time involving git bisecting the kernel source, but it got very untidy. The 
original developer isn't on the project any more? Not sure. Not having much 
experience with the USB stack and less with the audio drivers, I ran out of 
time and was forced to give up.

I did set undergraduate projects to fix this issue at BSc and MSc level, but 
nobody would touch it. Which is sad. I spoke about it to some friends in CS, 
but nothing happened.

I don't know if it's even the same bug but it sounds very similar. There were 
also issues using the MIDI interface.

Nick/.
 

On Saturday, 12 November 2016 18:46:13 GMT Christian Quentin wrote:
> Hi all,
> 
> I'm currently trying to use a Tascam US-122mkII sound card with Linux.
> I've made the following attempts:
> 
>   * with a Debian-Wheezy-based distro (called Tango Studio) which is
>     stopped now => I can use the Tascam card
>   * with a Debian-Jessie-based distro (called Librazik) which
>     development is active => I cannot use the Tascam card
> 
> 
> I'm able to use the card with Tango Studio but I would prefer to use the
> Librazik as there's a community maintaining it.
> 
>   * In Debian Wheezy, the card is identified as US122L
>   * In Debian Jessie, the card is identified as US122mkII which looks
>     promising but it's not fully functional
> 
> 
> 
> These are the steps we went through with the linuxmao.org team :
> == checking the kernel version ==
> ****************************************************************************
> ****** Debian Wheezy
> cat /proc/version
> ****************************************************************************
> ****** Linux version 3.2.0-4-realtime-amd64 (debian-kernel@lists.debian.org)
> (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP PREEMPT RT Debian
> 3.2.57-3+tstudio.2
> 
> ****************************************************************************
> ****** Debian Jessie
> cat /proc/version
> ****************************************************************************
> ****** Linux version 4.6.0-1-lzk-bl-amd64 (debian-kernel@lists.debian.org)
> (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP PREEMPT Debian
> 4.6.2-2librazik1 (2016-06-29)
> 
> 
> 
> == checking the sound card detected ==
> 
> ****************************************************************************
> ****** Debian Wheezy
> cat /proc/asound/cards
> ****************************************************************************
> ****** 0 SB <http://linuxmao.org/SB>: HDA-Intel - HDA ATI SB
> HDA ATI SB at 0xfebfc000 irq 17
> 1 US122L <http://linuxmao.org/US122L>: USB US-122L - TASCAM US-122L
> TASCAM US-122L (644:8021 if 0 at 001/002)
> 
> ****************************************************************************
> ****** Debian Jessie :
> cat /proc/asound/cards
> ****************************************************************************
> ****** 0 SB <http://linuxmao.org/SB>: HDA-Intel - HDA ATI SB
> HDA ATI SB at 0xfebfc000 irq 17
> 1 MKII <http://linuxmao.org/MKII>: USB-Audio - US122 MKII
> TASCAM US122 MKII at usb-0000:00:13.5-1, high speed
> 
> 
> 
> 
> == creating a ~/.asoundrc file ==
> 
> I was instructed to create an .asoundrc file
> 
> ****************************************************************************
> ******
> 
>  1. got from http://www.nabble.com/tascam-us122l-and-ccrma-td24036395.html
>  2. thanks to Karsten
> 
> 
>  1. The usb_stream plugin configuration
> 
> 
> pcm.!usb_stream {
> @args CARD <http://linuxmao.org/CARD>
> @args.CARD {
> type string
> default "0"
> }
> 
> type usb_stream
> 
> card $CARD
> }
> 
> ctl.!usb_stream {
> @args CARD <http://linuxmao.org/CARD>
> @args.CARD {
> type string
> default "0"
> }
> 
> type hw
> 
> card $CARD
> }
> ****************************************************************************
> ******
> 
> 
> 
> == starting Jack server ==
> I'm using QjackCtl to start the Jack server with the following parameters:
> 
> ****************************************************************************
> ****** Debian Wheezy
> QjackCtl -> Settings -> Parameters -> "Interface" : usb_stream:1
> ****************************************************************************
> ****** => Jack server starts OK
> 
> ****************************************************************************
> ****** Debian Jessie
> QjackCtl -> Settings -> Parameters -> "Interface" : usb_stream:1
> ****************************************************************************
> ****** => Jack server does not start
> I've tried to remove the .asoundrc : Jack server does not start either
> 
> ****************************************************************************
> ****** Debian Jessie
> QjackCtl -> Settings -> Parameters -> "Interface" : hw:MKII US122 MKII
> (hw:1)
> (this value is already in the drop-down list of interfaces
> ****************************************************************************
> ****** => Jack server starts with the following message :
> 
> ****************************************************************************
> ****** hw:MKII|hw:MKII|1024|2|48000|0|0|nomon|swmeter|-|32bit
> ALSA: Cannot open PCM device alsa_pcm for capture. Falling back to
> playback-only mode
> ****************************************************************************
> ******
> 
> The result is I can use the sound card to play sounds but cannot get any
> input from it (I'm trying to get MIDI events)
> 
> 
> The linuxmao.org team thinks there might be a change in the ALSA driver
> in the latest releases.
> What do you think?
> 
> Thanks for your help
> 
> Christian
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
