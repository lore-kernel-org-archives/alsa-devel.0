Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851EEC04A95
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 13:13:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EDFB52FB;
	Tue, 25 Oct 2022 15:12:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EDFB52FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666703590;
	bh=56kCkXA+Fu1FNbJHXpqapTMEgHDBX8jxRHD4syQBqeU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlnScXlx1dTj8hzApzzTEO+zRmENa9jUM5gUBgJjx4a5Ge5NpjXn/GqkK238oEYFk
	 NJ+1Q9La+BC0erR1UAELvxtwXboPSrXtZ561dtrEeGqIDeko6zIQh2TAVVY+lcDKQs
	 YmdiYT1pOgPPPoGOOMwuFeh/MASMPL75rZJ7LoBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EFEDF8047D;
	Tue, 25 Oct 2022 15:12:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06213F8049E; Tue, 25 Oct 2022 15:12:19 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88D0CF80240
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 15:12:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88D0CF80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="gzrPgR8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666703533; x=1698239533;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=56kCkXA+Fu1FNbJHXpqapTMEgHDBX8jxRHD4syQBqeU=;
 b=gzrPgR8q5SrFTzAFce1DMqqrPFcp8tGECJxfso9qk7cOkf89iU2SKHg7
 U+JwAOijAvwY/cj+BNZFPoQcxhrsnUB1vB61kmzlOX+9JMjkjRlScsw21
 jCcQQJWBdJ02JqEDSlDHh1SW7d49RK/P5KyEUp+ZJuvtqXmdo5Cohr76r
 K8WWD8DM86YZtg77gC5PWlRQOJDY9Pm/DP0xnMl0Tp9j4oiCn/JxrEU0e
 PCRSO2ZBAiWa/Qh3PaBYHJel198G9vuslmbafSZ3fUCgZNSqs1/p3kU2Q
 9WWMgL6+axuRqJ7GzEA4d3zgcY/GaVa/sYQvtXJkLasRM9kqkN89WLjq+ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393983442"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; d="scan'208";a="393983442"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2022 06:12:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582766846"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; d="scan'208";a="582766846"
Received: from agsteede-mobl.ger.corp.intel.com (HELO [10.252.12.174])
 ([10.252.12.174])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2022 06:12:06 -0700
Message-ID: <57a91232-f747-7033-217a-802c1ab67f6d@linux.intel.com>
Date: Tue, 25 Oct 2022 16:12:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [bug report] ASoC: SOF: ipc4-loader: Support for loading external
 libraries
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <Y1fP4QN7kA16mYwI@kili>
Content-Language: en-US
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <Y1fP4QN7kA16mYwI@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

Hi Dan,

On 25/10/2022 15:00, Dan Carpenter wrote:
> Hello Peter Ujfalusi,
> 
> The patch 73c091a2fe96: "ASoC: SOF: ipc4-loader: Support for loading
> external libraries" from Oct 20, 2022, leads to the following Smatch
> static checker warning:
> 
> 	sound/soc/sof/ipc4-loader.c:207 sof_ipc4_load_library_by_uuid()
> 	warn: 'payload_offset' unsigned <= 0
> 
> sound/soc/sof/ipc4-loader.c
>     167 static int sof_ipc4_load_library_by_uuid(struct snd_sof_dev *sdev,
>     168                                          unsigned long lib_id, const guid_t *uuid)
>     169 {
>     170         struct sof_ipc4_fw_data *ipc4_data = sdev->private;
>     171         struct sof_ipc4_fw_library *fw_lib;
>     172         const char *fw_filename;
>     173         size_t payload_offset;
>                 ^^^^^^^^^^^^^^^^^^^^^
> 
>     174         int ret, i, err;
>     175 
>     176         if (!sdev->pdata->fw_lib_prefix) {
>     177                 dev_err(sdev->dev,
>     178                         "Library loading is not supported due to not set library path\n");
>     179                 return -EINVAL;
>     180         }
>     181 
>     182         if (!ipc4_data->load_library) {
>     183                 dev_err(sdev->dev, "Library loading is not supported on this platform\n");
>     184                 return -EOPNOTSUPP;
>     185         }
>     186 
>     187         fw_lib = devm_kzalloc(sdev->dev, sizeof(*fw_lib), GFP_KERNEL);
>     188         if (!fw_lib)
>     189                 return -ENOMEM;
>     190 
>     191         fw_filename = kasprintf(GFP_KERNEL, "%s/%pUL.bin",
>     192                                 sdev->pdata->fw_lib_prefix, uuid);
>     193         if (!fw_filename) {
>     194                 ret = -ENOMEM;
>     195                 goto free_fw_lib;
>     196         }
>     197 
>     198         ret = request_firmware(&fw_lib->sof_fw.fw, fw_filename, sdev->dev);
>     199         if (ret < 0) {
>     200                 dev_err(sdev->dev, "Library file '%s' is missing\n", fw_filename);
>     201                 goto free_filename;
>     202         } else {
>     203                 dev_dbg(sdev->dev, "Library file '%s' loaded\n", fw_filename);
>     204         }
>     205 
>     206         payload_offset = sof_ipc4_fw_parse_ext_man(sdev, fw_lib);
> --> 207         if (payload_offset <= 0) {
>                     ^^^^^^^^^^^^^^^^^^^
> sof_ipc4_fw_parse_ext_man() returns negative error codes but as size_t.
> It should just return int.  If it returns > INT_MAX that can't work on
> 32bit systems.

Right, this is not looking good.

I think the root of the issue is:
61bafd1c4571 ("ASoC: SOF: Introduce IPC dependent ops for firmware
handling, loading")

Where I have size_t as return value for the parse_ext_manifest callback...

Let me send a quick fix for this alone and prepare a bigger one to sort
out the rest.

>     208                 if (!payload_offset)
>     209                         ret = -EINVAL;
>     210                 else
>     211                         ret = payload_offset;
>     212 
>     213                 goto release;
>     214         }
>     215 
>     216         fw_lib->sof_fw.payload_offset = payload_offset;
>     217         fw_lib->id = lib_id;
>     218 
>     219         /* Fix up the module ID numbers within the library */
>     220         for (i = 0; i < fw_lib->num_modules; i++)
>     221                 fw_lib->modules[i].man4_module_entry.id |= (lib_id << SOF_IPC4_MOD_LIB_ID_SHIFT);
>     222 
>     223         /*
>     224          * Make sure that the DSP is booted and stays up while attempting the
>     225          * loading the library for the first time
>     226          */
>     227         ret = pm_runtime_resume_and_get(sdev->dev);
>     228         if (ret < 0 && ret != -EACCES) {
>     229                 dev_err_ratelimited(sdev->dev, "%s: pm_runtime resume failed: %d\n",
>     230                                     __func__, ret);
>     231                 goto release;
>     232         }
>     233 
>     234         ret = ipc4_data->load_library(sdev, fw_lib, false);
>     235 
>     236         pm_runtime_mark_last_busy(sdev->dev);
>     237         err = pm_runtime_put_autosuspend(sdev->dev);
>     238         if (err < 0)
>     239                 dev_err_ratelimited(sdev->dev, "%s: pm_runtime idle failed: %d\n",
>     240                                     __func__, err);
>     241 
>     242         if (ret)
>     243                 goto release;
>     244 
>     245         ret = xa_insert(&ipc4_data->fw_lib_xa, lib_id, fw_lib, GFP_KERNEL);
>     246         if (unlikely(ret))
>     247                 goto release;
>     248 
>     249         kfree(fw_filename);
>     250 
>     251         return 0;
>     252 
>     253 release:
>     254         release_firmware(fw_lib->sof_fw.fw);
>     255         /* Allocated within sof_ipc4_fw_parse_ext_man() */
>     256         devm_kfree(sdev->dev, fw_lib->modules);
>     257 free_filename:
>     258         kfree(fw_filename);
>     259 free_fw_lib:
>     260         devm_kfree(sdev->dev, fw_lib);
>     261 
>     262         return ret;
>     263 }
> 
> regards,
> dan carpenter

-- 
Péter
