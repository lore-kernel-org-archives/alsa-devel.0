From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: spdif: Add codec driver to use spdif
	stand-alone
Date: Tue, 1 Jun 2010 04:27:12 +0900
Message-ID: <AANLkTil7HORYjETZrvF9foVm3zxYLRf9bm5Y9tkVFpSM@mail.gmail.com>
References: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
	<20100531124228.GA14195@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 543F424514
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 21:27:14 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1010355wwf.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 12:27:13 -0700 (PDT)
In-Reply-To: <20100531124228.GA14195@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, schen@mvista.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi, Mark,

2010/5/31 Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> On Thu, May 27, 2010 at 06:13:48PM +0900, Seungwhan Youn wrote:
> > This patch adds spdif dummy codec driver for using spdif-dit as
> > a stand-alone. Until this, spdif-dit can be used only with other
> > codecs like tlv320aci3x in davinci platform.
> >
> > Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
> *sigh*
>
> sound/soc/codecs/spdif_transciever.c:67:29: warning: symbol 'soc_codec_de=
v_spdif_dit' was not declared. Should it be static?
> sound/soc/codecs/spdif_transciever.c:95:17: error: undefined identifier '=
kzalloc'
> sound/soc/codecs/spdif_transciever.c:131:9: error: undefined identifier '=
kfree'
> sound/soc/codecs/spdif_transciever.c:139:9: error: undefined identifier '=
kfree'
> =A0CC [M] =A0sound/soc/codecs/spdif_transciever.o
> sound/soc/codecs/spdif_transciever.c: In function =91spdif_dit_probe=92:
> sound/soc/codecs/spdif_transciever.c:95: error: implicit declaration of f=
unction =91kzalloc=92
> sound/soc/codecs/spdif_transciever.c:95: warning: assignment makes pointe=
r from integer without a cast
> sound/soc/codecs/spdif_transciever.c:131: error: implicit declaration of =
function =91kfree=92
>
> I've fixed these up.
>

I'm sorry for missing these. :(
Thank you.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

BestRegards,
claude
