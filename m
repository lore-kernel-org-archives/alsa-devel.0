From: Jan Prunk <janprunk@gmail.com>
Subject: Bug#654799: Cranking sound coming out of speakers with the new 3.1 kernel
Date: Tue, 28 Feb 2012 16:16:48 +0100
Message-ID: <CALnoPX69o_qALtbxyqd+QPx3VJ62RVAVPzHy-EbLUNSU=v_3pQ@mail.gmail.com>
References: <20120105205738.3851.59595.reportbug@vaio.prunk.si>
 <20120105214103.GA8734@elie.hsd1.il.comcast.net> <CALnoPX5bLu7SHWRTAf09_PcYS_ogGeMprGj_K=KkZAjGJXsEXA@mail.gmail.com>
 <CALnoPX5wFO7Wf6tTh5D8oHTyi2G+VzDceisFBTyagxdf1NviBQ@mail.gmail.com> <20120113230400.GC7343@burratino>
Reply-To: Jan Prunk <janprunk@gmail.com>, 654799@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.654799.B654799.133044224024560@bugs.debian.org>
In-Reply-To: <20120113230400.GC7343@burratino>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jonathan Nieder <jrnieder@gmail.com>, 654799@bugs.debian.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hello !

On Sat, Jan 14, 2012 at 12:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi again,
>
> Jan Prunk wrote:
>
>> I tried booting into 3.2.0-rc7-686-pae, but the crunching sound
>> is still present, I am able to play music file properly, and
>> crunching is in the background, and also while not processing
>> any sounds, the crunching appears out of the speakers.
>
> Ok, thanks for testing. =C2=A0Please send a summary of this regression to
> alsa-devel@alsa-project.org, cc-ing Takashi Iwai <tiwai@suse.de> and
> either me or this bug log so we can track it.
>
> Be sure to mention:
>
> =C2=A0- steps to reproduce, what you expect versus what actually happens,
> =C2=A0 and how that indicates a bug

The sound is ok in kernel version "3.0.0-1-686-pae" but on all newer
versions there are sparkling/farting noises coming out of the speaker.
The noise is not very loud, its barely noticeable, but its repetative
and doesn't go away. And I think it happens while typing on the
keyboard and a bit later, then it dissapears for a few seconds,
or by the time that I type again.

> =C2=A0- which kernel versions you tried, and what happens with each
I tried running alsa-info.sh as a "user".

I tried 3.0.0-1-686-pae here is the debug:
http://www.alsa-project.org/db/?f=3Dc1149b6466b2068d79c7517a8b0808d8b5c26e6=
b
---
Linux vaio 3.2.0-1-686-pae #1 SMP Fri Feb 17 06:27:21 UTC 2012 i686 GNU/Lin=
ux
ii  linux-image-3.2.0-1-686-pae          3.2.6-1
http://www.alsa-project.org/db/?f=3Dfddbfbdc4fc44555a6dc851ecdc70760da6dd84=
0
---
Linux vaio 3.2.0-rc7-686-pae #1 SMP Wed Dec 28 21:26:25 UTC 2011 i686 GNU/L=
inux
ii  linux-image-3.2.0-rc7-686-pae        3.2~rc7-1~experimental.1
http://www.alsa-project.org/db/?f=3D78c8919e87dd03294484f83b5f7ae44331b5edf=
e
Being booted into this version for 15 minutes, it seems to not make any noi=
ses,
but I will resubmit the info later if the noises will start to appear.

> =C2=A0- alsa-info.sh output, as an attachment
>
> =C2=A0- if you can make a recording of the strange sound available
> =C2=A0 somewhere online, that would be ideal

Because the noise is barely heard, I would need to find a good mic.
to be able to record it, but I could do that in the next bug submission.

> =C2=A0- whether you are able to bisect or test patches if needed

I might try that, if there are any manuals around how to do it,
but my response might take some time.

> [1] may have more hints.
>
> Thanks and good luck,
> Jonathan
>
> [1] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA

Kind regards,
Jan Prunk
--=20
Jan Prunk=C2=A0=C2=A0 http://www.prunk.si
0x00E80E86=C2=A0 http://pgp.prunk.si
http://AS50763.peeringdb.com
