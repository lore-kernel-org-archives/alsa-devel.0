Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415B8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Apr 2022 13:27:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A182A1768;
	Wed, 27 Apr 2022 15:27:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A182A1768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651066072;
	bh=0gg4zAaW3Fxg6bfWylryNsFFRlXwZKybtjXppNNzGmY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghtM0Aq0hMCQ88IQ7jaRiHOacHvqRy8vWiNGP0NfRxCgtbDWjV8vHid/hZvJuhkyH
	 ghesuEtSr5XC4TCyZciTaLQeSnE07vUwNgloPW+HJNqCphphg0+9AHLvu0FocmkBo6
	 zsSaE33Rhxb6ZMeIDWF4P/OBVSfvSSNTulMW2N/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D91FF80155;
	Wed, 27 Apr 2022 15:27:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0633F8016E; Wed, 27 Apr 2022 15:27:00 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB922F80152
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 15:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB922F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="h2/h2ihw"
Received: by mail-pl1-x62c.google.com with SMTP id p6so1531648plf.9
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gNEfFcuQCxHkwowKKGRmRXvOTPfbs7KEQcN9Gn/K//Y=;
 b=h2/h2ihwbOLDCNvOKLI06MniqP53yxcV/4o+cJAzBKHWIRzh+4oASGhyvAKTkqv5qI
 9W5N4o7ieGmeN1+R4fCgx3BaVYWio7Be+olfr8e25clJgJEbW6Phzn/HY7D1NdKBD+U3
 +S5LTB5CJXdGRlcb6+3PPS8Z68PC/Mvznecy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gNEfFcuQCxHkwowKKGRmRXvOTPfbs7KEQcN9Gn/K//Y=;
 b=v3blFxvfCNpuPNY2xi5mHjMtcwiBjKNLOQc244yr5t7DauYLghU4PNmSYqu5Yp8X58
 JnxWjxIKw5HO/Ty/5O3AicPEU4MsZK2SpdGrpuiijafib+UTRvOr2hg+RyV9B3JtPiIe
 mNypIN5KUCMQEHIL7oX65e6BK95nr4ztYzqO5p6NX2IzBq8N9FWqzNoeAYSsS67LVqpn
 /3MK4BO8P4ax4RThnPwmgphFxuymHBjsyn9M9QuQzJsJhY5ewTZ0//HCXqeCTpY8qL0/
 skQ9MR4HEOD66HzMRr49Cl1uumGinUhvQu+DhHc+UjF11+xbe/4URzu+DhATqYdbFKqz
 rqJA==
X-Gm-Message-State: AOAM5337KiFvDSwqpxAioGGJgF2tPPiczjw/NX9/3n4uj4jevVT5f5ow
 JW7CuLzCjTitQsuxTpYgSgnmiQ==
X-Google-Smtp-Source: ABdhPJzMzOoLE+wZ4YoQL8moHGbTtkZDQGztzsqHeDS86H3LFKLSNbDG1u5iEKidhuv1XnpS54ZKKA==
X-Received: by 2002:a17:90b:1b4f:b0:1d2:a09e:1fc6 with SMTP id
 nv15-20020a17090b1b4f00b001d2a09e1fc6mr43436653pjb.147.1651066015294; 
 Wed, 27 Apr 2022 06:26:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e2d:263:26e7:c039])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a62ed08000000b0050a90fd59d5sm18370627pfh.50.2022.04.27.06.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 06:26:54 -0700 (PDT)
Date: Wed, 27 Apr 2022 22:26:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3] ASoC: SOF: ipc3-topology: Correct get_control_data
 for non bytes payload
Message-ID: <YmlEmrJoMtoNcEnw@google.com>
References: <20220427124025.14615-1-peter.ujfalusi@linux.intel.com>
 <YmlAOm7AlZGpQLPS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlAOm7AlZGpQLPS@google.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, cujomalainey@google.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On (22/04/27 22:08), Sergey Senozhatsky wrote:
> 
> A corresponding 5.10 backport that "works on my computer".
> 

+ comment

---
 sound/soc/sof/topology.c | 43 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index c1fc7bcf4eb5..5f14ac120742 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -50,7 +50,8 @@
 struct sof_widget_data {
 	int ctrl_type;
 	int ipc_cmd;
-	struct sof_abi_hdr *pdata;
+	void *pdata;
+	size_t pdata_size;
 	struct snd_sof_control *control;
 };
 
@@ -2100,6 +2101,7 @@ static int sof_get_control_data(struct snd_soc_component *scomp,
 				size_t *size)
 {
 	const struct snd_kcontrol_new *kc;
+	struct sof_ipc_ctrl_data *cdata;
 	struct soc_mixer_control *sm;
 	struct soc_bytes_ext *sbe;
 	struct soc_enum *se;
@@ -2136,16 +2138,29 @@ static int sof_get_control_data(struct snd_soc_component *scomp,
 			return -EINVAL;
 		}
 
-		wdata[i].pdata = wdata[i].control->control_data->data;
-		if (!wdata[i].pdata)
-			return -EINVAL;
+		cdata = wdata[i].control->control_data;
+		if (widget->dobj.widget.kcontrol_type[i] == SND_SOC_TPLG_TYPE_BYTES) {
+			/*
+			 * make sure data is valid - data can be updated at
+			 * runtime
+			 */
+			if (cdata->data->magic != SOF_ABI_MAGIC)
+				return -EINVAL;
 
-		/* make sure data is valid - data can be updated at runtime */
-		if (widget->dobj.widget.kcontrol_type[i] == SND_SOC_TPLG_TYPE_BYTES &&
-		    wdata[i].pdata->magic != SOF_ABI_MAGIC)
-			return -EINVAL;
+			wdata[i].pdata = cdata->data->data;
+			wdata[i].pdata_size = cdata->data->size;
+		} else {
+			/* points to the control data union */
+			wdata[i].pdata = cdata->chanv;
+			/*
+			 * wdata[i].control->size is calculated with struct_size
+			 * and includes the size of struct sof_ipc_ctrl_data
+			 */
+			wdata[i].pdata_size = wdata[i].control->size -
+					      sizeof(struct sof_ipc_ctrl_data);
+		}
 
-		*size += wdata[i].pdata->size;
+		*size += wdata[i].pdata_size;
 
 		/* get data type */
 		switch (wdata[i].control->cmd) {
@@ -2236,10 +2251,12 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 	 */
 	if (ipc_data_size) {
 		for (i = 0; i < widget->num_kcontrols; i++) {
-			memcpy(&process->data + offset,
-			       wdata[i].pdata->data,
-			       wdata[i].pdata->size);
-			offset += wdata[i].pdata->size;
+			if (!wdata[i].pdata_size)
+				continue;
+
+			memcpy(&process->data[offset], wdata[i].pdata,
+			       wdata[i].pdata_size);
+			offset += wdata[i].pdata_size;
 		}
 	}
 
-- 
2.31.0

