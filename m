From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] test: fix comment about first two fields
	of	TLV data payload
Date: Tue, 30 Aug 2016 09:24:04 +0200
Message-ID: <dc879ef0-f95f-fd11-06bf-a31ac1a29e5d@ladisch.de>
References: <1472516505-8350-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7fay4ya7.wl-tiwai@suse.de>
 <7934a94f-a725-1d4b-43f0-3ea24a435aee@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C65C22666E4
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 09:24:05 +0200 (CEST)
In-Reply-To: <7934a94f-a725-1d4b-43f0-3ea24a435aee@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 30 2016 14:32, Takashi Iwai wrote:
>> Takashi Sakamoto wrote:
>>> -    orig[0] = snd_ctl_elem_id_get_numid(trial->id);
>>> +    orig[0] = SNDRV_CTL_TLVT_CONTAINER;
>>>      orig[1] = 6 * sizeof(orig[0]);
>>>      orig[2] = 'a';
>>>      orig[3] = 'b';
>>
>> The container TLV type expects other TLVs as its content.  So the
>> above looks buggy to me...
>
> This is a test program just to serve to myself. So I hope this degree of roughness is allowed...
>
> Or could you please construct valid TLV array here?

In the kernel, you could use the macros from include/sound/tlv.h.

Either copy them into your test program, and use them directly:

	/* 4 words: */
	DECLARE_TLV_DB_MINMAX(orig, -60, +60);
	/* container with only one subitem; 8 words: */
	DECLARE_TLV_CONTAINER(orig_container,
		TLV_ITEM(SNDRV_CTL_TLVT_CHMAP_FIXED,
			 SNDRV_CHMAP_FL, SNDRV_CHMAP_FR, SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE)
	);

or create the values by hand:

	orig[0] = SNDRV_CTL_TLVT_DB_MINMAX;
	orig[1] = 2 * sizeof(*orig);
	orig[2] = -60;
	orig[3] = +60;

	orig_container[0] = SNDRV_CTL_TLVT_CONTAINER;
	orig_container[1] = 6 * sizeof(*orig_container);
		orig_container[2] = SNDRV_CTL_TLVT_CHMAP_FIXED;
		orig_container[3] = 4 * sizeof(*orig_container);
		orig_container[4] = SNDRV_CHMAP_FL
		orig_container[5] = SNDRV_CHMAP_FR;
		orig_container[6] = SNDRV_CHMAP_FC;
		orig_container[7] = SNDRV_CHMAP_LFE;


Regards,
Clemens
