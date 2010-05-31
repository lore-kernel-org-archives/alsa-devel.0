From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: spdif: Add codec driver to use	spdif
	stand-alone
Date: Mon, 31 May 2010 13:42:29 +0100
Message-ID: <20100531124228.GA14195@sirena.org.uk>
References: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0728900987634986489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A88F1038C5
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 14:42:31 +0200 (CEST)
In-Reply-To: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, schen@mvista.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

--===============0728900987634986489==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2010 at 06:13:48PM +0900, Seungwhan Youn wrote:
> This patch adds spdif dummy codec driver for using spdif-dit as
> a stand-alone. Until this, spdif-dit can be used only with other
> codecs like tlv320aci3x in davinci platform.
>=20
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

*sigh*

sound/soc/codecs/spdif_transciever.c:67:29: warning: symbol 'soc_codec_de=
v_spdif_dit' was not declared. Should it be static?
sound/soc/codecs/spdif_transciever.c:95:17: error: undefined identifier '=
kzalloc'
sound/soc/codecs/spdif_transciever.c:131:9: error: undefined identifier '=
kfree'
sound/soc/codecs/spdif_transciever.c:139:9: error: undefined identifier '=
kfree'
  CC [M]  sound/soc/codecs/spdif_transciever.o
sound/soc/codecs/spdif_transciever.c: In function =E2=80=98spdif_dit_prob=
e=E2=80=99:
sound/soc/codecs/spdif_transciever.c:95: error: implicit declaration of f=
unction =E2=80=98kzalloc=E2=80=99
sound/soc/codecs/spdif_transciever.c:95: warning: assignment makes pointe=
r from integer without a cast
sound/soc/codecs/spdif_transciever.c:131: error: implicit declaration of =
function =E2=80=98kfree=E2=80=99

I've fixed these up.

--===============0728900987634986489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0728900987634986489==--
