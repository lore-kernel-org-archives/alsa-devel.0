From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Re: au88x0 modem
Date: Fri, 16 Sep 2005 10:46:53 +0200
Message-ID: <20050916084653.GB524@titan.lahn.de>
References: <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050915204345.GC27700@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Thu, Sep 15, 2005 at 11:43:45PM +0300, Sasha Khapyorsky wrote:
> 1. Actual "secondary codec" bit in CODEC_EN register - just silly print
> (apply with -p1):
...

As in previous email: 00003f00

> 2. GPIO
>
> Probably we are lucky and au88x0 implements it in AC97 way, try to write
> mc97 registers via /proc (for this you need build drivers in debug mode,
> '--with-debug=detect' is ok):
>  # echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
>  # echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>  # echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs

Sorry, I did echo those values and read mc97#1-1+regs, but no values
changed.

> , if value is changed (we are lucky then), you may connect line and
> isten 'Hook-Off' clicks (when 0x54 is switched between 0 and 1) with
> parallel phone.

I don't have the line cable with me at the moment and need to find a
analog telephone circuit until I can test that

> 3. DMA
...
> Philipp, How looks your 'aplay -l' output?

**** List of PLAYBACK Hardware Devices ****
card 0: au8810 [au8810], device 0: AU88x0 ADB [adb]
  Subdevices: 16/16
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15
card 0: au8810 [au8810], device 1: AU88x0 SPDIF [spdif]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: au8810 [au8810], device 2: AU88x0 A3D [a3d]
  Subdevices: 16/16
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15

> BTW, I found fine au88x0 datasheet there:
> http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/techpaper.html

He's the guy how has done the reverse engineering.

BYtE
philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
