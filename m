From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add
	bindings for APR bus
Date: Fri, 2 Mar 2018 13:13:20 +0000
Message-ID: <2608d36a-cf4e-5b06-a26a-8d4ee0bb41ad@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
 <20180301203413.GN12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 40298267377
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 14:13:22 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id t3so3067142wmc.2
 for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2018 05:13:22 -0800 (PST)
In-Reply-To: <20180301203413.GN12864@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, spatakok@qti.qualcomm.com, Andy Gross <andy.gross@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 01/03/18 20:34, Mark Brown wrote:
> On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
>> On 22/02/18 00:14, Rob Herring wrote:
> 
>>> Am I saying a single DT node for this? Yes, perhaps.
>> Yes, I will give that a go.
>>
>> So we will endup having something like this in DT for one frontend and
>> backend dailink:
> 
> Let's not start encoding DPCM into DT, DPCM is very much an
> implemntation detail of the current stack which we're gradually pushing
> towards replacing with something better.  What we want to be doing is
> just treating components inside the SoC the same as components in a
> CODEC, the routing within a SoC being the same as in a CODEC and
> similarly for externally connected devices.
> 
>> 		fe@1 {
>>                  	is-fe;
>>                          link-name = "MultiMedia1";
> 
> In particular having the concept of "front end" in the DT is *very*
> implementation specific.  We should just be describing the connections
> that exist in the system.
Yep, it makes sense. is-fe flag will be removed in next version, we can 
determine this based on codec dai, so from DT side FE or BE should not 
be any different.

Thanks,
srini

> 
