From: Mark Knecht <markknecht@comcast.net>
Subject: Re: VT8233/A/8235 Clock Problem
Date: Mon, 08 Dec 2003 08:56:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070902601.1907.6.camel@Wizard.knechthome.com>
References: <Pine.HPX.4.33n.0312081642130.24628-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312081642130.24628-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-12-08 at 07:49, Clemens Ladisch wrote:
> Mark Knecht wrote:
> >    BTW - how can I get a list of all possible module options for a given
> > card or device? Is there any way to find out about this  without reading
> > the code?
> 
> modinfo snd-via82xx

Cool. Thanks. I don't see explanations of the ac97_clock settings.

Wizard root # modinfo snd-via82xx
filename:   
/lib/modules/2.4.20-gentoo-r9/kernel/sound/pci/snd-via82xx.o
description: "VIA VT82xx audio"
author:      "Jaroslav Kysela <perex@suse.cz>"
license:     "GPL"
parm:        index int array (min = 1, max = 8), description "Index
value for VIA 82xx bridge."
parm:        id string array (min = 1, max = 8), description "ID string
for VIA 82xx bridge."
parm:        enable int array (min = 1, max = 8), description "Enable
audio part of VIA 82xx bridge."
parm:        mpu_port long array (min = 1, max = 8), description
"MPU-401 port. (VT82C686x only)"
parm:        ac97_clock int array (min = 1, max = 8), description "AC'97
codec clock (default 48000Hz)."
parm:        dxs_support int array (min = 1, max = 8), description
"Support for DXS channels (0 = auto, 1 = enable, 2 = disable
, 3 = 48k only, 4 = no VRA)"
Wizard root # man modinfo


Is this what I would look at to see the results of changing this
parameter?

Wizard root # cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
Wizard root # 


> 
> or read alsa-kernel/Documentation/ALSA-Configuration.txt and

a number of us were looking for this the other day and couldn't find it:

Wizard root # slocate ALSA-Configuration.txt
Wizard root #

I guess not all distributions install it, so I hope you will forgive me
not being able to read it without doing extra work. Possibly it's in a
zipped tarball somewhere...

> alsa-driver/INSTALL.
> 
> 
> HTH
> Clemens
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
