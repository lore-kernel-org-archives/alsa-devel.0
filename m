From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH] ctl: improve documentation of
 APIs to add an element set
Date: Sat, 9 Jul 2016 22:18:30 +0900
Message-ID: <5780F9A6.2020002@sakamocchi.jp>
References: <1468028659-15897-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbn27jpqp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1B9A5265888
 for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2016 15:18:36 +0200 (CEST)
In-Reply-To: <s5hbn27jpqp.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Jul 9 2016 15:21, Takashi Iwai wrote:
> On Sat, 09 Jul 2016 03:44:19 +0200,
> Takashi Sakamoto wrote:
>>
>> Currently, documentation of APIs to add an element set describes causes of
>> errors partly. But it gives an opinion to describe them thoroughly. This
>> is not good for users.
>>
>> This commit changes the documentation so that it partly describes the
>> causes.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Applied, thanks.

Thanks.

As a rest of issues about the new APIs, I think it better to change
their names. Currently, I named them by adding '_set' suffix to names of
old APIs; i.e.
'snd_ctl_elem_add_integer' -> 'snd_ctl_elem_add_integer_set'.

The names give an opinion to users that these APIs are to add something
to existent control elements. The functionalities of the APIs are add
some elements to something accessed via CTL handler; practically it's a
control instance for a sound card, accessed via 'hw' plugin.

Thus, I think it better to rename them; i.e.
'snd_ctl_add_integer_elem_set'. Could I ask your opinion about this?


Regards

Takashi Sakamoto
