From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 09:55:53 -0500
Message-ID: <alpine.DEB.2.10.1509090954430.3157@heelroid>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1454848524-1441810558=:3157"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B66FA260662
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 16:55:49 +0200 (CEST)
In-Reply-To: <20150909145158.GK9751@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

--8323329-1454848524-1441810558=:3157
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2015, Mark Brown wrote:

> On Wed, Sep 09, 2015 at 04:40:36PM +0200, Takashi Iwai wrote:
>=20
> > I hoped that I wouldn't need to write this kind of post, but since
> > nothing happened so far, so here we go:
>=20
> Could you be more specific about nothing happening here...
>=20
> > The following compile warnings are present for quite some time.  They
> > are due to the lack of return check from of_property_read*().
>=20
> > sound/soc/codecs/cs35l32.c: In function =E2=80=98cs35l32_i2c_probe=E2=
=80=99:
> > sound/soc/codecs/cs35l32.c:278:2: warning: =E2=80=98val=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
> >   switch (val) {
> >   ^
> > sound/soc/codecs/cs35l32.c:272:15: note: =E2=80=98val=E2=80=99 was de=
clared here
> >   unsigned int val;
> >                ^
>=20
> How are you generating these - what compiler and config?  None of the
> build bots are reporting any of the warnings you have here.
>=20
Shouldn't that build server at Intel catch these? I usually get emails=20
about things like this from them.

--8323329-1454848524-1441810558=:3157
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1454848524-1441810558=:3157--
