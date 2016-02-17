From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [RFC 0/4] Add support for DAI link addition
 dynamically
Date: Wed, 17 Feb 2016 13:52:41 +0800
Message-ID: <56C40AA9.4050008@linux.intel.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <56C1DF0F.4080503@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FE7A265794
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 06:51:34 +0100 (CET)
In-Reply-To: <56C1DF0F.4080503@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org



On 02/15/2016 10:22 PM, Lars-Peter Clausen wrote:
> On 02/15/2016 01:19 PM, Vaibhav Agarwal wrote:
>> Following patches are based on for-next branch from broonie tree.
>> First 2 patches include changes in existing soc, core framework
>> to prepare for adding support for dynamic DAI link addition/
>> removal
>>
>> Patch 3 & 4 contains actual changes to enable dynamic DAI link
>> support
>>
>> NOTE:
>> Currently, the code is tested on Pandaboad ES revB3 for playback
>> usecase.
>
> Can you outline how exactly that would work?
>
> Thanks,
> - Lars
>
>

In Agarwal's use case, it seems a removable codec driver can be 
registered after the sound card is registered. And the Pandaboard 
machine driver need to add new BE links brought by the new codec 
component, which will further trigger probing of the codec components.

How can the machine driver know a new codec component is registered 
automatically?

Can we add a notification ops like "new_component" to a soc card?
A machine driver can implement this ops.  So when a new component is 
registered to the ASoC core, all instantiated soc cards can get notified 
and the machine driver can check if the new component brings some new 
links to the soc card in this ops. e.g. the Pandaboard machine driver 
can add new BE links for the new codec.

Thanks
Mengdong
