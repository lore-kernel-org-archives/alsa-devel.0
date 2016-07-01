From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: control: add dimension validator
 for userspace element
Date: Fri, 1 Jul 2016 19:46:39 +0900
Message-ID: <57764A0F.9060403@sakamocchi.jp>
References: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
 <1467346511-28051-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5h37ntsu3o.wl-tiwai@suse.de> <57762A1C.8030607@sakamocchi.jp>
 <s5hshvtrbcy.wl-tiwai@suse.de> <57763307.6010504@sakamocchi.jp>
 <s5ha8i1d6sx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id AD8B52614A7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 12:46:46 +0200 (CEST)
In-Reply-To: <s5ha8i1d6sx.wl-tiwai@suse.de>
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

On Jul 1 2016 18:52, Takashi Iwai wrote:
>>>> Were I you, I would insert codes to evaluate the element of dimension
>>>> info; i.e.
>>>>
>>>>                 if (info->dimen.d[i] > 512)
>>>>                         break;
>>>>
>>>> Here, 512 is the maximum number of members which an element can have. In
>>>> this case, it's certainly an element of byte type.
>>>
>>> It's superfluous.  If info->count is already a sane value, it'd be
>>> enough to compare with this.
>>
>> The info->count comes from userspace or each driver. It's dangerous to
>> use it for avoiding arithmetic overflow.
> 
> Your function is to verify the dimen array.  And for that, a sane
> info->count value is prerequisite.  Otherwise how can you validate it
> at all...?

Hm.

There's a large difference between us for the design of this local
function. You're interested in the result of calculation, while I
consider about the soundness of whole members in the dimension info.

In this time, I'll follow your insistence. I'd like to save my time
against this long-abandoned feature.


Regards

Takashi Sakamoto
