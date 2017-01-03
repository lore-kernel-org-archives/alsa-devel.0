From: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Tue, 3 Jan 2017 14:09:28 -0600
Message-ID: <984e6c66-c1c9-c37b-f6b6-d357cd967d48@intel.com>
References: <cover.1483418875.git.mengdong.lin@linux.intel.com>
 <0827a46b8200cc3e053f8fc6b3b428eac90a3618.1483418875.git.mengdong.lin@linux.intel.com>
 <1483454417.4555.2.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A13073@shsmsx102.ccr.corp.intel.com>
 <1483471712.4063.17.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D2E266F84
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 21:09:30 +0100 (CET)
In-Reply-To: <1483471712.4063.17.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>>> I dont think we need vendor (it just makes it too long). The product or board
>>> name should be unique enough for us to load the correct files.
>>>
>>> Liam
>> Yes, from the sample machines I checked, product or board name are
>> unique. But I feel there might be the risk that two vendors happen to
>> use the same product or board name, e.g. "T100TA".
> I think this would be problematic from a legal/marketing position from
> two different vendors so it would be unlikely.

Please don't remove the manufacturer name for now...
Some vendors use product names that are indeed unique and easy enough to 
remember, but others like Lenovo use "1952W5R" or "20C3001VHH" (real 
examples you can Google to see I am not making this up). The board name 
can also be "SKG18 t". I really have no appetite for a UCM directory 
called 20C3001VHH.SKG18t :-)
I would also be ready to bet that smaller manufacturers in the Chinese 
ecosystem use similar product names at the DMI level. removing the 
vendor name would likely result in mistakes.
You really want the manufacturer name to make the maintenance of these 
files easier on the rest of us. Sometimes the DMI version field is 
actually more self-explanatory, e.g. "ThinkPad 60" or "ThinkPad 10" for 
the two Lenovo examples, maybe this is something we ought to look at.
