From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: No recording on hda-intel (AD1981HD)
Date: Fri, 8 Feb 2008 19:51:39 +0100
Message-ID: <200802081951.40111.grzegorz.chwesewicz@chilan.com>
References: <200802032017.38614.grzegorz.chwesewicz@chilan.com>
	<s5h3as3y6sr.wl%tiwai@suse.de> <s5hodarwidq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 30853103859
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 19:53:11 +0100 (CET)
In-Reply-To: <s5hodarwidq.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

Friday 08 of February 2008 16:57:37 Takashi Iwai napisa=B3(a):
> At Fri, 08 Feb 2008 13:24:52 +0100,
>
> I wrote:
> > BTW, do you have problems found in below?
> > 	https://bugzilla.novell.com/show_bug.cgi?id=3D297703
> >
> > According to the reporter, nc6400 with AD1981 has a problem with
> > headphone jack auto-muting and with the non-linear master volume.
> >
> > I supplied two test patches there.
>
> For convenience, I attach patches here.

Hi, I had no time to test your first patch (this one which check if irq =

handler is called), I've only tested it for a while (working on MSI turned =

on, sometimes hard locks my laptop).

I also have similiar problems with automute, and non-linear master volume =

control. =


Without automute patch, automute works from time to time. With your patch =

applied to latest git it works all the time, until the recording breaks. Wh=
en =

it happens I have sound only in headphones, but not in internal speaker. =

Pluging and unpluging HP doesn't help, only reloading hda-intel fixes =

problem. =

Assuming, your automute patch is ok, but it helps me only until mic breaks.

Without ad1981-hp-master-amp-fix muting (muting=3Ddisabling it, not making =
it's =

value equal 0) "Master" and "PCM" control works ok. Decrementing Master and =

PCM controls to 0 is possible, but after that I can hear very quiet output =

from internal speakers.
With your patch (ad1981-hp-master-amp-fix) applied to latest git I can't =

decrement Master control to 0 (I can do that with PCM, but behavior is same =

as described upper). I can only decrement it to value 3, and when I press =

down key (in alsamixer) to step to lower level of loudness, it's switching =
to =

value 103. When Master has 103 value I can hear very quiet output from =

internal speakers and HP (if plugged).

I hope you understand my english ;)

PS. I will test your irq_handler_check patch today, and I will send results =

soon.

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
