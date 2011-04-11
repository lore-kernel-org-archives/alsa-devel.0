From: Ossi Niiranen <oniiranen@neolex.fi>
Subject: Re: GPL/LGPL licensing of the Alsa library
Date: Mon, 11 Apr 2011 08:27:17 +0300
Message-ID: <BANLkTikm=M_uR9LGAkp_yhHMLtEr+vVRiA@mail.gmail.com>
References: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
	<4D904E11.8020003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9CB21037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 07:27:20 +0200 (CEST)
Received: by gxk1 with SMTP id 1so2420971gxk.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2011 22:27:17 -0700 (PDT)
In-Reply-To: <4D904E11.8020003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry it took a while, but here's the list (this does not include files with
the autoconf exception):

asequencer.h
aserver.c
asoundef.h
asound_fm.h
asound.h
attributes.m4
(autoconf files)
emu10k1.h
hdsp.h
latency.c
oldapi.c
playmidi1.c
sb16_csp.h
sndop-mixer.alisp
sndo-mixer.alisp

The source code distribution of the package we reviewed does not seem to
include the hdspm.h file you refer to below nor the UCM files. Does that
mean the distribution is in some way "broken"?

Ours did include also the sndop-mixer files which seem to be licensed under
the GPL as well (although at least one of them does not necessarily warrant
copyright protection as it is just a few lines).

You made some generic comments in your email about why the GPL licensing is
not an issue. If you have the time and the interest (there is obviously no
obligation), I'd wish to take that a bit further into a file specific
analysis (as we need certainty on a file level to be able to see there is no
risk). For example, you say that aserver is "separate". Does that mean it is
not shipped with the Alsa library? The impression I got from another
response to my earlier post was that it is a legacy technology but still
shipped with the library. If that's the case, I could not simply say that
there are no GPL issues without further information on how this legacy tech
is used. I need to do a similar file-based analysis for the other files as
well to make sure there are no issues.

Just to re-emphasise something. My goal here is simply to produce an opinion
on whether the licensing of a larger software package (which includes the
alsa library) is properly managed - not to accuse anyone of anything. This
process however requires quite a lot of digging into technical
implementations and I thus appreciate the effort you folks have already put
into helping me on this.

- Ossi

On Mon, Mar 28, 2011 at 12:00 PM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Ossi Niiranen wrote:
> > We recently performed a licensing audit of a larger software project
> > incorporating the Alsa library 1.0.19. One issue we identified was
> > that although the Alsa library purported to state that the library was
> > licensed under the LGPL, there were still several files with third
> > party copyright holders that indicated in their header that the file
> > in question was licensed under the GPL.
>
> $ grep -rl 'GNU General' alsa-lib/
> alsa-lib/COPYING
> alsa-lib/aserver/COPYING
> alsa-lib/aserver/aserver.c
> alsa-lib/include/sound/asequencer.h
> alsa-lib/include/sound/asound.h
> alsa-lib/include/sound/asound_fm.h
> alsa-lib/include/sound/asoundef.h
> alsa-lib/include/sound/emu10k1.h
> alsa-lib/include/sound/hdsp.h
> alsa-lib/include/sound/hdspm.h
> alsa-lib/include/sound/sb16_csp.h
> alsa-lib/m4/attributes.m4
> alsa-lib/src/ucm/main.c
> alsa-lib/src/ucm/parser.c
> alsa-lib/src/ucm/ucm_local.h
> alsa-lib/src/ucm/utils.c
> alsa-lib/test/latency.c
> alsa-lib/test/oldapi.c
> alsa-lib/test/playmidi1.c
>
> The aserver tool and the tests are separate and not part of the library
> itself; the UCM stuff is actually LGPL-licensed and mentions the GPL
> only in "You should have received a copy of the GNU General Public
> License ...".
>
> Most files in include/sound/ are just copies of the kernel headers.
>
> Is there any specific file that you think would make the resulting
> library not LGPL?
>
> > The information contained in this e-mail is privileged ...
>
> This e-mail contains public information intended for any subscriber of
> this mailing list and for anybody else who bothers to read it; it will
> be copied, disclosed and distributed to the public.  If you think you
> are not the intended recipient, please commit suicide immediately.
> These terms apply also to any e-mails quoted in, referenced from, or
> answering this e-mail, and supersede any confidentiality notices in
> those e-mails.  Additionally, confidentiality notices in those e-mails
> will incur legal processing fees of $42 per line; you have agreed to
> this by reading this confidentiality notice.
>
>
> Regards,
> Clemens
>
