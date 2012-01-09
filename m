From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Mon, 09 Jan 2012 09:21:19 +0100
Message-ID: <4F0AA37F.5050602@metafoo.de>
References: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
	<20120108202332.GE29065@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-233.synserver.de (smtp-out-233.synserver.de
	[212.40.185.233])
	by alsa0.perex.cz (Postfix) with SMTP id 300231039B5
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 09:20:32 +0100 (CET)
In-Reply-To: <20120108202332.GE29065@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 01/08/2012 09:23 PM, Mark Brown wrote:
> On Sat, Jan 07, 2012 at 05:53:26PM -0800, Patrick Lai wrote:
>> ASoC currently has macro for double 8-bit signed TLV.
>> Enhance info,get,put callback functions of SOC_DOUBLE_S8_TLV
>> for single single 8-bit signed TLV.
> 
> Actually now I look at this I'm not sure that the existing macro isn't
> just misnamed:
> 
> | #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
> 
> Since no shifts are specified the signature is just the same as your
> SOC_SINGLE_S8_TLV:
> 

There is a shift, but it is hard coded to 8 in snd_soc_get_volsw_s8, which
isn't considered by the patch currently. So either SOC_DOUBLE_S8_TLV should
initialize rshift to 8 or a shift and rshift parameter should be added. It
might also makes sense to add a shift parameter to SOC_SINGLE_S8_TLV as well.

- Lars
