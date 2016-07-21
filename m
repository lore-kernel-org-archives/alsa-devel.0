From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] topology: Fix the missing referenced elem
 ptr when merging private data
Date: Fri, 22 Jul 2016 06:16:03 +0900
Message-ID: <57913B93.6070300@sakamocchi.jp>
References: <1469084447-30740-1-git-send-email-mengdong.lin@linux.intel.com>
 <57913273.7010507@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id D7EA8265A56
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2016 23:16:11 +0200 (CEST)
In-Reply-To: <57913273.7010507@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On Jul 22 2016 05:37, Takashi Sakamoto wrote:
> Hi,
> 
> On Jul 21 2016 16:00, mengdong.lin@linux.intel.com wrote:
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> tplg_copy_data() should set the valid referenced data element pointer.
>> The caller will double check this pointer for all kinds of references,
>> including TLV, controls, text and data.
>>
>> Also fix an inaccurate dmesg.
>>
>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> diff --git a/src/topology/dapm.c b/src/topology/dapm.c
>> index 4d343b2..e3c90d8 100644
>> --- a/src/topology/dapm.c
>> +++ b/src/topology/dapm.c
>> @@ -201,7 +201,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
>>  		}
>>  
>>  		if (!ref->elem) {
>> -			SNDERR("error: cannot find control '%s'"
>> +			SNDERR("error: cannot find '%s'"
>>  				" referenced by widget '%s'\n",
>>  				ref->id, elem->id);
>>  			return -EINVAL;
> 
> It's better to split to two patches for the different aims. Accumulating
> patches to log history is preferable, as long as you have concrete wills
> to improve codes, I believe.
> 
>> diff --git a/src/topology/data.c b/src/topology/data.c
>> index 768fc27..397f6a5 100644
>> --- a/src/topology/data.c
>> +++ b/src/topology/data.c
>> @@ -1050,6 +1050,7 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
>>  		" element '%s'\n", ref->id, elem->id);
>>  		return -EINVAL;
>>  	}
>> +	ref->elem = ref_elem;
>>  
>>  	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
>>  	/* overlook empty private data */
> 
> I wonder why the assignment is done in this line. This function still
> includes some codes to return errors. In this case, it's better to code
> the assignment in last part of the function.
> 
> This is a public API. It's better not to touch application's objects in
> invalid cases.

Oops. I overlooked. It's in src/topology/tplg_local.h and not a public
API... Anyway, it's better to consider about the error cases for
consistency of object state.


Regards

Takashi Sakamoto
