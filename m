From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: ASoC updates for 3.1
Date: Mon, 26 Sep 2011 13:27:40 +0800
Message-ID: <CAHG8p1AkA+NaGUWnSvNVHvurQeZi=khz1k3+zyWgM-t9WLW29w@mail.gmail.com>
References: <20110922171744.GF5173@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A262446D
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 07:27:41 +0200 (CEST)
Received: by qyk33 with SMTP id 33so6064248qyk.17
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2011 22:27:40 -0700 (PDT)
In-Reply-To: <20110922171744.GF5173@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/23 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> The following changes since commit 5013951be88e136d9990ef55303276e2779ce8=
d8:
>
> =A0ASoC: Fix trivial build regression in Kirkwood I2S (2011-09-12 11:48:1=
2 +0100)
>
> are available in the git repository at:
> =A0git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.1
>
> A couple of driver fixes and the driver name issue we discussed.
>
> Axel Lin (1):
> =A0 =A0 =A0ASoC: bf5xx-ad73311: Fix prototype for bf5xx_probe
>
> Mark Brown (2):
> =A0 =A0 =A0ASoC: Remove bitrotted wm8962_resume()
> =A0 =A0 =A0ASoC: Ensure we generate a driver name
>
Hi Mark, I wanted to clone,but I always got such error. Any advice?
Thanks.

scott@scott-desktop:~/Projects/git-kernel$ git clone
http://opensource.wolfsonmicro.com/linux-2.6-asoc
Initialized empty Git repository in
/home/scott/Projects/git-kernel/linux-2.6-asoc/.git/
error:
int sctp_register_pf(struct sctp_pf *pf, sa_family_t family)
{
        switch (family) {
        case PF_INET:
                if (sctp_pf_inet_specific)
                        return 0;
                sctp_pf_inet_specific =3D pf;
                break;
        case PF_INET6:
                if (sctp_pf_inet6_specific)
                return 0;
                sctp_pf_inet6_sp (curl_result =3D 56, http_code =3D 0,
sha1 =3D 3d8a97747f7731c801ca7d3a1483858feeb76b6c)
error: Unable to find 3d8a97747f7731c801ca7d3a1483858feeb76b6c under
http://opensource.wolfsonmicro.com/linux-2.6-asoc
Cannot obtain needed blob 3d8a97747f7731c801ca7d3a1483858feeb76b6c
while processing commit b7c4b42857c62d22cc8bad4cb8d40f8de64aa054.
error: Fetch failed.
