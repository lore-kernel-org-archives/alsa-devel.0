From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v4 15/24] ASoC: qdsp6: q6core: Add q6core
 driver
Date: Tue, 13 Mar 2018 17:16:33 +0530
Message-ID: <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id D1C662670F8
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 12:46:44 +0100 (CET)
In-Reply-To: <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
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
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, spatakok@qti.qualcomm.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[..]
> +static int q6core_get_svc_versions(struct q6core *core)
> +{
> +	struct apr_device *adev = core->adev;
> +	struct apr_hdr hdr = {0};
> +	int rc;
> +
> +	core->get_version_supported = true;

core->get_version_supported should be set to true only after we get proper response from adsp in callback(). In case,we get wrong response from adsp, memory for g_core->svc_version
  will not get allocated and there will be NULL pointer dereference in  q6core_get_svc_api_info() in below statement
+	} else if (g_core->get_version_supported) {
+		for (i = 0; i < g_core->svc_version->num_services; i++) {
  

> +	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
> +	hdr.pkt_size = APR_HDR_SIZE;
> +	hdr.opcode = AVCS_GET_VERSIONS;
> +
> +	rc = apr_send_pkt(adev, &hdr);
> +	if (rc < 0)
> +		return rc;
> +
