From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 13/24] ASoC: qdsp6: q6adm: Add q6adm driver
Date: Wed, 9 May 2018 09:08:01 +0100
Message-ID: <d85db592-903a-2da3-4ff1-e153b3dde2cb@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-14-srinivas.kandagatla@linaro.org>
 <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 09/05/18 08:55, Banajit Goswami wrote:
>> + */
>> +int q6adm_close(struct device *dev, int port_id, int perf_mode, int 
>> copp_idx)
> perf_mode unused param. Remove for now. Can be added back when needed.
> 
> Otherwise LGTM.
Yep, will do that thanks.

--srini
> Once fixed above, add acked-by
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
