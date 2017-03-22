From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - set intel audio clock to a
 properly value
Date: Wed, 22 Mar 2017 08:12:39 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195247171F@SHSMSX103.ccr.corp.intel.com>
References: <1488867622-21765-1-git-send-email-libin.yang@intel.com>
 <s5hvar4wa3c.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19524713F9@SHSMSX103.ccr.corp.intel.com>
 <s5hpohainek.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D16472670C6
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 09:13:14 +0100 (CET)
In-Reply-To: <s5hpohainek.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "infernix@infernix.net" <infernix@infernix.net>
List-Id: alsa-devel@alsa-project.org


>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Wednesday, March 22, 2017 12:51 AM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; Lin, Mengdong <mengdong.lin@intel.com>;
>infernix@infernix.net
>Subject: Re: [alsa-devel] [PATCH] ALSA: hda - set intel audio clock to a properly
>value
>
>On Tue, 21 Mar 2017 17:11:27 +0100,
>Yang, Libin wrote:
>>
>> >> +	 * Any deviation may result in undefined behavior.
>> >> +	 */
>> >> +	if (((val & AZX_MLCTL_SPA) >> AZX_MLCTL_SPA_SHIFT) ^
>> >> +		((val & AZX_MLCTL_CPA) >> AZX_MLCTL_CPA_SHIFT))
>> >
>> >Should it be better with "==" instead of XOR here?
>>
>> AZX_MLCTL_SPA bit value should be the same with AZX_MLCTL_CPA bit
>> value before operation. If they are different, we should not touch
>> this register. So if XOR is true, we should return directly.
>
>I meant that (A != B) is more understandable than (A ^ B).

Get it. I will use (A != B)

Regards,
Libin

>
>
>Takashi
