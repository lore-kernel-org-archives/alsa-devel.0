From: alsadev@noid.net
Subject: Re: intel8x0 (82801BA): swap headphone/master quirk patch
Date: Fri,  6 Feb 2004 15:15:49 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040206231549.EB2DEEFC37@skyfire.absmc.net>
References: <s5hk7308osi.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from remote.absmc.net ([198.217.112.6])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA16462
	for <alsa-devel@alsa-project.org>; Sat, 7 Feb 2004 00:16:24 +0100
Received: from aeon.absmc.org (monica.absmc.org [10.25.35.47])
	by remote.absmc.net (Postfix) with ESMTP id 1955B1802D8
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2004 15:15:51 -0800 (PST)
Received: from skyfire.absmc.net (skyfire.absmc.org [10.25.46.207])
	by aeon.absmc.org (Postfix) with ESMTP id 5D97511776F
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2004 15:15:47 -0800 (PST)
In-Reply-To: <s5hk7308osi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2004 at 11:50:37AM +0100, Takashi Iwai wrote:
> At Thu,  5 Feb 2004 18:13:18 -0800 (PST),
> alsadev@noid.net wrote:
> > 
> > My Intel motherboard (D845WN) has built-in intel8x0 (82801BA)
> > audio with the Headphone <--> Master swapping problem...
> > 
> > This fixed it for me:
> 
> thanks for the patch.  i'll apply it.
> 
> for information, what is the ac97 codec?
> you can see it in /proc/asound/card0/codec97#0/* files.

My /proc/asound/card0/codec97#0/ac97#0-0 file contains:

  0-0/0: Analog Devices AD1885

  Capabilities     : -headphone out-
  DAC resolution   : 16-bit
  ADC resolution   : 16-bit
  3D enhancement   : Analog Devices Phat Stereo

  Current setup
  Mic gain         : +0dB [+0dB]
  POP path         : pre 3D
  Sim. stereo      : off
  3D enhancement   : off
  Loudness         : off
  Mono output      : MIX
  Mic select       : Mic1
  ADC/DAC loopback : off
  Extended ID      : codec=0 rev=0 DSA=0 VRA
  Extended status  : VRA
  PCM front DAC    : 8000Hz
  PCM ADC          : 48000Hz



  AD18XX configuration
  Unchained        : 0x1000,0x0000,0x0000
  Chained          : 0x0000,0x0000,0x0000




Thanks...




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
