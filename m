Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4A0CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:42:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A09C460217;
	Sat, 10 Oct 2026 21:41:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A09C460217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661321;
	bh=NV297hPhL0HERbs2IyoZwWWLUO44XQvPJKokBPrQwBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M+YNxQMffdx1O5WoAgnUM4z7YSRcG6sdinwcjgIMF/wBdo7AtxIr3oT/LcJNssa7N
	 NdW+NS7ksEw0JkLRyRckEwKW/f4rGFYsDtotQbJ1cz5eAX0wIzfBAaD5VWoXRwWRQz
	 8Xdii61ZU4+k5Q6gE99d6VIIVRUApVEAnfM4WDTE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F236CF80651; Sat, 10 Oct 2026 21:41:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A8A6F80639;
	Sat, 10 Oct 2026 21:41:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7758F805F2; Thu,  8 Oct 2026 21:01:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791486084;
	b=TqSeBZegetqr/uPkuOCh1WAUkTJ6KgAxf8yyWb0uBHdR0cpK96YeBNU/M7fSOVJC20ap
	 x8abQAyUQKw8sSnxBpKjsVctqqvAPkdBtAP9TLX/LMw2jquFDiinkvRW1j/FzvJQ4OT0+
	 Jbm9TA4WmBKdtyBkz8q0iyCkBk5s7Y5ShlGv7ZpdEnMvqhvVvgpRBckyGFL4Ccdc1vLkc
	 uHV8IoQuJxhrf7ehejD9DHqbpuUJij4S/OkWrJcV8uo+HjVPn6KOfKP6xiHhYwvh44n+H
	 d46YhGvxRNMJP2dLfB/YVwyh5+wuP+RkVMMbJoZisp8GHVBalSLuSbx18zu/Tatkdrw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791486084;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NV297hPhL0HERbs2IyoZwWWLUO44XQvPJKokBPrQwBI=;
	b=NeuyyYvhruoGZldzg7mhTUGyxblVB3emrWDdLmaS77Aqxp62cp+9qJbFBk/rvGIAODlg
	 XVUNwlEG84oWdjNypwHPhYQC5mkaLdUklmR1ZTXffKP5fFP2eld4954WS2+pMmd4sgPM7
	 O5YnXPScz5EuVAz0VHuAcpIH1yKGjBofVhyDrKyAPip5v7c+9KQwLV5wwWq12Ut1kIpgx
	 qAVEI96vydW9a59kUUBScJ9i/S5E6PsZ5DoojbaVAmR+wGgkAnFArvMjsMDLcPzCKPtwJ
	 DK/N7yNfAt6ifOUeenRzdkbKieqJUgA3Uk53Zs7pv6qHviL+pbyeaM+zF3hBV0FSEvw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=b2yUqLRh;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9EF4F8007E
	for <sound-open-firmware@alsa-project.org>;
 Thu,  8 Oct 2026 21:01:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9EF4F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=b2yUqLRh
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3514e7cbbbaso6941411eec.1
        for <sound-open-firmware@alsa-project.org>;
 Thu, 08 Oct 2026 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486078; x=1792090878;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZaD67jW1zaHMwLOSmvc/1aeKMLwK1RpzPD9+yhLQ1do=;
        b=b2yUqLRhPkpEe6PLOWzmeU70LsEhhxIbyB8pJ118VtFBprIRfc9U4gdWshhgCjbACy
         6vhy+4ViLZyiWs53tAuE4C41m/w31w9spQg7XYTRz/A6Kc4+bu22iI1zNCdTua7mytGY
         UnLZ8hCQ17Qr2pvkKcVyJ/FW4Ts5YPCvnD7tjfPT0UWu3Uk1NAINGvmaN4T3snJZm120
         WA3G3HjsR0dwUyQWTwAWayQyDJQut9xyRpKIGerCE3pYiLFGmcvv+oLVsBLJI0J6oDla
         1RYMIx0QA77S91ehfE3fVzh53HT5YszdIAjNwmYXyBrGDVXsiR9myWRSWlIfdIGDN9lh
         fWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486078; x=1792090878;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZaD67jW1zaHMwLOSmvc/1aeKMLwK1RpzPD9+yhLQ1do=;
        b=m+8Mo5den/8cJmI+zVRzBSQGU/SA+UwY0F5A9PYozrw+nVMcUNrTD2NQK0B9cZndCZ
         zrqtkwkNcEOceOoPFowQOxfgMuTBp2EvGCfhhmuHpodGN0LmmleY9C9dl2CbZk4ihuYq
         GS0GLYidfLTojVDq+sUz9EZr3UfuVSeHV0IlEGzIfyV+y52EqnHV46ISi/RiZ0zGRm1d
         AOreIt4Q0VQ7po7q1BYwI1o6OgBBme9dSL4q/OkJM+PUgz9nk2RFH+UXq29BJxlExQ4f
         FLA85NfAwJ6EP/WGwQePbqTPeDoVpuCgcMfx6iqS28M0hc6H19m7IhdgigEbiOCcLgxu
         a7rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybdovYjG86DdiEGVwk/psTmRDMVDC8n3RcXqPQ8X/ScGuiasCj2o3EAWO+AEzLlywOVSLLSZGpfiQ4rNQdGfE5gFlL@alsa-project.org
X-Gm-Message-State: AFq9FYK2NxcWoTNN460pa423IVd72x0yGSMJ1qtNGIuWH0DbY0PqS2r4
	3ZibKPHPMU7gxKcpfhvTcSlsG1UJNh9BR0Grmy5CE94rHPJWtggVN0Cafb3zfCNaPWM=
X-Gm-Gg: AYBFou1+KXD5olG0q9Hr29Qt+RRRKymXuZdeezNAaVWYK4g8OskCNk7/rG4zE/RFLtV
	ejLed9Wkzp46hZAAQbuj8DDUqPulqtiwbQaVeQcd88ZbnUmxMXKSDZ5MMS9STiXachioGTlRgdu
	NbMYhYnZAHAnWI+LpdJOdsHfrMSjAaCQDh+MmWX56GGeEIXoRJQ3Ys6/J2LhLbOLx9/ZdxumEx6
	mthI76FpPXvDZ/TERgnqnd6jFcymOkz7NSFqM7EQAKekK3QGJPKlA/VQTEk5P32oEWHmWN2CPPM
	GUisN3Dw80aNyoi8ndLeUx64DWPRl30WCPFLCY6HGvAXbFCUeTJw6vwztnv4GqhPe7X5BiW/+pw
	/gDmceKlX/BXpUzY6BpX/cccd3BwzwOlzsco2n5H+4GoeyP3bD3aGt2Y14/kA5kblJMDid19oU/
	DROCEptoe2npQ1yHAtdP+l+UvDLd+Brv5zO5ReDq4kZOGtXVlrZeBcGgZ0nm336Cas1qcgl/Pi3
	rXTnFGQKpAx+90UG8hEZFxC2j9YkDDL6kX5NC7S74dhzq1AX36m2JZGLuYNBXbzRnuAcPg=
X-Received: by 2002:a05:7301:7305:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3515dda8789mr6908917eec.16.1791486076904;
        Thu, 08 Oct 2026 12:01:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:15 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] ASoC: SOF: topology: Parse DAI type token for
 dspless mode
Date: Thu,  8 Oct 2026 15:01:03 -0400
Message-ID: <20261008190108.96660-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: artem@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-sound-open-firmware.alsa-project.org-0;
 header-match-sound-open-firmware.alsa-project.org-1; emergency;
 member-moderation
Message-ID-Hash: ID2ILPRRTKAZOG3UPAJJQJRWC6NLM4UV
X-Message-ID-Hash: ID2ILPRRTKAZOG3UPAJJQJRWC6NLM4UV
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:40:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ID2ILPRRTKAZOG3UPAJJQJRWC6NLM4UV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit f9618ff105a0f6f5a6beed3edc557ea6a7d26df6 ]

Starting with LunarLake, the dspless mode can handle SoundWire/ALH,
DMIC and SSPs, so we need to identify the dai type from topology.

[ Backport to 6.6.y: 6.6.y still uses a stack-allocated snd_sof_dai in
  the dspless topology path; parse the DAI type into that existing object
  before connecting it. ]

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213101247.28887-12-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This is the prerequisite needed for the CVE-2025-21870 backport. Stores and
populates each SOF DAI type so the following ALH hardening can distinguish
ALH DAI widgets from same-name non-DAI or non-ALH widgets.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 sound/soc/sof/ipc4-topology.c |  1 +
 sound/soc/sof/sof-audio.h     |  1 +
 sound/soc/sof/topology.c      | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 39e4f0fdd5e4..18096aefce13 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -534,6 +534,7 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 	dev_dbg(scomp->dev, "dai %s node_type %u dai_type %u dai_index %d\n", swidget->widget->name,
 		node_type, ipc4_copier->dai_type, ipc4_copier->dai_index);
 
+	dai->type = ipc4_copier->dai_type;
 	ipc4_copier->data.gtw_cfg.node_id = SOF_IPC4_NODE_TYPE(node_type);
 
 	pipe_widget = swidget->spipe->pipe_widget;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 7620596ead07..13b9026ffd4d 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -514,6 +514,7 @@ struct snd_sof_route {
 struct snd_sof_dai {
 	struct snd_soc_component *scomp;
 	const char *name;
+	u32 type;
 
 	int number_configs;
 	int current_config;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 7eb8eb35b137..011095722a80 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2364,7 +2364,10 @@ static int sof_dspless_widget_ready(struct snd_soc_component *scomp, int index,
 				    struct snd_soc_tplg_dapm_widget *tw)
 {
 	if (WIDGET_IS_DAI(w->id)) {
+		static const struct sof_topology_token dai_tokens[] = {
+			{SOF_TKN_DAI_TYPE, SND_SOC_TPLG_TUPLE_TYPE_STRING, get_token_dai_type, 0}};
 		struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+		struct snd_soc_tplg_private *priv = &tw->priv;
 		struct snd_sof_widget *swidget;
 		struct snd_sof_dai dai;
 		int ret;
@@ -2375,6 +2378,14 @@ static int sof_dspless_widget_ready(struct snd_soc_component *scomp, int index,
 
 		memset(&dai, 0, sizeof(dai));
 
+		ret = sof_parse_tokens(scomp, &dai.type, dai_tokens, ARRAY_SIZE(dai_tokens),
+				       priv->array, le32_to_cpu(priv->size));
+		if (ret < 0) {
+			dev_err(scomp->dev, "Failed to parse DAI tokens for %s\n", tw->name);
+			kfree(swidget);
+			return ret;
+		}
+
 		ret = sof_connect_dai_widget(scomp, w, tw, &dai);
 		if (ret) {
 			kfree(swidget);
-- 
2.39.5

