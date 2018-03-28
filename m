From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ALSA: core api: define offsets for TLV
	items
Date: Thu, 29 Mar 2018 04:05:33 +0900
Message-ID: <63485cbc-83ec-7177-b586-986ae1e4a380@sakamocchi.jp>
References: <20180328170904.19845-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 388A8267063
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 21:05:39 +0200 (CEST)
In-Reply-To: <20180328170904.19845-1-ranjani.sridharan@linux.intel.com>
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
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 29 2018 02:09, Ranjani Sridharan wrote:
> This patch defines accessor offsets for the type, length, min,
> mute and step items in TLV data. These will be used by drivers to
> extract the TLV data while loading topology.
> 
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
> V2: removed redundant redefinitions and updated prefix
> ---
>   include/uapi/sound/tlv.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
> index be5371f09a62..1fd786a5e57b 100644
> --- a/include/uapi/sound/tlv.h
> +++ b/include/uapi/sound/tlv.h
> @@ -98,4 +98,12 @@
>   
>   #define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
>   
> +/* Accessor offsets for TLV data items */
> +#define SNDRV_CTL_TLV_OFFSET_TYPE		0
> +#define SNDRV_CTL_TLV_OFFSET_LEN		1

I suggest you to use these macros in declaration of 
'SNDRV_CTL_TLVD_ITEM()' for self-described header. In short, I mean:

$ diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index be5371f09a62..76598609f349 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -37,8 +37,15 @@
   *        block_length = (length + (sizeof(unsigned int) - 1)) &
   *                       ~(sizeof(unsigned int) - 1)) ....
   */
+
+/* Accessor offsets for TLV data items */
+#define SNDRV_CTL_TLV_OFFSET_TYPE      0
+#define SNDRV_CTL_TLV_OFFSET_LEN       1
+
  #define SNDRV_CTL_TLVD_ITEM(type, ...) \
-       (type), SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), __VA_ARGS__
+       [SNDRV_CTL_TLV_OFFSET_TYPE] = (type), \
+       [SNDRV_CTL_TLV_OFFSET_LEN] = SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), \
+       __VA_ARGS__
  #define SNDRV_CTL_TLVD_LENGTH(...) \
         ((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))

> +/* Accessor offsets for min, mute and step items in dB scale type TLV */
> +#define SNDRV_CTL_TLV_OFFSET_DB_MIN		2
> +#define SNDRV_CTL_TLV_OFFSET_DB_MUTE_AND_STEP	3
> +
>   #endif

I wonder why you add the above macros just for data of 
'SNDRV_CTL_TLVT_DB_MINMAX_MUTE'. In fact, this header defines below 
types of TLV data.
  - SNDRV_CTL_TLVT_CONTAINER
  - SNDRV_CTL_TLVT_DB_SCALE
  - SNDRV_CTL_TLVT_DB_LINEAR
  - SNDRV_CTL_TLVT_DB_RANGE
  - SNDRV_CTL_TLVT_DB_MINMAX
  - SNDRV_CTL_TLVT_DB_MINMAX_MUTE

Would I request you to your reason not to add such offset macros for the 
others? At least, we should have a care for 'SNDRV_CTL_TLVT_DB_LINEAR' 
to keep consistency of defined macros.

Regards

Takashi Sakamoto
