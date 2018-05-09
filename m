From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 08/24] ASoC: qdsp6: q6core: Add q6core
	driver
Date: Wed, 9 May 2018 07:06:04 +0100
Message-ID: <9ea47387-d849-19e8-1075-74a5e7e11a22@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-9-srinivas.kandagatla@linaro.org>
 <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DA442672AF
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 08:06:06 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id n10-v6so25250150wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 08 May 2018 23:06:06 -0700 (PDT)
In-Reply-To: <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Banajit for the review!

On 04/05/18 20:04, Banajit Goswami wrote:
>> +
>> +static int q6core_callback(struct apr_device *adev, struct 
>> apr_resp_pkt *data)
>> +{
>> +    struct q6core *core = dev_get_drvdata(&adev->dev);
>> +    struct aprv2_ibasic_rsp_result_t *result;
>> +    struct apr_hdr *hdr = &data->hdr;
>> +
>> +    result = data->payload;
>> +    switch (hdr->opcode) {
>> +    case APR_BASIC_RSP_RESULT:{
>> +        result = data->payload;
>> +        switch (result->opcode) {
>> +        case AVCS_GET_VERSIONS:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_GET_FWK_VERSION:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->fwk_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_ADSP_EVENT_GET_STATE:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_state_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        }
>> +        break;
>> +    }
>> +    case AVCS_CMDRSP_GET_FWK_VERSION: {
>> +        struct avcs_cmdrsp_get_fwk_version *fwk;
>> +        int bytes;
>> +
>> +        fwk = data->payload;
>> +        core->fwk_version_supported = true;
>> +        bytes = sizeof(*fwk) + fwk->num_services *
>> +                sizeof(fwk->svc_api_info[0]);
>> +
>> +        core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
>> +        if (!core->fwk_version)
>> +            return -ENOMEM;
> When the above allocation fails,  core->fwk_version_supported will be 
> still true, and q6core_get_fwk_versions() will return 0 (timeout as 
> core->resp_received will not be set to true). This can cause a NULL 
> pointer dereference inside the if() loop pointed below (added comment).
> Please move the line to set core->fwk_version_supported flag to after 
> memset() to copy fwk version info.

Yes, makes sense, I fixed this and other comments in v8.

thanks,
srini
>> +
>> +        memcpy(core->fwk_version, data->payload, bytes);
>> +
>> +        core->resp_received = true;
>> +
>> +        break;
>> +    }
>> +    case AVCS_GET_VERSIONS_RSP: {
>> +        struct avcs_cmdrsp_get_version *v;
>> +        int len;
>> +
>> +        v = data->payload;
>> +        core->get_version_supported = true;
>> + 
