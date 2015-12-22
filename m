From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Can we remove the rtd_aux for the aux_devs?
Date: Tue, 22 Dec 2015 16:15:26 +0800
Message-ID: <5679069E.6070106@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk> <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk> <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk> <566FC9F6.8050107@linux.intel.com>
 <20151215112324.GX5727@sirena.org.uk> <567121DC.5080601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 197642651DB
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 08:58:45 +0100 (CET)
In-Reply-To: <567121DC.5080601@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

Revise the subject.

Could someone clarify if the rtd_aux in struct snd_soc_card is still needed?

We want to replace the aux_dev by aux_component.
If the rtd_aux is no longer needed, we can remove the array and it will 
become easier to handle an aux_dev as a generic component.

Thanks
Mengdong

On 12/16/2015 04:33 PM, Mengdong Lin wrote:
>
>
> On 12/15/2015 07:23 PM, Mark Brown wrote:
>> On Tue, Dec 15, 2015 at 04:06:14PM +0800, Mengdong Lin wrote:
>>
>>> I still have some basic questions:
>>
>>> 1. What are the typical usages for aux_dev?
>>>     For CODEC<->CODEC link or external headset detection chip?
>>
>> Neither, it's for analogue devices.
>
> Got it. Thanks!
>
>>
>>> 2. Why we need the rtd array 'rtd_aux' for the aux_devs?
>>>     If the codec has DAIs and used by a DAI link, the ASoC will
>>> create a rtd
>>> for the link.
>>
>> There are (or were at the time) assumptions in drivers that there will
>> be a rtd there so it was easier to provide a stub.
>>
>
> Can we remove this rtd array if current driver does not need the stub?
>
> For the replacement of aux_dev by aux_component, can we define like below?
>
> struct snd_soc_aux_component {
>      const char *comp_name; ... no longer assume they're only codecs
>      const char *comp_of_node;
>
>      /* machine specific init */
>      int (*init)(struct snd_soc_component *componnent);
> };
>
> The ASoC can use the comp_name or comp_of_node to find the components
> and probe them.
>
> Thanks
> Mengdong
>
