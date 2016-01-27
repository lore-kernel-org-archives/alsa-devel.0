From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: topology: Add support for FE
 DAI & DAI links
Date: Wed, 27 Jan 2016 16:03:42 +0800
Message-ID: <56A879DE.60105@linux.intel.com>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <1453721870.2557.28.camel@loki> <20160125153954.GU6588@sirena.org.uk>
 <s5h7fixacj2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A88922602F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 09:04:08 +0100 (CET)
In-Reply-To: <s5h7fixacj2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, vinod.koul@intel.com, mengdong.lin@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

Thanks for your comments, Takashi!

Hi Mark,

Could you help to review the other 2 patches when convenient?

Thanks
Mengdong

On 01/25/2016 11:45 PM, Takashi Iwai wrote:
> On Mon, 25 Jan 2016 16:39:54 +0100,
> Mark Brown wrote:
>>
>> On Mon, Jan 25, 2016 at 11:37:50AM +0000, Liam Girdwood wrote:
>>
>>> Mengdong, it might be easier to split this patch into 1/3 and 2,3/3
>>> since 1/3 will be in Takashi's tree, but then that might not be needed
>>> it Takashi and Mark agree.
>>
>> They'll need to all end up in one tree at some point since at least one
>> of the ASoC patches depends on the ALSA core patch.  Usually we do this
>> by having me apply things (IIRC Takashi has already acked the ALSA
>> patch).
>
> Yep, my previous ack is found at msg id <s5hziwccx7f.wl-tiwai@suse.de>
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
