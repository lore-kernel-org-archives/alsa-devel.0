From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 4/4] ASoC: codecs: tas5720: add TAS5722 TDM
 slot width setting support
Date: Mon, 15 Jan 2018 08:50:38 -0600
Message-ID: <5111739c-df33-6a75-5ccf-2a2dc79f015d@ti.com>
References: <20171211190157.12371-1-afd@ti.com>
 <20171211190157.12371-4-afd@ti.com> <20171212120232.GI16323@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF9E267515
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:50:41 +0100 (CET)
In-Reply-To: <20171212120232.GI16323@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/12/2017 06:02 AM, Mark Brown wrote:
> On Mon, Dec 11, 2017 at 01:01:57PM -0600, Andrew F. Davis wrote:
> 
>> +	/* Configure TDM slot width. This is only applicable to TAS5722. */
>> +	if (tas5720->devtype == TAS5722) {
>> +		ret = snd_soc_update_bits(codec, TAS5722_DIGITAL_CTRL2_REG,
>> +					  TAS5722_TDM_SLOT_16B,
>> +					  slot_width == 16 ?
>> +					  TAS5722_TDM_SLOT_16B : 0);
>> +		if (ret < 0)
>> +			goto error_snd_soc_update_bits;
>> +	}
> 
> Use a switch statement, that way additional variants can be handled more
> sensibly.
> 

Will fix.
