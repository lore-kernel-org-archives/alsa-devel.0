From: Niels Mayer <nielsmayer@gmail.com>
Subject: Re: VIA VT1708S
Date: Tue, 10 Aug 2010 08:57:47 -0700
Message-ID: <AANLkTikP65ASMC4ChTcPH564EsK44wpZ1EndN83nvNGs@mail.gmail.com>
References: <19374822.165450.1281361435671.JavaMail.www@wwinf8214>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1B92450C
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 17:57:48 +0200 (CEST)
Received: by pxi14 with SMTP id 14so144941pxi.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 08:57:47 -0700 (PDT)
In-Reply-To: <19374822.165450.1281361435671.JavaMail.www@wwinf8214>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "dominique.baudelin" <dominique.baudelin@laposte.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 9, 2010 at 6:43 AM, dominique.baudelin
<dominique.baudelin@laposte.net> wrote:
> Asus Notebook X70 Series X70AD Athlon M300-64 Ati Radeon HD 4570
> OS Lucid Lynx 10.04 LTS
> Audio chipset VIA VT1708S
>
> P.S.:If you aren't the good interlocutor I am sorry to disturb you.

The vt1708 "just works" with recent versions of linux kernels. On my
system it calls itself "SB" (soundblaster?)

> aplay -l
...
card 1: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 1: SB [HDA ATI SB], device 1: VT1708S Digital [VT1708S Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
...

For my particular ALSA usage where I wanted SPDIF output doubled w/
analog output, see "mythcd" and "mythtv" controlling card "SB" in
http://nielsmayer.com/npm/dot-asoundrc.txt

Also, some setups (like my ASUS_M4A78T-E mobo ) the vt1708S gives you
a additional HDMI device you may never use, yet it uses an interrupt
and an ALSA audio device.

##  1 [SB             ]: HDA-Intel - HDA ATI SB
##                       HDA ATI SB at 0xfb7f4000 irq 16
##  2 [HDMI           ]: HDA-Intel - HDA ATI HDMI
##                       HDA ATI HDMI at 0xfb9fc000 irq 19

It can be disabled (allowing some other ALSA device to be bound to
card slot 2)  with the following in /etc/modprobe.d/

alias snd-card-1 snd-hda-intel
#alias snd-card-2 snd-hda-intel
##
## disable HDMI device to conserve resources and interrupts
## 'modinfo -p snd-hda-intel' indicates this param will do the trick:
## enable:Enable Intel HD audio interface. (array of bool)
##
options snd-hda-intel index=1,2 enable=1,0

-- Niels
http://nielsmayer.com
