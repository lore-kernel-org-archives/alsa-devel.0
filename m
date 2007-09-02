From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH -mm] sb16: Shut up uninitialized var build
	warning
Date: Mon, 3 Sep 2007 04:04:14 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0709030358410.31154@enigma.security.iitk.ac.in>
References: <alpine.LFD.0.999.0709022344550.27844@enigma.security.iitk.ac.i
	n> <alpine.LFD.0.999.0709030143550.29617@enigma.security.iitk.ac.in>
	<46DB33D0.40204@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="464262402-507949488-1188772458=:31154"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 12C3E243B5
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 00:21:08 +0200 (CEST)
In-Reply-To: <46DB33D0.40204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--464262402-507949488-1188772458=:31154
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On Mon, 3 Sep 2007, Rene Herman wrote:
>=20
> On 09/02/2007 10:15 PM, Satyam Sharma wrote:
>=20
> > sound/isa/sb16/sb16.c: In function =E2=80=98snd_sb16_isa_probe=E2=80=99=
:
>=20
> Blah. Your message has:
>=20
> 	Content-Type: TEXT/PLAIN; charset=3Diso-2022-jp
>=20
> This apparently is caused by a combination of GCC using groovy UTF tick=
marks
> in its error messages when in a UTF locale and alpine believing it to b=
e a
> great idea to automatically try for the "simplest" character set it can=
 encode
> the content in. No idea why that means that iso-2022-jp is picked, but =
it is.

Yeah, precisely.

> As to the content of this patch -- I'd almost say it's better to live w=
ith the
> warning than with that unitialized_var() thing. That ARRAY_SIZE is very=
 much a
> compile time constant, so exactly how dumb must GCC get before we get t=
o say
> to here and no further?

Pretty dumb indeed -- in fact that's the case with 4 patches in this
series. Like Jeff said, that (gcc's) behaviour has likely even improved
w.r.t. later versions, so I guess it's fine if these 4 patches are not
applied -- I'll leave it upto the maintainers.
--464262402-507949488-1188772458=:31154
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--464262402-507949488-1188772458=:31154--
