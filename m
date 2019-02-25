From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Sound-open-firmware]  [v4,
 00/14] ASoC: Sound Open Firmware (SOF) core
Date: Mon, 25 Feb 2019 10:16:02 +0000
Message-ID: <89a64af2-522b-7b90-8f46-6c50b4f773d3@linaro.org>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <1550520188-9253-1-git-send-email-xiaoxiang@xiaomi.com>
 <2ad7bf66-a0a9-b97d-e1b1-48e3f9c699c5@linaro.org>
 <CAH2Cfb8XZTD1a+2vm2W7mB8Bfyb1v-ArCw8rf0+TjXGPK0msKg@mail.gmail.com>
 <a499dec8-ed61-dd9a-77dc-e60225f79e46@linux.intel.com>
 <20190221043925.GF2736@vkoul-mobl>
 <7a67b767-5127-1844-20c5-06ef5946e85d@linux.intel.com>
 <CAH2Cfb9EM0DqFSpJqFggWdg+VhCtXNXq5EXz1HM+xrTA8G5oJQ@mail.gmail.com>
 <750e7de7-eb2c-81f3-32f0-420c89e7b34b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3346AF89634
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 11:16:05 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id m1so7476738wml.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 02:16:05 -0800 (PST)
In-Reply-To: <750e7de7-eb2c-81f3-32f0-420c89e7b34b@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, xiang xiao <xiaoxiang781216@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Kumar Gala <kumar.gala@linaro.org>, andriy.shevchenko@intel.com, tiwai@suse.de, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org, Bjorn Andersson <bjorn.andersson@linaro.org>, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>, sound-open-firmware@alsa-project.org, wendy.liang@xilinx.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 22/02/2019 14:48, Pierre-Louis Bossart wrote:
>> drivers\rpmsg\rpmsg_internal.h) but keep the upper layer API, qcomm
>> utilize this for glink and smd actually.
> 
> That's interesting. Can anyone at Qualcomm/Linaro point to actual 
> examples of the implementation, so that we get a better picture of the 
> split between 'upper layer API' and 'custom mechanism'?
> 
Here is an example of Qualcomm Audio Hexagon DSP :

Remoteproc driver to start dsp is at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_common.c?h=v5.0-rc8

Which registers rpmsg channels based of glink or SMD transport once dsp 
is booted at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/rpmsg/qcom_glink_smem.c?h=v5.0-rc8 
and few other files in drivers/rpmsg/

This rpmsg driver driver will create and destroy 
endpoints/edges/channels/services based on dsp services and dsp 
notifications. These notifications are passed to service drivers via 
rpmsg device driver model.

One example of audio service driver is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/apr.c?h=v5.0-rc8

and the audio drivers are at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/qcom/qdsp6?h=v5.0-rc8

An example Device Tree of audio and DSP compute offload would look like 
this:

adsp-pil {
	compatible = "qcom,msm8996-adsp-pil";
	smd-edge {
		label = "lpass";
                 mboxes = <&apcs_glb 8>;
                 qcom,smd-edge = <1>;
                 qcom,remote-pid = <2>;

		apr {
                 	compatible = "qcom,apr-v2";
                         qcom,smd-channels = "apr_audio_svc";
			...
		};

                 fastrpc {
			qcom,smd-channels = "fastrpcsmd-apps-dsp";
			compatible = "qcom,fastrpc";
			...
		}
		...
	};
};

thanks,
srini
