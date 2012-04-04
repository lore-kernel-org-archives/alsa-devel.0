From: Jan Prunk <janprunk@gmail.com>
Subject: Bug#654799: Cranking sound coming out of speakers with the new 3.1 kernel
Date: Wed, 4 Apr 2012 11:50:53 +0200
Message-ID: <CALnoPX7HDAedX+WNUZRZ0njst1jUN1RL21hW5s+WzEXvRS52mg@mail.gmail.com>
References: <20120105205738.3851.59595.reportbug@vaio.prunk.si>
 <20120105214103.GA8734@elie.hsd1.il.comcast.net> <CALnoPX5bLu7SHWRTAf09_PcYS_ogGeMprGj_K=KkZAjGJXsEXA@mail.gmail.com>
 <CALnoPX5wFO7Wf6tTh5D8oHTyi2G+VzDceisFBTyagxdf1NviBQ@mail.gmail.com>
 <20120113230400.GC7343@burratino> <CALnoPX69o_qALtbxyqd+QPx3VJ62RVAVPzHy-EbLUNSU=v_3pQ@mail.gmail.com>
 <s5hwr77nf2z.wl%tiwai@suse.de> <CALnoPX5-38i_JFVifgxCzGA+nA4UVpmcpxrgDwrH9ZfmzHyXLg@mail.gmail.com>
 <s5h399su52y.wl%tiwai@suse.de>
Reply-To: Jan Prunk <janprunk@gmail.com>, 654799@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.654799.B654799.133353308326676@bugs.debian.org>
In-Reply-To: <s5h399su52y.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: 654799@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello !

I can confirm that I have NO further sound errors in the following kernels:
ii  linux-image-3.2.0-2-686-pae          3.2.9-1
ii  linux-image-3.2.0-1-686-pae          3.2.6-1

The rest is still to be tested.

Kind regards,
Jan

On Thu, Mar 1, 2012 at 8:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 1 Mar 2012 08:44:33 +0100,
> Jan Prunk wrote:
>>
>> Hello !
>>
>> The sound has been stable for the last days without noises,
>> after applying % amixer -c0 set "Auto-Mute Mode" "Disabled"
>
> OK, another question is whether the auto-mute feature works in hardware,
> i.e. even when this mixer is set off, the hardware switches the
> speaker upon plugging the headphone? =C2=A0If yes, we can simply remove
> this switch and software feature from the driver.
>
>
> thanks,
>
> Takashi
>
>>
>> It seems this has solved it, until further notice.
>> You might want to keep the bug open for a while,
>> so I can check with all the kernels (it works with latest).
>>
>> Kind regards,
>> Jan
>>
>> On Tue, Feb 28, 2012 at 4:38 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 28 Feb 2012 16:16:48 +0100,
>> > Jan Prunk wrote:
>> >>
>> >> Hello !
>> >>
>> >> On Sat, Jan 14, 2012 at 12:04 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> >> > Hi again,
>> >> >
>> >> > Jan Prunk wrote:
>> >> >
>> >> >> I tried booting into 3.2.0-rc7-686-pae, but the crunching sound
>> >> >> is still present, I am able to play music file properly, and
>> >> >> crunching is in the background, and also while not processing
>> >> >> any sounds, the crunching appears out of the speakers.
>> >> >
>> >> > Ok, thanks for testing. =C2=A0Please send a summary of this regress=
ion to
>> >> > alsa-devel@alsa-project.org, cc-ing Takashi Iwai <tiwai@suse.de> an=
d
>> >> > either me or this bug log so we can track it.
>> >> >
>> >> > Be sure to mention:
>> >> >
>> >> > =C2=A0- steps to reproduce, what you expect versus what actually ha=
ppens,
>> >> > =C2=A0 and how that indicates a bug
>> >>
>> >> The sound is ok in kernel version "3.0.0-1-686-pae" but on all newer
>> >> versions there are sparkling/farting noises coming out of the speaker=
.
>> >> The noise is not very loud, its barely noticeable, but its repetative
>> >> and doesn't go away. And I think it happens while typing on the
>> >> keyboard and a bit later, then it dissapears for a few seconds,
>> >> or by the time that I type again.
>> >>
>> >> > =C2=A0- which kernel versions you tried, and what happens with each
>> >> I tried running alsa-info.sh as a "user".
>> >>
>> >> I tried 3.0.0-1-686-pae here is the debug:
>> >> http://www.alsa-project.org/db/?f=3Dc1149b6466b2068d79c7517a8b0808d8b=
5c26e6b
>> >> ---
>> >> Linux vaio 3.2.0-1-686-pae #1 SMP Fri Feb 17 06:27:21 UTC 2012 i686 G=
NU/Linux
>> >> ii =C2=A0linux-image-3.2.0-1-686-pae =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A03.2.6-1
>> >> http://www.alsa-project.org/db/?f=3Dfddbfbdc4fc44555a6dc851ecdc70760d=
a6dd840
>> >> ---
>> >> Linux vaio 3.2.0-rc7-686-pae #1 SMP Wed Dec 28 21:26:25 UTC 2011 i686=
 GNU/Linux
>> >> ii =C2=A0linux-image-3.2.0-rc7-686-pae =C2=A0 =C2=A0 =C2=A0 =C2=A03.2=
~rc7-1~experimental.1
>> >> http://www.alsa-project.org/db/?f=3D78c8919e87dd03294484f83b5f7ae4433=
1b5edfe
>> >> Being booted into this version for 15 minutes, it seems to not make a=
ny noises,
>> >> but I will resubmit the info later if the noises will start to appear=
.
>> >
>> > 3.2.0-rc7 alsa-info shows that the headphone jack is plugged, thus the
>> > speaker is muted. =C2=A0It's natural that the noise goes away in this
>> > state.
>> >
>> > Apart from that, I see no obvious problem in 3.2.0 output.
>> >
>> > Does the problem still happen when you disable "Auto-Mute Mode" mixer
>> > enum?
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0% amixer -c0 set "Auto-Mute Mode" "Disabled=
"
>> >
>> > Also, try to pass algin_buffer_size=3D0 option to snd-hda-intel.
>> > I don't expect much that this will influence, but at least, it's a
>> > difference between 3.0 and 3.2.
>> >
>> >
>> > Takashi
>> >
>> >
>> >> > =C2=A0- alsa-info.sh output, as an attachment
>> >> >
>> >> > =C2=A0- if you can make a recording of the strange sound available
>> >> > =C2=A0 somewhere online, that would be ideal
>> >>
>> >> Because the noise is barely heard, I would need to find a good mic.
>> >> to be able to record it, but I could do that in the next bug submissi=
on.
>> >>
>> >> > =C2=A0- whether you are able to bisect or test patches if needed
>> >>
>> >> I might try that, if there are any manuals around how to do it,
>> >> but my response might take some time.
>> >>
>> >> > [1] may have more hints.
>> >> >
>> >> > Thanks and good luck,
>> >> > Jonathan
>> >> >
>> >> > [1] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA
>> >>
>> >> Kind regards,
>> >> Jan Prunk
>> >> --
>> >> Jan Prunk=C2=A0=C2=A0 http://www.prunk.si
>> >> 0x00E80E86=C2=A0 http://pgp.prunk.si
>> >> http://AS50763.peeringdb.com
>> >>
>>
>>
>>
>> --
>> Jan Prunk=C2=A0=C2=A0 http://www.prunk.si
>> 0x00E80E86=C2=A0 http://pgp.prunk.si
>> http://AS50763.peeringdb.com
>>



--=20
Jan Prunk=C2=A0=C2=A0 http://www.prunk.si
0x00E80E86=C2=A0 http://pgp.prunk.si
http://AS50763.peeringdb.com
