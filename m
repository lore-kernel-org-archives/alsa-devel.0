Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F0EC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Apr 2022 09:24:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6570F17B4;
	Fri, 15 Apr 2022 11:24:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6570F17B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650014690;
	bh=9yrlBdxWRraKr4I/zH6Y0GKcBK7Q98TB+4KqxyV/oIs=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MDCMcpJcoMg3/z5wVyo1J9xMD1aZUUSY4G3ZwfWxLqboqoZ/MyPY9vhaok5UIQwJs
	 lYR884ZZMh6VkJIAd0mo0RQqAfFjO48KyY1R9Xdp3O6Lpj6KW2dzSTfCUGIMxuvHRz
	 vhW+Wojcr6/QopgHUqFvu5o798MbRAbaUoFY2p/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2258F800AE;
	Fri, 15 Apr 2022 11:23:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13B41F8016A; Fri, 15 Apr 2022 11:23:58 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E0D8F8012E
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2022 11:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E0D8F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="dhjnpSZ0"
Received: by mail-pg1-x533.google.com with SMTP id q12so6875551pgj.13
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2022 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=yaJKtcI79Sr5OPi0ROX2doW6FLEyXaOfN/NlVNVwJrk=;
 b=dhjnpSZ0xDGfB4jrW8GTNHUYqTmw8gXJjsRf8ctVoFqMDUra1ZneE01RZXZkqHYsKO
 uz2/Xl6rPhBChk5zMDNeUk4sf9ZGovLBTGnebEgHqtICREq4Az+SzgM/6Od/8oZ1RnTb
 cq3HPy7Hjh3GPMe3DsJJwPrD8Su7QSKiKlP6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=yaJKtcI79Sr5OPi0ROX2doW6FLEyXaOfN/NlVNVwJrk=;
 b=tyN5Y1KwseFWgt+VDO77lCQHifn+b3+1Vli5dXQtSuG6RDT+sWBX6qZ3hZf+YZ7DPl
 iMi1iQVBbITzyqM279h9ytYsnuHO3xjsizo9ng1gUBIhAK0eJcGHRoFSBWJrGcQlAwtj
 u5KDH7aZfJizJmpyk1NTQaAOnsW2IqUhsHMBOR7eIkyEEUGTERJb0BuZQ/YR6LpKx+ml
 l0FL9dRXyOMiDInaAGcLV4GN/DSc9dZ5xtcXp7Uy9aJT2p5gcPpyGkWurYTPTTZ5YZWw
 Gefk17TVaLl6bB5BuCvq5D6+dphpAKJx0LdVq8CS2pQ1ShNNxhD3do9Eb+K26pKsLBkt
 L/4Q==
X-Gm-Message-State: AOAM533GG6jS5nbsv0pIn+9hyYnsaJP/esrnfWLUYE76Lu7f5CCHVMcG
 CsbljctofMlFS6GFAD3FaSF/5Q==
X-Google-Smtp-Source: ABdhPJxksBlVEoOObfJp2lC3bMnUyL2Cby7j0WZCOZ/gCpA5vO98ZFd5WabroIkjn7Sh9QShaXx5nA==
X-Received: by 2002:a63:cf0c:0:b0:380:fb66:fa2a with SMTP id
 j12-20020a63cf0c000000b00380fb66fa2amr5715841pgg.273.1650014632902; 
 Fri, 15 Apr 2022 02:23:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ff9f:dddf:d1f3:472c])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a63eb14000000b0039e28245722sm3946395pgh.54.2022.04.15.02.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Apr 2022 02:23:52 -0700 (PDT)
Date: Fri, 15 Apr 2022 18:23:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: out-of-bounds access in sound/soc/sof/topology.c
Message-ID: <Ylk5o3EC/hyX5UQ0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Tomasz Figa <tfiga@chromium.org>,
 Mark Brown <broonie@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>,
 sound-open-firmware@alsa-project.org
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

Hi,

I'm running 5.10.111 LTS, so if this has been fixed already then we definitely
want to cherry pick the fix for -stable.


Anonymous union in this struct is of zero size

/* generic control data */
struct sof_ipc_ctrl_data {
        struct sof_ipc_reply rhdr;
        uint32_t comp_id;

        /* control access and data type */
        uint32_t type;          /**< enum sof_ipc_ctrl_type */
        uint32_t cmd;           /**< enum sof_ipc_ctrl_cmd */
        uint32_t index;         /**< control index for comps > 1 control */

        /* control data - can either be appended or DMAed from host */
        struct sof_ipc_host_buffer buffer;
        uint32_t num_elems;     /**< in array elems or bytes for data type */
        uint32_t elems_remaining;       /**< elems remaining if sent in parts */

        uint32_t msg_index;     /**< for large messages sent in parts */

        /* reserved for future use */
        uint32_t reserved[6];

        /* control data - add new types if needed */
        union {
                /* channel values can be used by volume type controls */
                struct sof_ipc_ctrl_value_chan chanv[0];
                /* component values used by routing controls like mux, mixer */
                struct sof_ipc_ctrl_value_comp compv[0];
                /* data can be used by binary controls */
                struct sof_abi_hdr data[0];
        };
} __packed;

sof_ipc_ctrl_value_chan and sof_ipc_ctrl_value_comp are of the same
size - 8 bytes, while sof_abi_hdr is much larger - _at least_ 32 bytes
(`__u32 data[0]` in sof_abi_hdr suggest that there should be more
payload after header). But they all contribute 0 to sizeof(sof_ipc_ctrl_data).

Now control data allocations looks as follows

	scontrol->size = struct_size(scontrol->control_data, chanv,
				     le32_to_cpu(mc->num_channels));
	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);

Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)

For some reason it uses sizeof(sof_ipc_ctrl_value_chan), which is not
the largest member of the union.

And this is where the problem is: in order to make control->data.FOO loads
and stores legal we need mc->num_channels to be of at least 4. So that

   sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)

                92           +        4         *            8

will be the same as

   sizeof(sof_ipc_ctrl_data) + sizeof(sof_abi_hdr).

                92           +           32

Otherwise scontrol->control_data->data.FOO will access nearby/foreign
slab object.

And there is at least one such memory access. In sof_get_control_data().

	wdata[i].pdata = wdata[i].control->control_data->data;
	*size += wdata[i].pdata->size;

pdata->size is at offset 8, but if, say, mc->num_channels == 1 then
we allocate only 8 bytes for pdata, so pdata->size is 4 bytes outside
of allocated slab object.

Thoughts?
