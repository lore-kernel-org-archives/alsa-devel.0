From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [alsa-cvslog] CVS: BEFORE REVERT  [SUCCESS]   C-Media CMI9761
 -A- type, WORKING MASTER, PCM ON 1. DXS SLIDER!
Date: Wed, 16 Feb 2005 22:29:40 +0100
Message-ID: <4213BB44.5060702@gmx.de>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

mom.. guys, its working yet!

just build this cvs revision (first -A- type changes):

schorpp@tom1:/usr/src/alsa/alsa-kernel/pci/ac97$ cvs status |grep revision
cvs status: Examining .
    Working revision:    1.15
    Repository revision: 1.15 
/cvsroot/alsa/alsa-kernel/pci/ac97/Makefile,v
    Working revision:    1.171
    Repository revision: 1.171 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
    Working revision:    1.10
    Repository revision: 1.10 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_id.h,v
    Working revision:    1.12
    Repository revision: 1.12 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_local.h,v
    Working revision:    1.73
    Repository revision: 1.73 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
    Working revision:    1.18
    Repository revision: 1.18 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
    Working revision:    1.20
    Repository revision: 1.20 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_pcm.c,v
    Working revision:    1.13
    Repository revision: 1.13 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_proc.c,v
    Working revision:    1.15
    Repository revision: 1.15 
/cvsroot/alsa/alsa-kernel/pci/ac97/ak4531_codec.c,v
schorpp@tom1:/usr/src/alsa/alsa-kernel/pci/ac97$

after modprobe

- arts works with pcm fine
- working master vol slider(!) (kmix)
- working pcm vol regulation on 1. dxs slider (rest 3 no sound reaction)

... further tesing...

great work so far! thank you :))

...

Takashi Iwai wrote:
> Update of /cvsroot/alsa/alsa-kernel/pci/ac97
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv2615
> 
> Modified Files:
> 	ac97_codec.c ac97_patch.c ac97_patch.h 
> Log Message:
> Summary: Fix CM9761 again
> 
> Revert the last addition for CM9761A support.  The codec doesn't
> support the real control of Master

yes, it does fine for my chip , sorry.

/PCM volumes, too.

with 1. dxs slider at this rev.

> Instead, fixed the default multi-channel register setting now.
> 

why?
not verified. source of info? are you sure thats the -A- type, you got 
for testing? who verified?

oops! sound gone after doing this:

tom1:~# cat /proc/asound/card0/codec97#0/*
0-0/0: C-Media Electronics CMI9761A

Revision         : 0x01
Compat. Class    : 0x03
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 DRA
Extended status  : SPCV LDAC SDAC CDAC
0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 0000
0:0e = 9f1f
0:10 = 9f1f
0:12 = 0505
0:14 = 0000
0:16 = 9a1a
0:18 = 0808
0:1a = 0000
0:1c = 0303
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc2
0:2a = 05f0
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 2000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0004
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 3038
0:66 = 0012
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0100
0:72 = 0000
0:74 = c000
0:76 = 4f56
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4983
tom1:~#


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
