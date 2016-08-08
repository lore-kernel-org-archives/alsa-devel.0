From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/39] ALSA: seq: optimize system_info
 function to new design
Date: Mon, 8 Aug 2016 21:22:47 +0900
Message-ID: <e106a4ff-f6e3-ec0e-a4e5-8e0f296610e5@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-12-git-send-email-o-takashi@sakamocchi.jp>
 <s5hwpjroi5k.wl-tiwai@suse.de> <s5hmvknog27.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C9F62269666
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 14:22:48 +0200 (CEST)
In-Reply-To: <s5hmvknog27.wl-tiwai@suse.de>
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

On Aug 8 2016 16:50, Takashi Iwai wrote:
> On Mon, 08 Aug 2016 09:04:55 +0200,
> Takashi Iwai wrote:
>>
>> On Sun, 07 Aug 2016 11:48:47 +0200,
>> Takashi Sakamoto wrote:
>>>
>>> In former commit, actual operations of each ioctl command get argument
>>> in kernel space. Copying from/to user space is performed outside of
>>> the function.
>>>
>>> This commit optimizes to the new design.
>>>
>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>
>> While it's OK to split to small patches if you prefer, you don't have
>> to do so.  Basically all the rest are doing the same thing (strip
>> copy_*_user() and replace to the pointer accesses), and it's rather
>> boring to read repeated mails.
>
> BTW, I'm afraid that the patch series breaks bisection.
> We need to consider rearranging the changes if we want to keep
> bisectionability.

As long as it's possible. But in this case, it's difficult. The relation 
between ioctl table and each functions is one to N. If we change them in 
one patch, the size is quite large (and alsa-project.org will skip it to 
deliver.). It's unavoidable.


Regards

Takashi Sakamoto
