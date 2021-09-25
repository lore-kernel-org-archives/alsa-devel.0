Return-Path: <SRS0=Jhkg=OP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF4C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Sep 2021 02:25:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE696105A
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Sep 2021 02:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDE696105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 862931614;
	Sat, 25 Sep 2021 04:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 862931614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632536733;
	bh=DV8F1Jf7EBf3HE0dfQzQxsqQ6nT1sRzn8zHjolegFeM=;
	h=Date:To:From:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=UOJh9y0av/9HBy2N23vnhTffe3Y8sPf6UWRM+3/TraaDvRV2LfxVKbYo2yNZJBe/l
	 di+GLDRG4+pXUQjw5PB4wkDmAjBVGbXnbw/qA7NwzWrAanoTiSLMVUnQ+xYbq1+w1k
	 sbPTJhacqIw9g24Y5CdUACNu0zNb3/ntRWM2K/9M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D79DDF8025F;
	Sat, 25 Sep 2021 04:24:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3448DF8013D; Sat, 25 Sep 2021 04:24:38 +0200 (CEST)
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E5EFF8013D
 for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2021 04:24:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E5EFF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="VpPIReeC"
Date: Sat, 25 Sep 2021 02:24:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632536667;
 bh=DV8F1Jf7EBf3HE0dfQzQxsqQ6nT1sRzn8zHjolegFeM=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=VpPIReeCPjfz8t9kees+LdbmaGCXAK5qdpivX0MDE7qLkyR7Hh2sJ5rG+uUzndB4m
 +kSCK84znUo1afvVSwL075biijo9EXfRlJO5T9rG8I+Z4MTLl0l6B5NS2J0DRKUV1P
 8YNdmUZ8G4LAbiUun7tr/PNsYMBjSHHl3qQLzId4=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] ASoC: wcd9335: Use correct version to initialize Class H
Message-ID: <20210925022339.786296-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, Yassine Oudjana <y.oudjana@protonmail.com>,
 linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The versioning scheme was changed in an earlier patch, which caused the ver=
sion
being used to initialize WCD9335 to be interpreted as if it was WCD937X, wh=
ich
changed code paths causing broken headphones output. Pass WCD9335 instead o=
f
WCD9335_VERSION_2_0 to wcd_clsh_ctrl_alloc to fix it.

Fixes: 19c5d1f6a0c3 ("ASoC: codecs: wcd-clsh: add new version support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index d885ced34f60..bc5d68c53e5a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4859,7 +4859,7 @@ static int wcd9335_codec_probe(struct snd_soc_compone=
nt *component)
=20
 =09snd_soc_component_init_regmap(component, wcd->regmap);
 =09/* Class-H Init*/
-=09wcd->clsh_ctrl =3D wcd_clsh_ctrl_alloc(component, wcd->version);
+=09wcd->clsh_ctrl =3D wcd_clsh_ctrl_alloc(component, WCD9335);
 =09if (IS_ERR(wcd->clsh_ctrl))
 =09=09return PTR_ERR(wcd->clsh_ctrl);
=20
--=20
2.33.0


