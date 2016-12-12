From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] pcm: fix wrong document references to PCM
 APIs which perform direct memory access with frame copying
Date: Tue, 13 Dec 2016 08:42:26 +0900
Message-ID: <b46f8cdd-2da9-3b99-abab-9dfc50de96a0@sakamocchi.jp>
References: <20161211113138.32468-1-o-takashi@sakamocchi.jp>
 <s5hy3zkzv63.wl-tiwai@suse.de>
 <acda020e-47d2-f1a2-603e-a16999355324@sakamocchi.jp>
 <s5hk2b4zqhf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 0F898266C4E
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 00:42:33 +0100 (CET)
In-Reply-To: <s5hk2b4zqhf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 13 2016 08:18, Takashi Iwai wrote:
>> Additionally, I'm pleased if you apply below patches to fix some
>> compiler warnings which topology features recently got. I guess Intel
>> developers are under their holidays.
>
> I leave these, as they are basically harmless.
> I'll take once when I get acks from Intel people.

Hm.

In my opinion, it's time to release next version of user space stuffs, 
because some significant patches are already applied since the latest 
release. Especially, alsa-tools should be released because of 'gcc6 
narrowing error'. It's nice to apply these for the preparation even if 
they're harmless.

On the other hand, it's mostly on the end of this year. Most developers 
can have relaxing time and it might be difficult to ask the release work 
to Jaroslav, I think.

>> [alsa-devel] [PATCH][alsa-lib] topology: fix sign-compare warning
>> introduced to set_link_hw_config() and tplg_add_link_object()
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115245.html
>>
>> [alsa-devel] [PATCH][alsa-lib] topology: fix unused-variable warnings
>> introduced to build_link()
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115246.html
>>
>> [alsa-devel] [PATCH][alsa-lib] topology: fix unused-const-variable warning
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115247.html


Regards

Takashi Sakamoto
