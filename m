From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Broken pipe when starting pcm
Date: Sat, 01 Nov 2003 01:45:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprxxoegqeq1sf88@mail.broadpark.no>
References: <oprxw33qopq1sf88@mail.broadpark.no> <oprxxmrp12q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprxxmrp12q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 01 Nov 2003 01:10:27 +0100, Arve Knudsen <aknuds-1@broadpark.no>=20
wrote:

> On Fri, 31 Oct 2003 18:27:16 +0100, Arve Knudsen <aknuds-1@broadpark.no=
>=20
> wrote:
>
>> Hi
>>
>> Whenever I turn on xrun detection, setting stop_threshold to buffer=20
>> size instead of -1, snd_pcm_start refuses to work. The exit message to=
=20
>> do with broken pipe. I figured it might be caused by an empty buffer,=20
>> so I fill it with silence before start. snd_pcm_avail_update confirms=20
>> this (zero frames available), but it makes no difference. This happens=
=20
>> with both my cards, nForce2 onboard and RME DIGI9636. If someone could=
=20
>> point out the cause of this, I'd truly appreciate it. If it matters I=20
>> am running a development kernel, 2.6.0 test9-mm1.
>>
>> Thanks
>>
>> Arve Knudsen
>
> Ok, was able to track it down to snd_pcm_prepare. I already tested the=20
> stream state, so I knew the stream was in the prepared state before I=20
> called snd_pcm_prepare myself. However I would never have thought that=20
> calling snd_pcm_prepare before snd_pcm_start could cause problems, isnt=
=20
> this the standard procedure (preparing before start)? At least=20
> commenting out the prepare call before starting, makes the problem go=20
> away. I see I also have to fill the buffer before snd_pcm_start (or dea=
l=20
> with broken pipe), I thought a silence size equal to boundary and=20
> silence threshold of 0 would cause the buffer to be automatically=20
> silenced (judging from the docs)?

Awww, looks like I cheered to early. Once I compile with optimizations or=
=20
try to restart because of xruns, I'm hit by the same error. Completely at=
=20
a loss here, maybe I should just accept the defeat :\

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
