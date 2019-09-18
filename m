Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90708C4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19866218AF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JloTeTvY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cBLgTFIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19866218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B1CF1688;
	Wed, 18 Sep 2019 12:53:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B1CF1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568804037;
	bh=DP2KYH65/gxNHEzVix/ZGNX4F1C7cEOOsaYj4HFWPog=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JloTeTvYV0oaiBXwX1rlLJ3mcwMhyhsS3UmvgPfqp2GFWc/Z1ljtp5BHLm04rsEDO
	 2MJ+JTaL9RAnDUt0nF5elUaG92kq6hS6hj+vMSRoKOThRB+RLJ71B7HR5HQjuudye3
	 KcHphtHqEmRMjKZId21NqVsqAR2atcq7Evxro0kk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62979F80679;
	Wed, 18 Sep 2019 12:47:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5EF8F8065B; Wed, 18 Sep 2019 12:47:17 +0200 (CEST)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F64FF80642
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 12:47:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F64FF80642
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="cBLgTFIl"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190918104715euoutp015016b772f9e3435fcc66731121e1ba75~FgpgiZegm1222312223euoutp011
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 10:47:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190918104715euoutp015016b772f9e3435fcc66731121e1ba75~FgpgiZegm1222312223euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1568803635;
 bh=xXzfRu9QLTj/XX7HXJ29mEGOJQBJL9qoYmNOwy+z2GM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cBLgTFIlp2xwag5s2nE+XyzqaG6yFfhIwpb5Bph19QJdlHCiBbcwazbIYs06UFuvN
 rdwIZf23QEEyEL+0d3VgMpGjVp0F5G4WphXgxDSMlsfr1zaytcctEQDuk6bnCNm+ZF
 FEfkg8IBSoFtui4z2Lx6UI9wHViVUWGPtmmG8jVI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190918104714eucas1p2b7218f8911155c2d56c4a1da5d80bf05~FgpgCUZJA2379323793eucas1p2q;
 Wed, 18 Sep 2019 10:47:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.B4.04309.23B028D5; Wed, 18
 Sep 2019 11:47:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190918104713eucas1p2ccfa8e9dff2cda9e8f88ac42dda2b680~FgpfElMvl2378523785eucas1p2h;
 Wed, 18 Sep 2019 10:47:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190918104713eusmtrp29acc9faf5d3931e383eca1b2ea862182~Fgpe0-fxX1585315853eusmtrp2S;
 Wed, 18 Sep 2019 10:47:13 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-34-5d820b32dad1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.C6.04166.13B028D5; Wed, 18
 Sep 2019 11:47:13 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190918104712eusmtip1eb199f3c78fc8fa94af113a38915a02c~FgpeNp1H10494604946eusmtip1E;
 Wed, 18 Sep 2019 10:47:12 +0000 (GMT)
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Date: Wed, 18 Sep 2019 12:46:33 +0200
Message-Id: <20190918104634.15216-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918104634.15216-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTud+/u7lWbXLfKgz2skUFBmfbgUtIDDFeECP0RGZIzL9Ny03bV
 sgiH5StNSxOXDdSMtJk6l2kqpk1zVuZcSSUiKmlvldSifObtKv73ne9xzvfHoXBpCeFGhWui
 Wa1GGSEXO4qqW//atno7JQRt7+x3ZrrsFoyp1FcQTM7AoJjpSjQjJr+lg2BsNhPJ/O5KwRjz
 x3cEo7c9xZiyll6SGR9tJJjEhhaSaf6RTDD2kgnsgLPCNJ4gVtTm9ZIKszFVrHh0L16Ra5hD
 iowqI1KMm9cFkIGOPqFsRHgsq/XcF+wYVlNmEEcVuVzIyjQQOtTgfA05UEDvhNfGL9g15EhJ
 6RIEg8k3CWGYQDBdmbQwjCP4UX1FvBjpK5wkBaEYgf3r56XIs7c1OO8S015w/XkG4vEKehX0
 GFJx3oTT0xgMz+SJeEFGH4ORHtO8iaJEtAe06mQ8LaH3QnnpH1K45g6lpqb/Ox1oHxjr7Bfx
 e4CuI6E4e2Chki8MZbVjApbBN2vVQngNzNXmY0LgCoL0+h5SGG4g6LMWIMG1F5qtdoJvgdOb
 oaLOU6APQuXV2yRPA+0MH4ZdeBqfh1nVubhASyAlSSq4N8KUMXehghukDc6JBKyA9Lt3/mMp
 nYlgNDvwBnLPW7pVgJARubIxnFrFct4a9vw2TqnmYjSqbacj1WY0/z+vZq0TT1DddIgF0RSS
 L5c0vdQFSQllLBentiCgcPkKScDl+CCpJFQZd5HVRp7SxkSwnAWtpkRyV8mlZf0npbRKGc2e
 ZdkoVruoYpSDmw6t9Mtx996U+3DHuamZxz91BXTtrjPePR6eCVH+yWll+TOH/fT+h/w7uO+U
 7+bHvwvC39Turzqeyo6MbZjsJM516/7YGk+UTAUe2ROGGE2b/lfhbvus/qgsJKTtQPeQQ/v6
 ++VrbxYG+1iKbnmp6oPU1hfvlU5tkfDgU8WOJPf45hy5iAtTem3BtZzyH03DFN87AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4XV1D7qZYg+VX+SyuXDzEZLFxxnpW
 i6kPn7BZXGndxGgx/8g5Vovz5zewW3y70sFksenxNVaLGef3MVmsPXKX3eLz+/2sFq17j7Bb
 HH7TzmpxccUXJgc+jw2fm9g8ds66y+6xaVUnm8fmJfUe0+f8Z/To27KK0ePzJrkA9ig9m6L8
 0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jO1r57AVLBas
 mNQ/h7WBcS9fFyMnh4SAicT9hb/Yuxi5OIQEljJKtCw7x9zFyAGUkJKY36IEUSMs8edaFxtE
 zSdGiSmnrjOBJNgEDCV6j/YxgtgiAmISt+d0MoMUMQt0MUu83/GLFSQhLBAo8X3iY1aQoSwC
 qhLHGoRBwrwC1hLrVv9gh1ggL7F6wwFmEJtTwEbi04UHLCC2EFDNgmPTGCcw8i1gZFjFKJJa
 WpybnltsqFecmFtcmpeul5yfu4kRGAvbjv3cvIPx0sbgQ4wCHIxKPLwHTjXECrEmlhVX5h5i
 lOBgVhLhDaitjxXiTUmsrEotyo8vKs1JLT7EaAp000RmKdHkfGCc5pXEG5oamltYGpobmxub
 WSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYNS9NoE9X0ZzrqHGyZC9M3oYWeetWj37g7ln
 slr//CM/ggS3O6w9pWa8WiYoeJv1tMqpYitTZ2/+4D9nRfxZjSDLR+ue9M1oTsvjOqN9wnpz
 4f/Gwy8382+Y/OlC6Io2Hcm42G++W+7Yi/kdVpAzmrjBx5fP/bHIk+P/t35cHDgljO/HHosD
 VyKVWIozEg21mIuKEwEA8vqfmwIAAA==
X-CMS-MailID: 20190918104713eucas1p2ccfa8e9dff2cda9e8f88ac42dda2b680
X-Msg-Generator: CA
X-RootMTR: 20190918104713eucas1p2ccfa8e9dff2cda9e8f88ac42dda2b680
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190918104713eucas1p2ccfa8e9dff2cda9e8f88ac42dda2b680
References: <20190918104634.15216-1-s.nawrocki@samsung.com>
 <CGME20190918104713eucas1p2ccfa8e9dff2cda9e8f88ac42dda2b680@eucas1p2.samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, sbkim73@samsung.com, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, krzk@kernel.org, robh+dt@kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: [alsa-devel] [PATCH v1 8/9] ASoC: samsung: arndale: Add missing OF
 node dereferencing
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Ensure there is no OF node references kept when the driver is removed/unbound.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/arndale_rt5631.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index 3744c47742b8..d8da313e898a 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -132,6 +132,17 @@ static struct snd_soc_card arndale_wm1811 = {
 	.num_links = ARRAY_SIZE(arndale_wm1811_dai),
 };
 
+static void arndale_put_of_nodes(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *dai_link;
+	int i;
+
+	for_each_card_prelinks(card, i, dai_link) {
+		of_node_put(dai_link->cpus->of_node);
+		of_node_put(dai_link->codecs->of_node);
+	}
+}
+
 static int arndale_audio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -156,16 +167,31 @@ static int arndale_audio_probe(struct platform_device *pdev)
 	if (!dai_link->codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'samsung,audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_of_nodes;
 	}
 
 	ret = devm_snd_soc_register_card(card->dev, card);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n", ret);
+		goto err_put_of_nodes;
+	}
 
+	return 0;
+
+err_put_of_nodes:
+	arndale_put_of_nodes(card);
 	return ret;
 }
 
+static int arndale_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	arndale_put_of_nodes(card);
+	return 0;
+}
+
 static const struct of_device_id arndale_audio_of_match[] __maybe_unused = {
 	{ .compatible = "samsung,arndale-rt5631",  .data = &arndale_rt5631 },
 	{ .compatible = "samsung,arndale-alc5631", .data = &arndale_rt5631 },
@@ -181,6 +207,7 @@ static struct platform_driver arndale_audio_driver = {
 		.of_match_table = arndale_audio_of_match,
 	},
 	.probe = arndale_audio_probe,
+	.remove = arndale_audio_remove,
 };
 
 module_platform_driver(arndale_audio_driver);
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
