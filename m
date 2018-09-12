From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: Microphone detected,
 but no output for all ASUS G751xx with ALC668 chipset
Date: Wed, 12 Sep 2018 16:01:27 -0400
Message-ID: <CAM8Agx30z8SDGvQ0L701WHQiAcV_PwEfjSnc07p-_n5CpyuGfw@mail.gmail.com>
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
 <CANweNF5LYqC04366UZ0LMo_F8Rc4B4+p9it500eqWauzHAdwHA@mail.gmail.com>
 <CANweNF7eQ88J7+2Xm_nyUwPD5TEUD2U1HgnDtBbGaYWbKeEvBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000495d290575b20e6c"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A155B2676B0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 22:01:29 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id v198-v6so6229359oif.9
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 13:01:29 -0700 (PDT)
In-Reply-To: <CANweNF7eQ88J7+2Xm_nyUwPD5TEUD2U1HgnDtBbGaYWbKeEvBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?H=C3=A5vard?= <hovardslill@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

--000000000000495d290575b20e6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I might not get around to writing the fix myself, but, here's the
COEF's from within Windows. I've marked the ones missing inside the
main init function. So, if anyone else wants to add these in, feel
free.



On Wed, Sep 12, 2018 at 1:16 PM, H=C3=A5vard <hovardslill@gmail.com> wrote:
> That was without running the program (sorry)
>
> This is output when running program:
>
> Before there was no "Current verb...."
> They came when I opened up windows microphone settings. (something I didn=
't
> do before)
>
> -H=C3=A5vard
>
> Den ons. 12. sep. 2018 kl. 19:11 skrev H=C3=A5vard <hovardslill@gmail.com=
>:
>>
>> I think this is right!
>>
>> I first booted up, then tested speakers (That I could not hear) and then
>> tested microphone (Which worked perfectly) in windows settings.
>>
>> (My first email was dissaproved as it was too large)
>>
>> Den ons. 12. sep. 2018 kl. 19:05 skrev H=C3=A5vard <hovardslill@gmail.co=
m>:
>>>
>>> I think this is right!
>>>
>>> I first booted up, then tested speakers (That I could not hear) and the=
n
>>> tested microphone (Which worked perfectly) in windows settings.
>>>
>>> -H=C3=A5vard
>>>
>>> Den ons. 12. sep. 2018 kl. 18:49 skrev Connor McAdams
>>> <conmanx360@gmail.com>:
>>>>
>>>> Also, sorry to keep sending more replies, make sure the only trace you
>>>> have on is vfio_region_write, and not the read one. The read spams up
>>>> the console.
>>>>
>>>> On Wed, Sep 12, 2018 at 12:43 PM, Connor McAdams <conmanx360@gmail.com=
>
>>>> wrote:
>>>> > Reason being, it may not have identified the CORB buffer properly or
>>>> > something. That's very odd to have no data. Never seen that before.
>>>> >
>>>> > On Wed, Sep 12, 2018 at 12:42 PM, Connor McAdams
>>>> > <conmanx360@gmail.com> wrote:
>>>> >> Could you try again and make a copy of your terminal output?
>>>> >>
>>>> >> On Wed, Sep 12, 2018 at 12:41 PM, H=C3=A5vard <hovardslill@gmail.co=
m>
>>>> >> wrote:
>>>> >>> Hi again.
>>>> >>> Sorry for not noticing all files were empty, did it not run for lo=
ng
>>>> >>> enough?
>>>> >>>
>>>> >>> -H=C3=A5vard
>>>> >>>
>>>> >>> Den ons. 12. sep. 2018 kl. 18:39 skrev H=C3=A5vard
>>>> >>> <hovardslill@gmail.com>:
>>>> >>>>
>>>> >>>> Sorry my bad again it was working perfectly, just missed a step.
>>>> >>>>
>>>> >>>> I'll add the dumps as an attatchment. I had both external headset
>>>> >>>> and
>>>> >>>> microphone plugged in and let the VM run in the background for
>>>> >>>> ~30min while
>>>> >>>> doing other stuff. I did not play music or test my microphone in
>>>> >>>> the VM
>>>> >>>> either, If i did anything wrong, please tell me!
>>>> >>>>
>>>> >>>> It stopped at 0x104f4
>>>> >>>>
>>>> >>>> -H=C3=A5vard
>>>> >>>>
>>>> >>>> Den ons. 12. sep. 2018 kl. 00:31 skrev Connor McAdams
>>>> >>>> <conmanx360@gmail.com>:
>>>> >>>>>
>>>> >>>>> Hm.... that's odd. They should show up in the folder you ran the
>>>> >>>>> command from. Does your console show any "DumpMem entered..." or
>>>> >>>>> something like that? You may have a permissions error. I've had
>>>> >>>>> some
>>>> >>>>> people report that as an issue before.
>>>> >>>>>
>>>> >>>>> On Tue, Sep 11, 2018 at 5:08 PM, H=C3=A5vard <hovardslill@gmail.=
com>
>>>> >>>>> wrote:
>>>> >>>>> > Hi!
>>>> >>>>> >
>>>> >>>>> > Took a while, but I think I got it working. Did not see any
>>>> >>>>> > "frame[xx]"
>>>> >>>>> > files though. What dumps do you want?
>>>> >>>>> >
>>>> >>>>> > -H=C3=A5vard
>>>> >>>>> >
>>>> >>>>> > Den tir. 11. sep. 2018 kl. 21:27 skrev H=C3=A5vard
>>>> >>>>> > <hovardslill@gmail.com>:
>>>> >>>>> >>
>>>> >>>>> >> Sorry about that, I forgot to enable a kernel config...
>>>> >>>>> >>
>>>> >>>>> >> -H=C3=A5vard
>>>> >>>>> >>
>>>> >>>>> >> Den tir. 11. sep. 2018 kl. 21:20 skrev Connor McAdams
>>>> >>>>> >> <conmanx360@gmail.com>:
>>>> >>>>> >>>
>>>> >>>>> >>> When it's bound as a stub, it shouldn't show up in alsamixer
>>>> >>>>> >>> controls.
>>>> >>>>> >>> You can check what module is loaded by doing lspci -v . It
>>>> >>>>> >>> should say
>>>> >>>>> >>> kernel driver in use: pci-stub. Also, did you run the
>>>> >>>>> >>> vfio-bind
>>>> >>>>> >>> script
>>>> >>>>> >>> before trying it?
>>>> >>>>> >>>
>>>> >>>>> >>> On Tue, Sep 11, 2018 at 3:18 PM, H=C3=A5vard
>>>> >>>>> >>> <hovardslill@gmail.com>
>>>> >>>>> >>> wrote:
>>>> >>>>> >>> > Thank you for the offer!
>>>> >>>>> >>> >
>>>> >>>>> >>> > I run gentoo, but your github guide is very useful. I can'=
t
>>>> >>>>> >>> > seem to
>>>> >>>>> >>> > bind my
>>>> >>>>> >>> > audio driver to a pci-stud. Is the Sound card still suppos=
ed
>>>> >>>>> >>> > to
>>>> >>>>> >>> > function as
>>>> >>>>> >>> > normal when I (think I) have bound it to a stud.
>>>> >>>>> >>> >
>>>> >>>>> >>> > -H=C3=A5vard
>>>> >>>>> >>> >
>>>> >>>>> >>> > Den tir. 11. sep. 2018 kl. 20:26 skrev Connor McAdams
>>>> >>>>> >>> > <conmanx360@gmail.com>:
>>>> >>>>> >>> >>
>>>> >>>>> >>> >> One thing you could try, is using the program I used to
>>>> >>>>> >>> >> reverse
>>>> >>>>> >>> >> engineer the Sound Blaster Z series of cards, QemuHDADump=
.
>>>> >>>>> >>> >> If your
>>>> >>>>> >>> >> processor supports pci-passthrough with a virtual machine=
,
>>>> >>>>> >>> >> you
>>>> >>>>> >>> >> could
>>>> >>>>> >>> >> run a Windows virtual machine with the sound card in it a=
nd
>>>> >>>>> >>> >> capture
>>>> >>>>> >>> >> the commands. I'd be willing to look through the dumps to
>>>> >>>>> >>> >> see if
>>>> >>>>> >>> >> there
>>>> >>>>> >>> >> are any special verbs or anything.
>>>> >>>>> >>> >>
>>>> >>>>> >>> >> You can find the program here:
>>>> >>>>> >>> >> https://github.com/Conmanx360/QemuHDADump
>>>> >>>>> >>> >>
>>>> >>>>> >>> >> Let me know.
>>>> >>>>> >>> >>
>>>> >>>>> >>> >> On Tue, Sep 11, 2018 at 2:15 PM, H=C3=A5vard
>>>> >>>>> >>> >> <hovardslill@gmail.com>
>>>> >>>>> >>> >> wrote:
>>>> >>>>> >>> >> > Sorry, my gmail didn't update so I wrote my response
>>>> >>>>> >>> >> > before I
>>>> >>>>> >>> >> > read
>>>> >>>>> >>> >> > your
>>>> >>>>> >>> >> > last one.
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> > It is a separate mic port as the G751JT doesn't have an=
y
>>>> >>>>> >>> >> > headset
>>>> >>>>> >>> >> > multijacks.
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> > I'll try and dig around in the kernel! Thanks for the
>>>> >>>>> >>> >> > tip!
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> > -H=C3=A5vard
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> > Den tir. 11. sep. 2018 kl. 20:09 skrev H=C3=A5vard
>>>> >>>>> >>> >> > <hovardslill@gmail.com>:
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> >> Thank you for taking your time and trying to help! :)
>>>> >>>>> >>> >> >>
>>>> >>>>> >>> >> >> Do you know where I can ask around for more help on th=
e
>>>> >>>>> >>> >> >> issue?
>>>> >>>>> >>> >> >> I
>>>> >>>>> >>> >> >> don't
>>>> >>>>> >>> >> >> want to give up yet.
>>>> >>>>> >>> >> >>
>>>> >>>>> >>> >> >> -H=C3=A5vard
>>>> >>>>> >>> >> >>
>>>> >>>>> >>> >> >> Den tir. 11. sep. 2018 kl. 20:02 skrev Takashi Iwai
>>>> >>>>> >>> >> >> <tiwai@suse.de>:
>>>> >>>>> >>> >> >>
>>>> >>>>> >>> >> >>> On Tue, 11 Sep 2018 19:14:37 +0200,
>>>> >>>>> >>> >> >>> H=C3=A5vard wrote:
>>>> >>>>> >>> >> >>> >
>>>> >>>>> >>> >> >>> > Yes, microphone gets detected instantly and it
>>>> >>>>> >>> >> >>> > automatically
>>>> >>>>> >>> >> >>> > changes
>>>> >>>>> >>> >> >>> > to
>>>> >>>>> >>> >> >>> it
>>>> >>>>> >>> >> >>> > in pavucontrol.
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>> Then it likely requires some additional initializatio=
n
>>>> >>>>> >>> >> >>> outside
>>>> >>>>> >>> >> >>> HD-audio.  It's hard to know, as it's pretty much
>>>> >>>>> >>> >> >>> vendor-specific.
>>>> >>>>> >>> >> >>> You can dig down the Windows, but I have no idea abou=
t
>>>> >>>>> >>> >> >>> Windows
>>>> >>>>> >>> >> >>> implementation, so can't give any hints, unfortunatel=
y.
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>> Takashi
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>> >
>>>> >>>>> >>> >> >>> > Den tir. 11. sep. 2018 kl. 18:52 skrev Takashi Iwai
>>>> >>>>> >>> >> >>> > <tiwai@suse.de>:
>>>> >>>>> >>> >> >>> >
>>>> >>>>> >>> >> >>> > > On Tue, 11 Sep 2018 18:40:23 +0200,
>>>> >>>>> >>> >> >>> > > H=C3=A5vard wrote:
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > Thank you for replying!
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > Enabling loopback in alsamixer:
>>>> >>>>> >>> >> >>> > > > http://i.imgur.com/lNo6e7T.png
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > And unmuting more and more things in "Mic
>>>> >>>>> >>> >> >>> > > > Playback
>>>> >>>>> >>> >> >>> > > > Volume"
>>>> >>>>> >>> >> >>> > > > in
>>>> >>>>> >>> >> >>> > > hdaanalyzer:
>>>> >>>>> >>> >> >>> > > > http://i.imgur.com/H0HiOhy.png
>>>> >>>>> >>> >> >>> > > > made white noise come from the headset. However
>>>> >>>>> >>> >> >>> > > > it did
>>>> >>>>> >>> >> >>> > > > not
>>>> >>>>> >>> >> >>> > > > change or
>>>> >>>>> >>> >> >>> > > react
>>>> >>>>> >>> >> >>> > > > at all when I talked or even muted the micropho=
ne
>>>> >>>>> >>> >> >>> > > > physically.
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > I couldn't find "Mic Playback Switch" anywhere =
in
>>>> >>>>> >>> >> >>> > > > either
>>>> >>>>> >>> >> >>> > > > alsamixer
>>>> >>>>> >>> >> >>> or
>>>> >>>>> >>> >> >>> > > > hdaanalyzer.
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > It's a mixer mute switch.
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > > The microphone works perfectly fine under
>>>> >>>>> >>> >> >>> > > > Windows, so I
>>>> >>>>> >>> >> >>> > > > don't
>>>> >>>>> >>> >> >>> > > > think
>>>> >>>>> >>> >> >>> it is
>>>> >>>>> >>> >> >>> > > > the mic pin.
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > But the fact above indicates the possibility of t=
he
>>>> >>>>> >>> >> >>> > > wrong
>>>> >>>>> >>> >> >>> > > pin,
>>>> >>>>> >>> >> >>> > > too.
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > Does the jack detection of the ext mic pin work?
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > Takashi
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > -H=C3=A5vard
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > Den man. 10. sep. 2018 kl. 22:39 skrev Takashi
>>>> >>>>> >>> >> >>> > > > Iwai
>>>> >>>>> >>> >> >>> > > > <tiwai@suse.de
>>>> >>>>> >>> >> >>> >:
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > > > > On Thu, 06 Sep 2018 20:44:30 +0200,
>>>> >>>>> >>> >> >>> > > > > H=C3=A5vard wrote:
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > Additional relevant info:
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > A similar issue was also discussed three
>>>> >>>>> >>> >> >>> > > > > > years ago
>>>> >>>>> >>> >> >>> > > > > > on
>>>> >>>>> >>> >> >>> > > > > > Sun
>>>> >>>>> >>> >> >>> > > > > > Jun
>>>> >>>>> >>> >> >>> > > 17:15:54
>>>> >>>>> >>> >> >>> > > > > CEST
>>>> >>>>> >>> >> >>> > > > > > 2015 and was about his surround sound setup=
,
>>>> >>>>> >>> >> >>> > > > > > but did
>>>> >>>>> >>> >> >>> > > > > > not
>>>> >>>>> >>> >> >>> > > > > > touch
>>>> >>>>> >>> >> >>> on the
>>>> >>>>> >>> >> >>> > > > > > external microphone problem:
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>> http://mailman.alsa-project.org/pipermail/alsa-devel/=
2015-June/093317.html
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > alsa-info.sh:
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>> http://www.alsa-project.org/db/?f=3D1d8616ba5977308e0=
3db6c3a86e36e9e9b38d6f0
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > Graph of ALC668 chipset from hdaanalyzer:
>>>> >>>>> >>> >> >>> > > > > > http://i.imgur.com/c08DNJW.png
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > setting alsa-mode[1-8] does nothing to help
>>>> >>>>> >>> >> >>> > > > > > the
>>>> >>>>> >>> >> >>> > > > > > issue.
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > There are several of similar bug reports
>>>> >>>>> >>> >> >>> > > > > > around the
>>>> >>>>> >>> >> >>> > > > > > web
>>>> >>>>> >>> >> >>> experiencing
>>>> >>>>> >>> >> >>> > > > > > similar issues, and on different distros.
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > Microphone works perfectly in windows
>>>> >>>>> >>> >> >>> > > > > >
>>>> >>>>> >>> >> >>> > > > > > I have a ASUS ROG G751JT, but this problem
>>>> >>>>> >>> >> >>> > > > > > seems to
>>>> >>>>> >>> >> >>> > > > > > happen
>>>> >>>>> >>> >> >>> > > > > > with
>>>> >>>>> >>> >> >>> all
>>>> >>>>> >>> >> >>> > > > > laptops
>>>> >>>>> >>> >> >>> > > > > > under the G751 name.
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > > > > When you enable the loopback volume and switc=
h,
>>>> >>>>> >>> >> >>> > > > > and
>>>> >>>>> >>> >> >>> > > > > unmute/adjust
>>>> >>>>> >>> >> >>> "Mic
>>>> >>>>> >>> >> >>> > > > > Playback Volume", and "Mic Playback Switch", =
do
>>>> >>>>> >>> >> >>> > > > > you
>>>> >>>>> >>> >> >>> > > > > hear
>>>> >>>>> >>> >> >>> > > > > the
>>>> >>>>> >>> >> >>> > > > > input
>>>> >>>>> >>> >> >>> > > > > from the ext mic?  It's a route directly from
>>>> >>>>> >>> >> >>> > > > > NID 0x18
>>>> >>>>> >>> >> >>> > > > > to
>>>> >>>>> >>> >> >>> > > > > the
>>>> >>>>> >>> >> >>> mixer
>>>> >>>>> >>> >> >>> > > > > NID 0x0b, then output mixer NID 0x0c, then
>>>> >>>>> >>> >> >>> > > > > outputs.
>>>> >>>>> >>> >> >>> > > > > So
>>>> >>>>> >>> >> >>> > > > > this
>>>> >>>>> >>> >> >>> > > > > can
>>>> >>>>> >>> >> >>> be
>>>> >>>>> >>> >> >>> > > > > used to verify the hardware routing.
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > > > > If you don't hear via this route, it means th=
at
>>>> >>>>> >>> >> >>> > > > > the
>>>> >>>>> >>> >> >>> > > > > input
>>>> >>>>> >>> >> >>> > > > > from
>>>> >>>>> >>> >> >>> the ext
>>>> >>>>> >>> >> >>> > > > > mic pin itself is broken, and it implies that
>>>> >>>>> >>> >> >>> > > > > something
>>>> >>>>> >>> >> >>> > > > > outside
>>>> >>>>> >>> >> >>> > > > > HD-audio codec.
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > > > > Takashi
>>>> >>>>> >>> >> >>> > > > >
>>>> >>>>> >>> >> >>> > > > [2  <text/html; UTF-8 (quoted-printable)>]
>>>> >>>>> >>> >> >>> > > >
>>>> >>>>> >>> >> >>> > >
>>>> >>>>> >>> >> >>> > [2  <text/html; UTF-8 (quoted-printable)>]
>>>> >>>>> >>> >> >>> >
>>>> >>>>> >>> >> >>>
>>>> >>>>> >>> >> >>
>>>> >>>>> >>> >> > _______________________________________________
>>>> >>>>> >>> >> > Alsa-devel mailing list
>>>> >>>>> >>> >> > Alsa-devel@alsa-project.org
>>>> >>>>> >>> >> >
>>>> >>>>> >>> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-d=
evel

--000000000000495d290575b20e6c
Content-Type: text/plain; charset="US-ASCII"; name="coef-values.txt"
Content-Disposition: attachment; filename="coef-values.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jlzklzvq0

MHgwMjA1MDAyNSAweDAyMDRlYmM0IAoweDAyMDUwMDI2IDB4MDIwNDIyMWYgCjB4MDIwNTAwMjkg
MHgwMjA0MDg1MCAKMHgwMjA1MDBhOSAweDAyMDQwOGZmIAoweDAyMDUwMDE2IDB4MDIwNDAxOWIg
CjB4MDIwNTAwMmMgMHgwMjA0MDAwYSAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0gQkVHSU4gQlVMSyBDT0VGIElOSVQKMHgwMjA1MDAwMSAweDAyMDRh
YWJlIAoweDAyMDUwMDAyIDB4MDIwNGFhYWEgCjB4MDIwNTAwMDMgMHgwMjA0MDAwMCAKMHgwMjA1
MDAwNCAweDAyMDQwMTgwIAoweDAyMDUwMDA2IDB4MDIwNDAwMDAgCjB4MDIwNTAwMDcgMHgwMjA0
MmY4MCAKMHgwMjA1MDAwOCAweDAyMDQwMDMxIAoKMHgwMjA1MDAwYSAweDAyMDQwMDYwIAoweDAy
MDUwMDBiIDB4MDIwNDAwMDAgCjB4MDIwNTAwMGMgMHgwMjA0N2NmNyAKMHgwMjA1MDAwZCAweDAy
MDQxMDgwIAoweDAyMDUwMDBlIDB4MDIwNDdmN2YgCjB4MDIwNTAwMGYgMHgwMjA0Y2NjYyAKMHgw
MjA1MDAxMCAweDAyMDRkZGNjIAoweDAyMDUwMDExIDB4MDIwNDAwMDEgCgoweDAyMDUwMDEzIDB4
MDIwNDAwMDAgCjB4MDIwNTAwMTQgMHgwMjA0MmFhMCAKCjB4MDIwNTAwMTUgMHgwMjA0OGMzMCAt
IG1pc3NpbmcKMHgwMjA1MDAxNiAweDAyMDQwMTliIC0gbWlzc2luZwoKMHgwMjA1MDAxNyAweDAy
MDRhOTQwIAoweDAyMDUwMDE5IDB4MDIwNDAwMDAgCjB4MDIwNTAwMWEgMHgwMjA0MDAwMCAKMHgw
MjA1MDAxYiAweDAyMDQwMDAwIAoweDAyMDUwMDFjIDB4MDIwNDAwMDAgCjB4MDIwNTAwMWQgMHgw
MjA0MDAwMCAKMHgwMjA1MDAxZSAweDAyMDQ3NDE4IAoweDAyMDUwMDFmIDB4MDIwNDA4MDQgCjB4
MDIwNTAwMjAgMHgwMjA0NDIwMCAKMHgwMjA1MDAyMSAweDAyMDQwNDY4IAoweDAyMDUwMDIyIDB4
MDIwNDhjY2MgCjB4MDIwNTAwMjMgMHgwMjA0MDI1MCAKMHgwMjA1MDAyNCAweDAyMDQ3NDE4IAoK
MHgwMjA1MDAyNSAweDAyMDRlYmM0IC0gbWlzc2luZwoweDAyMDUwMDI2IDB4MDIwNDIyMWYgLSBt
aXNzaW5nCgoweDAyMDUwMDI3IDB4MDIwNDAwMDAgCjB4MDIwNTAwMjggMHgwMjA0OGNjYyAKCjB4
MDIwNTAwMjkgMHgwMjA0MDg1MCAtIG1pc3NpbmcKCjB4MDIwNTAwMmEgMHgwMjA0ZmYwMCAKMHgw
MjA1MDAyYiAweDAyMDQ4MDAwCiAKMHgwMjA1MDAyYyAweDAyMDQwMDBhIC0gbWlzc2luZwoweDAy
MDUwMDc2IDB4MDIwNDAwMDkgLSBtaXNzaW5nCgoweDAyMDUwMGE3IDB4MDIwNGZmMDAgCjB4MDIw
NTAwYTggMHgwMjA0ODAwMCAKCjB4MDIwNTAwYTkgMHgwMjA0MDhmZiAtIG1pc3NpbmcKCjB4MDIw
NTAwYWEgMHgwMjA0MmUxNyAKMHgwMjA1MDBhYiAweDAyMDRhMGMwIAoweDAyMDUwMGFjIDB4MDIw
NDAwMDAgCjB4MDIwNTAwYWQgMHgwMjA0MDAwMCAKMHgwMjA1MDBhZSAweDAyMDQyYWM2IAoweDAy
MDUwMGFmIDB4MDIwNGE0ODAgCjB4MDIwNTAwYjAgMHgwMjA0MDAwMCAKMHgwMjA1MDBiMSAweDAy
MDQwMDAwIAoweDAyMDUwMGIyIDB4MDIwNDAwMDAgCjB4MDIwNTAwYjMgMHgwMjA0MDAwMCAKMHgw
MjA1MDBiNCAweDAyMDQwMDAwIAoweDAyMDUwMGI1IDB4MDIwNDEwNDAgCjB4MDIwNTAwYjYgMHgw
MjA0ZDY5NyAKMHgwMjA1MDBiNyAweDAyMDQ4MDJiIAoweDAyMDUwMGI4IDB4MDIwNGQ2OTcgCjB4
MDIwNTAwYjkgMHgwMjA0OTAyYiAKMHgwMjA1MDBiYSAweDAyMDRiOGJhIAoweDAyMDUwMGJiIDB4
MDIwNGFhYWIgCjB4MDIwNTAwYmMgMHgwMjA0YWFhZiAKMHgwMjA1MDBiZCAweDAyMDQ2YWFhIAow
eDAyMDUwMGJlIDB4MDIwNDFjMDIgCjB4MDIwNTAwYzAgMHgwMjA0MDBmZiAKMHgwMjA1MDBjMSAw
eDAyMDQwZmE2IAoKMHgwMjA1MDBjMyAweDAyMDQ0MDAwIC0gbWlzc2luZwotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIEVORCBPRiBNQUlOIENPRUYgSU5J
VAoKMHgwMjA1MDAxNSAweDAyMDQ4YzMwIAoweDAyMDUwMDAxIDB4MDIwNGFhYmUgCjB4MDIwNTAw
YzMgMHgwMjA0MDAwMCAKMHgwMjA1MDBjMyAweDAyMGMwMDAwIDB4MDIwNTAwYzMgMHgwMjA0NDAw
MCAgCjB4MDIwNTAwYjcgMHgwMjA0ODAyYiAweDAwMWYwNTAwIAoweDAyMDUwMDc2IDB4MDIwNDAw
MDkgCgoweDAyMDUwMDExIDB4MDIwNDAwNDEKCjB4MDIwNTAwMTEgMHgwMjA0MDA0MQoKMHgwMjA1
MDAxMSAweDAyMDQwMDQxCgoweDAyMDUwMDExIDB4MDIwNDAwMDEgCgoweDAyMDUwMDExIDB4MDIw
YzAwMDAgMHgwMjA1MDAxMSAweDAyMDQwMDAxIAoK
--000000000000495d290575b20e6c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000000000000495d290575b20e6c--
