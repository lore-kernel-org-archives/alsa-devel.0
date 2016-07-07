From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH] ctl: add dimension validator
Date: Fri, 8 Jul 2016 06:17:25 +0900
Message-ID: <577EC6E5.5020100@sakamocchi.jp>
References: <1467901328-11268-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8txdy10c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8EB3A2614FD
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 23:17:31 +0200 (CEST)
In-Reply-To: <s5h8txdy10c.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jul 7 2016 23:29, Takashi Iwai wrote:
>> @@ -302,6 +303,32 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
>>  	return ctl->ops->element_info(ctl, info);
>>  }
>>  
>> +static bool validate_element_member_dimension(struct snd_ctl_elem_info *info)
> 
> In alsa-lib user-space, we use snd_ctl_elem_info_t.  Please stick with
> it.  In theory, this type can be different from the kernel ABI.

Indeed. I should have switched my brain for userspace.


Thanks

Takashi Sakamoto
