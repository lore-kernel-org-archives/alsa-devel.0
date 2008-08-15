From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: SPDIF audio / non-audio bit
Date: Sat, 16 Aug 2008 01:56:14 +1000
Message-ID: <1218815774.32652.40.camel@localhost>
References: <1218725321.32652.14.camel@localhost>
	<s5hmyjfzks2.wl%tiwai@suse.de> <1218811533.32652.33.camel@localhost>
	<s5hd4ka5np1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 88658103890
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 17:56:19 +0200 (CEST)
In-Reply-To: <s5hd4ka5np1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Fri, 2008-08-15 at 16:59 +0200, Takashi Iwai wrote:
> At Sat, 16 Aug 2008 00:45:33 +1000,
> Ben Stanley wrote:
> > Could you please clarify 
> > 'independent PCM IEC958 status bits' vs 
> > 'default IEC958 status bits', 
> > perhaps by pointing out some drivers implementing each type?
> 
> Run the following:
> 	grep -r 'IEC958.*PCM_STREAM' sound/pci
> 
> These drivers have "IEC958 Playback PCM Stream" controls.  These
> controls are assigned to PCM streams, and changed individually from
> the "IEC958 Playback Default" control.  When the PCM stream is closed,
> it's back to the status of "IEC958 Playback Default".
> 
Thanks for the info.
> 
> > > You can change the status easily via iecset program in alsa-utils.
> > I note here that iecset does not accept --device=hw:0,1 for example. Any
> > reason for this?
> 
> Because it's invalid.  The --device option is for a control device,
> not for a PCM device.  If you want to change the secondary control
> (i.e. "IEC958 Playback Default" with index=1), pass "-n 1" to iecset.
> 
um, that doesn't work either.

mythtv@mythtv:~$ iecset -D=hw:0 -n 1 audio on
iecset: invalid option -- n
Usage: iecset [options] [cmd arg...]
Options:
    -D device   specifies the control device to use
    -c card     specifies the card number to use (equiv. with -Dhw:#)
    -x          dump the dump the AESx hex code for IEC958 PCM
parameters
    -i          read commands from stdin
Commands:
    professional (common)
    off = consumer mode, on = professional mode
    audio (common)
    on = audio mode, off = non-audio mode
    rate (common)
    sample rate in Hz
    emphasis (common)
    0 = none, 1 = 50/15us, 2 = CCITT
    lock (prof.)
    off = rate unlocked, on = rate locked
    sbits (prof.)
    sample bits 2 = 20bit, 4 = 24bit, 6 = undef
    wordlength (prof.)
    0=no, 2=22-18bit, 4=23-19bit, 5=24-20bit, 6=20-16bit
    category (consumer)
    0-0x7f
    copyright (consumer)
    off = non-copyright, on = copyright
    original (consumer)
    off = 1st-gen, on = original

I see that I have alsa-utils 1.0.15-3ubuntu2 (from ubuntu 8.04). Perhaps
my version is too old?

I will use my clunky old method for now, but I would like to clear up
this iecset issue.

Ben.
