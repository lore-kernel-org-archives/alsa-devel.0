From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Wed, 4 Jan 2017 15:03:48 +0800
Message-ID: <586C9E54.60201@linux.intel.com>
References: <cover.1483418875.git.mengdong.lin@linux.intel.com>
 <0827a46b8200cc3e053f8fc6b3b428eac90a3618.1483418875.git.mengdong.lin@linux.intel.com>
 <1483454417.4555.2.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A13073@shsmsx102.ccr.corp.intel.com>
 <1483471712.4063.17.camel@loki>
 <984e6c66-c1c9-c37b-f6b6-d357cd967d48@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3890C266646
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 08:00:45 +0100 (CET)
In-Reply-To: <984e6c66-c1c9-c37b-f6b6-d357cd967d48@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 01/04/2017 04:09 AM, Pierre-Louis Bossart wrote:
>
>>>> I dont think we need vendor (it just makes it too long). The product
>>>> or board
>>>> name should be unique enough for us to load the correct files.
>>>>
>>>> Liam
>>> Yes, from the sample machines I checked, product or board name are
>>> unique. But I feel there might be the risk that two vendors happen to
>>> use the same product or board name, e.g. "T100TA".
>> I think this would be problematic from a legal/marketing position from
>> two different vendors so it would be unlikely.
>
> Please don't remove the manufacturer name for now...
> Some vendors use product names that are indeed unique and easy enough to
> remember, but others like Lenovo use "1952W5R" or "20C3001VHH" (real
> examples you can Google to see I am not making this up). The board name
> can also be "SKG18 t". I really have no appetite for a UCM directory
> called 20C3001VHH.SKG18t :-)
> I would also be ready to bet that smaller manufacturers in the Chinese
> ecosystem use similar product names at the DMI level. removing the
> vendor name would likely result in mistakes.
> You really want the manufacturer name to make the maintenance of these
> files easier on the rest of us. Sometimes the DMI version field is
> actually more self-explanatory, e.g. "ThinkPad 60" or "ThinkPad 10" for
> the two Lenovo examples, maybe this is something we ought to look at.
>
>

So we'll keep the manufacturer name.

And let's put the "Product version" as well if available, Liam?

I also observed Lenovo puts the the user-friendly name in the product 
version like "Thinkpad S5 Yoga 15", while it product name is 
"20DQA00KCD", no self-explanatory.

It seems different manufacturer tend to put self-explanatory name in 
different fields:
Lenovo thinkpad: product version
Dell: product name
ASUS: both product name and board name
Intel: board name

Do we want some table to specify the field we want for major vendors? So 
we may just pick the most valuable DMI field for the card long name, for 
those manufacturers to save the space. But it may not scale if the 
manufacturer change their preference or use different way for different 
product series, since I only checked a few machines by a few vendors.

Also I wonder if we find the key word like "Dell, HP or ASUS", may we 
not use verbatim copy on the vendor name but just use these key words? 
This can also save some space.

Thanks
Mengdong





> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
