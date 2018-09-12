From: =?UTF-8?Q?H=C3=A5vard?= <hovardslill@gmail.com>
Subject: Re: Microphone detected,
 but no output for all ASUS G751xx with ALC668 chipset
Date: Wed, 12 Sep 2018 18:39:13 +0200
Message-ID: <CANweNF4dxH_abm=sFNEyx-V_05Wo_ZYdMZ_juDMq2imBbBGUhg@mail.gmail.com>
References: <CANweNF44RJMWB-eDa9AkLKV87DVppqjBPVHdQf2ycJ4V=Gga3A@mail.gmail.com>
 <s5hin3d2ik0.wl-tiwai@suse.de>
 <CANweNF4c9t6KtnQMv6i9=-nJ4Sg9r4Ai10KtG_Cdxqm404QaUg@mail.gmail.com>
 <s5hbm94ou29.wl-tiwai@suse.de>
 <CANweNF5PpzufjnRQk2gpqw1+kU8TK86RAj-topURG-FAHeYxcA@mail.gmail.com>
 <s5h7ejrq5dd.wl-tiwai@suse.de>
 <CANweNF5kcSDAxPXDqnyAEvh9bwYg61_F4XhaLjGrpEXZnvvNew@mail.gmail.com>
 <CANweNF7d8Z7qFw2cMkUH4F4r6P=Ms-=WVbFYrMX+O+uZkV4cwg@mail.gmail.com>
 <CAM8Agx2QibKCdPg5FLDqgcP-O7PwPN1L4iNT=6Ae53T5=d=+uw@mail.gmail.com>
 <CANweNF5fjLyfEyE+gCYugpfW_+LP2HYFMPfuWi_O0nxizFLdXg@mail.gmail.com>
 <CAM8Agx0Y+7c_ZQrwzX6R0yRNHTeHoMPAt6zLtU9VKqHAo42TeQ@mail.gmail.com>
 <CANweNF50zpunkO4XOeZh_SWsceeQ5SRWdYAXQ21c69oGfFGzhA@mail.gmail.com>
 <CANweNF718RNadfxV9+Du0VZ4Cx-ufG0ehN1pzP09z41aXUA0Vw@mail.gmail.com>
 <CAM8Agx0H=WdExmbPmtpvYD7hgzNS_jQVfyQy_g8W+yXzqu_rSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000c7ef1a0575af3b4f"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7782673F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 18:39:27 +0200 (CEST)
Received: by mail-yb1-f182.google.com with SMTP id j8-v6so1941007ybg.9
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 09:39:27 -0700 (PDT)
In-Reply-To: <CAM8Agx0H=WdExmbPmtpvYD7hgzNS_jQVfyQy_g8W+yXzqu_rSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--000000000000c7ef1a0575af3b4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry my bad again it was working perfectly, just missed a step.

I'll add the dumps as an attatchment. I had both external headset and
microphone plugged in and let the VM run in the background for ~30min while
doing other stuff. I did not play music or test my microphone in the VM
either, If i did anything wrong, please tell me!

It stopped at 0x104f4

-H=C3=A5vard

Den ons. 12. sep. 2018 kl. 00:31 skrev Connor McAdams <conmanx360@gmail.com
>:

> Hm.... that's odd. They should show up in the folder you ran the
> command from. Does your console show any "DumpMem entered..." or
> something like that? You may have a permissions error. I've had some
> people report that as an issue before.
>
> On Tue, Sep 11, 2018 at 5:08 PM, H=C3=A5vard <hovardslill@gmail.com> wrot=
e:
> > Hi!
> >
> > Took a while, but I think I got it working. Did not see any "frame[xx]"
> > files though. What dumps do you want?
> >
> > -H=C3=A5vard
> >
> > Den tir. 11. sep. 2018 kl. 21:27 skrev H=C3=A5vard <hovardslill@gmail.c=
om>:
> >>
> >> Sorry about that, I forgot to enable a kernel config...
> >>
> >> -H=C3=A5vard
> >>
> >> Den tir. 11. sep. 2018 kl. 21:20 skrev Connor McAdams
> >> <conmanx360@gmail.com>:
> >>>
> >>> When it's bound as a stub, it shouldn't show up in alsamixer controls=
.
> >>> You can check what module is loaded by doing lspci -v . It should say
> >>> kernel driver in use: pci-stub. Also, did you run the vfio-bind scrip=
t
> >>> before trying it?
> >>>
> >>> On Tue, Sep 11, 2018 at 3:18 PM, H=C3=A5vard <hovardslill@gmail.com> =
wrote:
> >>> > Thank you for the offer!
> >>> >
> >>> > I run gentoo, but your github guide is very useful. I can't seem to
> >>> > bind my
> >>> > audio driver to a pci-stud. Is the Sound card still supposed to
> >>> > function as
> >>> > normal when I (think I) have bound it to a stud.
> >>> >
> >>> > -H=C3=A5vard
> >>> >
> >>> > Den tir. 11. sep. 2018 kl. 20:26 skrev Connor McAdams
> >>> > <conmanx360@gmail.com>:
> >>> >>
> >>> >> One thing you could try, is using the program I used to reverse
> >>> >> engineer the Sound Blaster Z series of cards, QemuHDADump. If your
> >>> >> processor supports pci-passthrough with a virtual machine, you cou=
ld
> >>> >> run a Windows virtual machine with the sound card in it and captur=
e
> >>> >> the commands. I'd be willing to look through the dumps to see if
> there
> >>> >> are any special verbs or anything.
> >>> >>
> >>> >> You can find the program here:
> >>> >> https://github.com/Conmanx360/QemuHDADump
> >>> >>
> >>> >> Let me know.
> >>> >>
> >>> >> On Tue, Sep 11, 2018 at 2:15 PM, H=C3=A5vard <hovardslill@gmail.co=
m>
> wrote:
> >>> >> > Sorry, my gmail didn't update so I wrote my response before I re=
ad
> >>> >> > your
> >>> >> > last one.
> >>> >> >
> >>> >> > It is a separate mic port as the G751JT doesn't have any headset
> >>> >> > multijacks.
> >>> >> >
> >>> >> > I'll try and dig around in the kernel! Thanks for the tip!
> >>> >> >
> >>> >> > -H=C3=A5vard
> >>> >> >
> >>> >> > Den tir. 11. sep. 2018 kl. 20:09 skrev H=C3=A5vard
> >>> >> > <hovardslill@gmail.com>:
> >>> >> >
> >>> >> >> Thank you for taking your time and trying to help! :)
> >>> >> >>
> >>> >> >> Do you know where I can ask around for more help on the issue? =
I
> >>> >> >> don't
> >>> >> >> want to give up yet.
> >>> >> >>
> >>> >> >> -H=C3=A5vard
> >>> >> >>
> >>> >> >> Den tir. 11. sep. 2018 kl. 20:02 skrev Takashi Iwai
> >>> >> >> <tiwai@suse.de>:
> >>> >> >>
> >>> >> >>> On Tue, 11 Sep 2018 19:14:37 +0200,
> >>> >> >>> H=C3=A5vard wrote:
> >>> >> >>> >
> >>> >> >>> > Yes, microphone gets detected instantly and it automatically
> >>> >> >>> > changes
> >>> >> >>> > to
> >>> >> >>> it
> >>> >> >>> > in pavucontrol.
> >>> >> >>>
> >>> >> >>> Then it likely requires some additional initialization outside
> >>> >> >>> HD-audio.  It's hard to know, as it's pretty much
> vendor-specific.
> >>> >> >>> You can dig down the Windows, but I have no idea about Windows
> >>> >> >>> implementation, so can't give any hints, unfortunately.
> >>> >> >>>
> >>> >> >>>
> >>> >> >>> Takashi
> >>> >> >>>
> >>> >> >>> >
> >>> >> >>> > Den tir. 11. sep. 2018 kl. 18:52 skrev Takashi Iwai
> >>> >> >>> > <tiwai@suse.de>:
> >>> >> >>> >
> >>> >> >>> > > On Tue, 11 Sep 2018 18:40:23 +0200,
> >>> >> >>> > > H=C3=A5vard wrote:
> >>> >> >>> > > >
> >>> >> >>> > > > Thank you for replying!
> >>> >> >>> > > >
> >>> >> >>> > > > Enabling loopback in alsamixer:
> >>> >> >>> > > > http://i.imgur.com/lNo6e7T.png
> >>> >> >>> > > >
> >>> >> >>> > > > And unmuting more and more things in "Mic Playback Volum=
e"
> >>> >> >>> > > > in
> >>> >> >>> > > hdaanalyzer:
> >>> >> >>> > > > http://i.imgur.com/H0HiOhy.png
> >>> >> >>> > > > made white noise come from the headset. However it did n=
ot
> >>> >> >>> > > > change or
> >>> >> >>> > > react
> >>> >> >>> > > > at all when I talked or even muted the microphone
> >>> >> >>> > > > physically.
> >>> >> >>> > > >
> >>> >> >>> > > > I couldn't find "Mic Playback Switch" anywhere in either
> >>> >> >>> > > > alsamixer
> >>> >> >>> or
> >>> >> >>> > > > hdaanalyzer.
> >>> >> >>> > >
> >>> >> >>> > > It's a mixer mute switch.
> >>> >> >>> > >
> >>> >> >>> > > > The microphone works perfectly fine under Windows, so I
> >>> >> >>> > > > don't
> >>> >> >>> > > > think
> >>> >> >>> it is
> >>> >> >>> > > > the mic pin.
> >>> >> >>> > >
> >>> >> >>> > > But the fact above indicates the possibility of the wrong
> pin,
> >>> >> >>> > > too.
> >>> >> >>> > >
> >>> >> >>> > > Does the jack detection of the ext mic pin work?
> >>> >> >>> > >
> >>> >> >>> > >
> >>> >> >>> > > Takashi
> >>> >> >>> > >
> >>> >> >>> > > >
> >>> >> >>> > > > -H=C3=A5vard
> >>> >> >>> > > >
> >>> >> >>> > > > Den man. 10. sep. 2018 kl. 22:39 skrev Takashi Iwai
> >>> >> >>> > > > <tiwai@suse.de
> >>> >> >>> >:
> >>> >> >>> > > >
> >>> >> >>> > > > > On Thu, 06 Sep 2018 20:44:30 +0200,
> >>> >> >>> > > > > H=C3=A5vard wrote:
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > Additional relevant info:
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > A similar issue was also discussed three years ago o=
n
> >>> >> >>> > > > > > Sun
> >>> >> >>> > > > > > Jun
> >>> >> >>> > > 17:15:54
> >>> >> >>> > > > > CEST
> >>> >> >>> > > > > > 2015 and was about his surround sound setup, but did
> not
> >>> >> >>> > > > > > touch
> >>> >> >>> on the
> >>> >> >>> > > > > > external microphone problem:
> >>> >> >>> > > > > >
> >>> >> >>> > > > >
> >>> >> >>> > >
> >>> >> >>>
> >>> >> >>>
> >>> >> >>>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093317.htm=
l
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > alsa-info.sh:
> >>> >> >>> > > > > >
> >>> >> >>> > > > >
> >>> >> >>> > >
> >>> >> >>>
> >>> >> >>>
> >>> >> >>>
> http://www.alsa-project.org/db/?f=3D1d8616ba5977308e03db6c3a86e36e9e9b38d=
6f0
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > Graph of ALC668 chipset from hdaanalyzer:
> >>> >> >>> > > > > > http://i.imgur.com/c08DNJW.png
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > setting alsa-mode[1-8] does nothing to help the issu=
e.
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > There are several of similar bug reports around the
> web
> >>> >> >>> experiencing
> >>> >> >>> > > > > > similar issues, and on different distros.
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > Microphone works perfectly in windows
> >>> >> >>> > > > > >
> >>> >> >>> > > > > > I have a ASUS ROG G751JT, but this problem seems to
> >>> >> >>> > > > > > happen
> >>> >> >>> > > > > > with
> >>> >> >>> all
> >>> >> >>> > > > > laptops
> >>> >> >>> > > > > > under the G751 name.
> >>> >> >>> > > > >
> >>> >> >>> > > > > When you enable the loopback volume and switch, and
> >>> >> >>> > > > > unmute/adjust
> >>> >> >>> "Mic
> >>> >> >>> > > > > Playback Volume", and "Mic Playback Switch", do you he=
ar
> >>> >> >>> > > > > the
> >>> >> >>> > > > > input
> >>> >> >>> > > > > from the ext mic?  It's a route directly from NID 0x18
> to
> >>> >> >>> > > > > the
> >>> >> >>> mixer
> >>> >> >>> > > > > NID 0x0b, then output mixer NID 0x0c, then outputs.  S=
o
> >>> >> >>> > > > > this
> >>> >> >>> > > > > can
> >>> >> >>> be
> >>> >> >>> > > > > used to verify the hardware routing.
> >>> >> >>> > > > >
> >>> >> >>> > > > > If you don't hear via this route, it means that the
> input
> >>> >> >>> > > > > from
> >>> >> >>> the ext
> >>> >> >>> > > > > mic pin itself is broken, and it implies that somethin=
g
> >>> >> >>> > > > > outside
> >>> >> >>> > > > > HD-audio codec.
> >>> >> >>> > > > >
> >>> >> >>> > > > >
> >>> >> >>> > > > > Takashi
> >>> >> >>> > > > >
> >>> >> >>> > > > [2  <text/html; UTF-8 (quoted-printable)>]
> >>> >> >>> > > >
> >>> >> >>> > >
> >>> >> >>> > [2  <text/html; UTF-8 (quoted-printable)>]
> >>> >> >>> >
> >>> >> >>>
> >>> >> >>
> >>> >> > _______________________________________________
> >>> >> > Alsa-devel mailing list
> >>> >> > Alsa-devel@alsa-project.org
> >>> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

--000000000000c7ef1a0575af3b4f
Content-Type: application/gzip; name="ALC668dump.tar.gz"
Content-Disposition: attachment; filename="ALC668dump.tar.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_jlzddymr0>
X-Attachment-Id: f_jlzddymr0

H4sIAO9AmVsAA+3d22odRxAFUH2K/iDT0zf50eTVP2FI8mYcFPv/I2nOKGaaXNqUaJKsBUKWbSjB
edtU73r/4cfWHn76+unXH+7eyvak1/ry/cn1+8ufU86l7WXLab/bUspbvruvb/YbfePrb18+Pt7f
3z1+/vzlr/7f3/37v9T7Pz7/Xx4/fvo59fgZzx9wK+VPPv/0zeefy773p89/L63f3W/xv8rof/75
AwAAAP991/yn5vgZE/lPP/Ofvst/AAAAACJc85/tXfyMifwn15SP/Z8q/wEAAACIMOQ/D/EzZvKf
UrYj/8nyHwAAAIAI1/xnX/v+6+nr9v5rk/8AAAAARBj6n0v8jJn8Zzv7n/X/AAAAAIQY8p8WP2Mm
/0nPd+Ke858m/wEAAACIcM1/ytr9n1bO91/6fwAAAABCXPOfvPb+V0vb7v4XAAAAQKAh/1nb/1zr
mf/o/wEAAAAIMbz/Wrz/04/+n7oV+Q8AAABAhCH/eYifMZX/3PZ/9P8AAAAAxLjmP9seP2Mi/8kp
Hfe/qv0fAAAAgBDX/Kf2+BkT+U8/+3+6/h8AAACAENf8p71B6DKT/5zvv1qT/wAAAABEGPp/1t7/
avnof7b/AwAAABDkmv/sa/ufa5L/AAAAAIS65j9p7fuvXNuR/zT9zwAAAAAhhvtfi/Of1/tf9n8A
AAAAQgz9z0v7f8rTT0f/c63yHwAAAIAIw/33Ej9j5v5XPu9/yX8AAAAAQgz9P3v8jJn3Xz3lI/9J
8h8AAACACMP9r7X9P6Xs/ch/svwHAAAAIMKQ/6x9/1X6+f5L/gMAAAAQYrj/leJnfNf9L/kPAAAA
QIhr/pN7/IyJ/Kf2+pL/1Ke/kv8AAAAABBj2f2r8jJn9n71sx/5Pk/8AAAAARBjuv7f4GTP338/+
597lPwAAAAARrvlPWfv+q7Uj//H+CwAAACDIcP9r7fuvcuv/Kb3IfwAAAAAiDPnPHj9jJv+pt/yn
ef8FAAAAEGLo/3mInzHT/1PP+1/uvwMAAACEGPKfte+/ej7ff7n/BQAAABDimv/ktfs/bTvvf+3y
HwAAAIAIw/2vFD9jJv/Zb/lPs/8DAAAAEGLY/ynxMybyn3r2P3f9PwAAAAAhhvxnbf9Pbef7L/ff
AQAAAEIM/c9r77/3dO7/JPkPAAAAQIRr/tOW5j9lO/ufm/5nAAAAgBDX/Cet7X/OrWwv+U/t8h8A
AACACMP7r3fxM2bef936f+qm/wcAAAAgxPD+a+3+T+9n/4/9HwAAAIAQ1/xnX7v/U/fz/pf77wAA
AAAhhvvva/d/ar7t/7Qm/wEAAACIcM1/SoufMZH/tOr9FwAAAECoYf9n6f33XMt5/13+AwAAABDi
mv9sa/d/ck75yH82+Q8AAABAhKH/eW3+U7dz/0f/DwAAAECIYf+nx8+Y2v9pt/4f+z8AAAAAIa75
T1p7/72c97/cfwcAAACIMez/5PgZM/s/aS8v+U+t8h8AAACACEP/T4qfMbP/U7f9yH/0/wAAAACE
uOY/dW3+09Mt/3H/CwAAACDGsP+ztv+5vuY/Sf4DAAAAEGHY/3mD0GVm/+f1/rv+HwAAAIAQw/2v
xf3Pvbbj/pf9HwAAAIAQ1/ynlfgZ/zz/KVu63X9v+p8BAAAAQlzzn7LHz5jY/2lZ/w8AAABAqGv+
k1v8jJn+537mP13+AwAAABBh2P9Z2//cXt9/6X8GAAAACHHNf95ixkz/z57Kc/6T0yb/AQAAAIgw
7P/U+Bkz+z/1fP+l/xkAAAAgxDX/2Zbe/8o5tdv7ryz/AQAAAIhwzX/SQ/yMifynvN7/2uU/AAAA
ABGG/Gft+6+SbvlP1f8MAAAAEGK4/772/lfN8h8AAAAAAAD4br8Dta4EEACwBAA=
--000000000000c7ef1a0575af3b4f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000000000000c7ef1a0575af3b4f--
