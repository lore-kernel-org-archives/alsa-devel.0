From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ASoC: Intel: Skylake: Fix typo for
	token d0i3 caps
Date: Wed, 3 May 2017 19:46:21 +0900
Message-ID: <efae9470-97e5-183e-d226-9488b1b309da@sakamocchi.jp>
References: <1493806055-28046-1-git-send-email-subhransu.s.prusty@intel.com>
 <1493806055-28046-2-git-send-email-subhransu.s.prusty@intel.com>
 <7f493fb0-99d2-4de8-1cf3-24ae3324b783@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8D1532667FE
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 12:46:24 +0200 (CEST)
In-Reply-To: <7f493fb0-99d2-4de8-1cf3-24ae3324b783@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On May 3 2017 19:38, Takashi Sakamoto wrote:
> On May 3 2017 19:07, Subhransu S. Prusty wrote:
>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>> ---
>>  include/uapi/sound/snd_sst_tokens.h    | 4 ++--
>>  sound/soc/intel/skylake/skl-topology.c | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
>> index 93392bedcc58..685149dda66b 100644
>> --- a/include/uapi/sound/snd_sst_tokens.h
>> +++ b/include/uapi/sound/snd_sst_tokens.h
>> @@ -213,8 +213,8 @@ enum SKL_TKNS {
>>  	SKL_TKN_U32_LIB_COUNT,
>>  	SKL_TKN_STR_LIB_NAME,
>>  	SKL_TKN_U32_PMODE,
>> -	SKL_TKL_U32_D0I3_CAPS,
>> -	SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
>> +	SKL_TKN_U32_D0I3_CAPS,
>> +	SKL_TKN_MAX = SKL_TKN_U32_D0I3_CAPS,
>>  };
>>  
>>  #endif
>> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
>> index 3a99712e44a8..b28199a5348c 100644
>> --- a/sound/soc/intel/skylake/skl-topology.c
>> +++ b/sound/soc/intel/skylake/skl-topology.c
>> @@ -1995,7 +1995,7 @@ static int skl_tplg_get_token(struct device *dev,
>>  		mconfig->converter = tkn_elem->value;
>>  		break;
>>  
>> -	case SKL_TKL_U32_D0I3_CAPS:
>> +	case SKL_TKN_U32_D0I3_CAPS:
>>  		mconfig->d0i3_caps = tkn_elem->value;
>>  		break;
> 
> $ git annotate include/uapi/sound/snd_sst_tokens.h
> 8a0cb2360ddb9   (Vinod Koul     2016-11-03 17:07:18 +0530       215)
> SKL_TKN_U32_PMODE,
> 6bd9dcf339ebb   (Vinod Koul     2016-11-03 17:07:19 +0530       216)
> SKL_TKL_U32_D0I3_CAPS,
> 6bd9dcf339ebb   (Vinod Koul     2016-11-03 17:07:19 +0530       217)
> SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
> 15f0d4f531d84   (Shreyas NC     2016-08-12 12:29:50 +0530       218)};
> $ git name-rev --tags 6bd9dcf339ebb
> 6bd9dcf339ebb tags/sound-4.10-rc1~3^2~15^2~17
> 
> The typo was already included in Linux kernel v4.10 and exposed to
> userland. In general of kernel development, it's the worst idea to
> change it, because it can break userland.

Instead of rename, it's better for you to keep the typo and add the
correct entry with the same value, like:

$ git diff
diff --git a/include/uapi/sound/snd_sst_tokens.h
b/include/uapi/sound/snd_sst_tokens.h
index 93392bedcc58..b7cc95d04928 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -213,8 +213,9 @@ enum SKL_TKNS {
        SKL_TKN_U32_LIB_COUNT,
        SKL_TKN_STR_LIB_NAME,
        SKL_TKN_U32_PMODE,
-       SKL_TKL_U32_D0I3_CAPS,
-       SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
+       SKL_TKL_U32_D0I3_CAPS,  /* Typo, added at v4.10. */
+       SKL_TKN_U32_D0I3_CAPS = SKN_TKL_U32_D0I3_CAPS,
+       SKL_TKN_MAX = SKL_TKN_U32_D0I3_CAPS,
 };

 #endif


Regards

Takashi Sakamoto
