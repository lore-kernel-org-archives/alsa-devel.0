From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 13:47:06 +0100
Message-ID: <2c1539d7-d1de-f6d2-f30c-f79819ba7f2b@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709124117.GG16082@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/07/18 13:41, Mark Brown wrote:
> This is not the case, the card will be unbound at the ASoC level when
> any of the components are removed and then probed again when they
> reappear.
> 
I will give that a try now!

--srini
