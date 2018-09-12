From: =?UTF-8?Q?H=C3=A5vard?= <hovardslill@gmail.com>
Subject: Re: Microphone detected,
 but no output for all ASUS G751xx with ALC668 chipset
Date: Wed, 12 Sep 2018 19:11:07 +0200
Message-ID: <CANweNF5LYqC04366UZ0LMo_F8Rc4B4+p9it500eqWauzHAdwHA@mail.gmail.com>
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
 <CANweNF4dxH_abm=sFNEyx-V_05Wo_ZYdMZ_juDMq2imBbBGUhg@mail.gmail.com>
 <CANweNF5izh93N_RS04wO2eihYnx2-_iBjtFw-_1O60027H9M6g@mail.gmail.com>
 <CAM8Agx1Z2KjeSx1otGM8Y=MC=r=HzwNiZzwhuNpKa2EVHkKS=g@mail.gmail.com>
 <CAM8Agx2HAApKVa-ZE3qJ58_h=VX4jX2zTvSqd4HEd6Zd-g1XHg@mail.gmail.com>
 <CAM8Agx1X9xr0LwUcxXZ8w0i+9DGC+gT82p6ocNbQOgJwD9UOcA@mail.gmail.com>
 <CANweNF4Q9CE5-fO-WJmX9pmaZTOt8U6A7Ey6ELEEhdskrOWw9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000e1b88b0575afad01"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D77C9267815
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 19:11:21 +0200 (CEST)
Received: by mail-yb1-f182.google.com with SMTP id v10-v6so2026852ybm.8
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 10:11:21 -0700 (PDT)
In-Reply-To: <CANweNF4Q9CE5-fO-WJmX9pmaZTOt8U6A7Ey6ELEEhdskrOWw9g@mail.gmail.com>
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

--000000000000e1b88b0575afad01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this is right!

I first booted up, then tested speakers (That I could not hear) and then
tested microphone (Which worked perfectly) in windows settings.

(My first email was dissaproved as it was too large)

Den ons. 12. sep. 2018 kl. 19:05 skrev H=C3=A5vard <hovardslill@gmail.com>:

> I think this is right!
>
> I first booted up, then tested speakers (That I could not hear) and then
> tested microphone (Which worked perfectly) in windows settings.
>
> -H=C3=A5vard
>
> Den ons. 12. sep. 2018 kl. 18:49 skrev Connor McAdams <
> conmanx360@gmail.com>:
>
>> Also, sorry to keep sending more replies, make sure the only trace you
>> have on is vfio_region_write, and not the read one. The read spams up
>> the console.
>>
>> On Wed, Sep 12, 2018 at 12:43 PM, Connor McAdams <conmanx360@gmail.com>
>> wrote:
>> > Reason being, it may not have identified the CORB buffer properly or
>> > something. That's very odd to have no data. Never seen that before.
>> >
>> > On Wed, Sep 12, 2018 at 12:42 PM, Connor McAdams <conmanx360@gmail.com=
>
>> wrote:
>> >> Could you try again and make a copy of your terminal output?
>> >>
>> >> On Wed, Sep 12, 2018 at 12:41 PM, H=C3=A5vard <hovardslill@gmail.com>
>> wrote:
>> >>> Hi again.
>> >>> Sorry for not noticing all files were empty, did it not run for long
>> enough?
>> >>>
>> >>> -H=C3=A5vard
>> >>>
>> >>> Den ons. 12. sep. 2018 kl. 18:39 skrev H=C3=A5vard <hovardslill@gmai=
l.com
>> >:
>> >>>>
>> >>>> Sorry my bad again it was working perfectly, just missed a step.
>> >>>>
>> >>>> I'll add the dumps as an attatchment. I had both external headset a=
nd
>> >>>> microphone plugged in and let the VM run in the background for
>> ~30min while
>> >>>> doing other stuff. I did not play music or test my microphone in th=
e
>> VM
>> >>>> either, If i did anything wrong, please tell me!
>> >>>>
>> >>>> It stopped at 0x104f4
>> >>>>
>> >>>> -H=C3=A5vard
>> >>>>
>> >>>> Den ons. 12. sep. 2018 kl. 00:31 skrev Connor McAdams
>> >>>> <conmanx360@gmail.com>:
>> >>>>>
>> >>>>> Hm.... that's odd. They should show up in the folder you ran the
>> >>>>> command from. Does your console show any "DumpMem entered..." or
>> >>>>> something like that? You may have a permissions error. I've had so=
me
>> >>>>> people report that as an issue before.
>> >>>>>
>> >>>>> On Tue, Sep 11, 2018 at 5:08 PM, H=C3=A5vard <hovardslill@gmail.co=
m>
>> wrote:
>> >>>>> > Hi!
>> >>>>> >
>> >>>>> > Took a while, but I think I got it working. Did not see any
>> "frame[xx]"
>> >>>>> > files though. What dumps do you want?
>> >>>>> >
>> >>>>> > -H=C3=A5vard
>> >>>>> >
>> >>>>> > Den tir. 11. sep. 2018 kl. 21:27 skrev H=C3=A5vard <
>> hovardslill@gmail.com>:
>> >>>>> >>
>> >>>>> >> Sorry about that, I forgot to enable a kernel config...
>> >>>>> >>
>> >>>>> >> -H=C3=A5vard
>> >>>>> >>
>> >>>>> >> Den tir. 11. sep. 2018 kl. 21:20 skrev Connor McAdams
>> >>>>> >> <conmanx360@gmail.com>:
>> >>>>> >>>
>> >>>>> >>> When it's bound as a stub, it shouldn't show up in alsamixer
>> >>>>> >>> controls.
>> >>>>> >>> You can check what module is loaded by doing lspci -v . It
>> should say
>> >>>>> >>> kernel driver in use: pci-stub. Also, did you run the vfio-bin=
d
>> >>>>> >>> script
>> >>>>> >>> before trying it?
>> >>>>> >>>
>> >>>>> >>> On Tue, Sep 11, 2018 at 3:18 PM, H=C3=A5vard <hovardslill@gmai=
l.com>
>> >>>>> >>> wrote:
>> >>>>> >>> > Thank you for the offer!
>> >>>>> >>> >
>> >>>>> >>> > I run gentoo, but your github guide is very useful. I can't
>> seem to
>> >>>>> >>> > bind my
>> >>>>> >>> > audio driver to a pci-stud. Is the Sound card still supposed
>> to
>> >>>>> >>> > function as
>> >>>>> >>> > normal when I (think I) have bound it to a stud.
>> >>>>> >>> >
>> >>>>> >>> > -H=C3=A5vard
>> >>>>> >>> >
>> >>>>> >>> > Den tir. 11. sep. 2018 kl. 20:26 skrev Connor McAdams
>> >>>>> >>> > <conmanx360@gmail.com>:
>> >>>>> >>> >>
>> >>>>> >>> >> One thing you could try, is using the program I used to
>> reverse
>> >>>>> >>> >> engineer the Sound Blaster Z series of cards, QemuHDADump.
>> If your
>> >>>>> >>> >> processor supports pci-passthrough with a virtual machine,
>> you
>> >>>>> >>> >> could
>> >>>>> >>> >> run a Windows virtual machine with the sound card in it and
>> >>>>> >>> >> capture
>> >>>>> >>> >> the commands. I'd be willing to look through the dumps to
>> see if
>> >>>>> >>> >> there
>> >>>>> >>> >> are any special verbs or anything.
>> >>>>> >>> >>
>> >>>>> >>> >> You can find the program here:
>> >>>>> >>> >> https://github.com/Conmanx360/QemuHDADump
>> >>>>> >>> >>
>> >>>>> >>> >> Let me know.
>> >>>>> >>> >>
>> >>>>> >>> >> On Tue, Sep 11, 2018 at 2:15 PM, H=C3=A5vard <
>> hovardslill@gmail.com>
>> >>>>> >>> >> wrote:
>> >>>>> >>> >> > Sorry, my gmail didn't update so I wrote my response
>> before I
>> >>>>> >>> >> > read
>> >>>>> >>> >> > your
>> >>>>> >>> >> > last one.
>> >>>>> >>> >> >
>> >>>>> >>> >> > It is a separate mic port as the G751JT doesn't have any
>> headset
>> >>>>> >>> >> > multijacks.
>> >>>>> >>> >> >
>> >>>>> >>> >> > I'll try and dig around in the kernel! Thanks for the tip=
!
>> >>>>> >>> >> >
>> >>>>> >>> >> > -H=C3=A5vard
>> >>>>> >>> >> >
>> >>>>> >>> >> > Den tir. 11. sep. 2018 kl. 20:09 skrev H=C3=A5vard
>> >>>>> >>> >> > <hovardslill@gmail.com>:
>> >>>>> >>> >> >
>> >>>>> >>> >> >> Thank you for taking your time and trying to help! :)
>> >>>>> >>> >> >>
>> >>>>> >>> >> >> Do you know where I can ask around for more help on the
>> issue?
>> >>>>> >>> >> >> I
>> >>>>> >>> >> >> don't
>> >>>>> >>> >> >> want to give up yet.
>> >>>>> >>> >> >>
>> >>>>> >>> >> >> -H=C3=A5vard
>> >>>>> >>> >> >>
>> >>>>> >>> >> >> Den tir. 11. sep. 2018 kl. 20:02 skrev Takashi Iwai
>> >>>>> >>> >> >> <tiwai@suse.de>:
>> >>>>> >>> >> >>
>> >>>>> >>> >> >>> On Tue, 11 Sep 2018 19:14:37 +0200,
>> >>>>> >>> >> >>> H=C3=A5vard wrote:
>> >>>>> >>> >> >>> >
>> >>>>> >>> >> >>> > Yes, microphone gets detected instantly and it
>> automatically
>> >>>>> >>> >> >>> > changes
>> >>>>> >>> >> >>> > to
>> >>>>> >>> >> >>> it
>> >>>>> >>> >> >>> > in pavucontrol.
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>> Then it likely requires some additional initialization
>> outside
>> >>>>> >>> >> >>> HD-audio.  It's hard to know, as it's pretty much
>> >>>>> >>> >> >>> vendor-specific.
>> >>>>> >>> >> >>> You can dig down the Windows, but I have no idea about
>> Windows
>> >>>>> >>> >> >>> implementation, so can't give any hints, unfortunately.
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>> Takashi
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>> >
>> >>>>> >>> >> >>> > Den tir. 11. sep. 2018 kl. 18:52 skrev Takashi Iwai
>> >>>>> >>> >> >>> > <tiwai@suse.de>:
>> >>>>> >>> >> >>> >
>> >>>>> >>> >> >>> > > On Tue, 11 Sep 2018 18:40:23 +0200,
>> >>>>> >>> >> >>> > > H=C3=A5vard wrote:
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > Thank you for replying!
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > Enabling loopback in alsamixer:
>> >>>>> >>> >> >>> > > > http://i.imgur.com/lNo6e7T.png
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > And unmuting more and more things in "Mic Playbac=
k
>> >>>>> >>> >> >>> > > > Volume"
>> >>>>> >>> >> >>> > > > in
>> >>>>> >>> >> >>> > > hdaanalyzer:
>> >>>>> >>> >> >>> > > > http://i.imgur.com/H0HiOhy.png
>> >>>>> >>> >> >>> > > > made white noise come from the headset. However i=
t
>> did
>> >>>>> >>> >> >>> > > > not
>> >>>>> >>> >> >>> > > > change or
>> >>>>> >>> >> >>> > > react
>> >>>>> >>> >> >>> > > > at all when I talked or even muted the microphone
>> >>>>> >>> >> >>> > > > physically.
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > I couldn't find "Mic Playback Switch" anywhere in
>> either
>> >>>>> >>> >> >>> > > > alsamixer
>> >>>>> >>> >> >>> or
>> >>>>> >>> >> >>> > > > hdaanalyzer.
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > It's a mixer mute switch.
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > > The microphone works perfectly fine under Windows=
,
>> so I
>> >>>>> >>> >> >>> > > > don't
>> >>>>> >>> >> >>> > > > think
>> >>>>> >>> >> >>> it is
>> >>>>> >>> >> >>> > > > the mic pin.
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > But the fact above indicates the possibility of the
>> wrong
>> >>>>> >>> >> >>> > > pin,
>> >>>>> >>> >> >>> > > too.
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > Does the jack detection of the ext mic pin work?
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > Takashi
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > -H=C3=A5vard
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > Den man. 10. sep. 2018 kl. 22:39 skrev Takashi Iw=
ai
>> >>>>> >>> >> >>> > > > <tiwai@suse.de
>> >>>>> >>> >> >>> >:
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > > > > On Thu, 06 Sep 2018 20:44:30 +0200,
>> >>>>> >>> >> >>> > > > > H=C3=A5vard wrote:
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > Additional relevant info:
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > A similar issue was also discussed three year=
s
>> ago
>> >>>>> >>> >> >>> > > > > > on
>> >>>>> >>> >> >>> > > > > > Sun
>> >>>>> >>> >> >>> > > > > > Jun
>> >>>>> >>> >> >>> > > 17:15:54
>> >>>>> >>> >> >>> > > > > CEST
>> >>>>> >>> >> >>> > > > > > 2015 and was about his surround sound setup,
>> but did
>> >>>>> >>> >> >>> > > > > > not
>> >>>>> >>> >> >>> > > > > > touch
>> >>>>> >>> >> >>> on the
>> >>>>> >>> >> >>> > > > > > external microphone problem:
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093317.ht=
ml
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > alsa-info.sh:
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>>
>> http://www.alsa-project.org/db/?f=3D1d8616ba5977308e03db6c3a86e36e9e9b38=
d6f0
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > Graph of ALC668 chipset from hdaanalyzer:
>> >>>>> >>> >> >>> > > > > > http://i.imgur.com/c08DNJW.png
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > setting alsa-mode[1-8] does nothing to help t=
he
>> >>>>> >>> >> >>> > > > > > issue.
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > There are several of similar bug reports
>> around the
>> >>>>> >>> >> >>> > > > > > web
>> >>>>> >>> >> >>> experiencing
>> >>>>> >>> >> >>> > > > > > similar issues, and on different distros.
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > Microphone works perfectly in windows
>> >>>>> >>> >> >>> > > > > >
>> >>>>> >>> >> >>> > > > > > I have a ASUS ROG G751JT, but this problem
>> seems to
>> >>>>> >>> >> >>> > > > > > happen
>> >>>>> >>> >> >>> > > > > > with
>> >>>>> >>> >> >>> all
>> >>>>> >>> >> >>> > > > > laptops
>> >>>>> >>> >> >>> > > > > > under the G751 name.
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > > > > When you enable the loopback volume and switch,
>> and
>> >>>>> >>> >> >>> > > > > unmute/adjust
>> >>>>> >>> >> >>> "Mic
>> >>>>> >>> >> >>> > > > > Playback Volume", and "Mic Playback Switch", do
>> you
>> >>>>> >>> >> >>> > > > > hear
>> >>>>> >>> >> >>> > > > > the
>> >>>>> >>> >> >>> > > > > input
>> >>>>> >>> >> >>> > > > > from the ext mic?  It's a route directly from
>> NID 0x18
>> >>>>> >>> >> >>> > > > > to
>> >>>>> >>> >> >>> > > > > the
>> >>>>> >>> >> >>> mixer
>> >>>>> >>> >> >>> > > > > NID 0x0b, then output mixer NID 0x0c, then
>> outputs.
>> >>>>> >>> >> >>> > > > > So
>> >>>>> >>> >> >>> > > > > this
>> >>>>> >>> >> >>> > > > > can
>> >>>>> >>> >> >>> be
>> >>>>> >>> >> >>> > > > > used to verify the hardware routing.
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > > > > If you don't hear via this route, it means that
>> the
>> >>>>> >>> >> >>> > > > > input
>> >>>>> >>> >> >>> > > > > from
>> >>>>> >>> >> >>> the ext
>> >>>>> >>> >> >>> > > > > mic pin itself is broken, and it implies that
>> >>>>> >>> >> >>> > > > > something
>> >>>>> >>> >> >>> > > > > outside
>> >>>>> >>> >> >>> > > > > HD-audio codec.
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > > > > Takashi
>> >>>>> >>> >> >>> > > > >
>> >>>>> >>> >> >>> > > > [2  <text/html; UTF-8 (quoted-printable)>]
>> >>>>> >>> >> >>> > > >
>> >>>>> >>> >> >>> > >
>> >>>>> >>> >> >>> > [2  <text/html; UTF-8 (quoted-printable)>]
>> >>>>> >>> >> >>> >
>> >>>>> >>> >> >>>
>> >>>>> >>> >> >>
>> >>>>> >>> >> > _______________________________________________
>> >>>>> >>> >> > Alsa-devel mailing list
>> >>>>> >>> >> > Alsa-devel@alsa-project.org
>> >>>>> >>> >> >
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>

--000000000000e1b88b0575afad01
Content-Type: application/gzip; name="Dump.tar.gz"
Content-Disposition: attachment; filename="Dump.tar.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_jlzej1bd0>
X-Attachment-Id: f_jlzej1bd0

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
--000000000000e1b88b0575afad01
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000000000000e1b88b0575afad01--
