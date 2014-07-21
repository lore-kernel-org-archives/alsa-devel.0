From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/6] bebob: Use different labels for
 digital input/output interfaces
Date: Mon, 21 Jul 2014 19:49:56 +0900
Message-ID: <53CCF054.6090301@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
 <1405908605-8105-5-git-send-email-o-takashi@sakamocchi.jp>
 <s5hppgznidn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A5FB3265163
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 12:50:04 +0200 (CEST)
In-Reply-To: <s5hppgznidn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Jul 21 2014 18:58), Takashi Iwai wrote:
>> @@ -498,6 +498,8 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
>>  	int err;
>>  
>>  	id = uval->value.enumerated.item[0];
>> +	if (id >= ARRAY_SIZE(special_dig_in_iface_labels))
>> +		return 0;
> 
> This should return an error.

>> @@ -571,6 +577,8 @@ static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
>>  	int err;
>>  
>>  	id = uval->value.enumerated.item[0];
>> +	if (id >= ARRAY_SIZE(special_dig_out_iface_labels))
>> +		return 0;
> 
> Ditto.

Oops, exactly. I use -EINVAL for the error code. Thank you.


Takashi Sakamoto
o-takashi@sakamocchi.jp
