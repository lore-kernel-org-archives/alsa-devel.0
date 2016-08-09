From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/39] ALSA: seq: optimize system_info
 function to new design
Date: Tue, 9 Aug 2016 21:15:03 +0900
Message-ID: <08b81c00-5e46-b202-b533-c403beaf5638@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-12-git-send-email-o-takashi@sakamocchi.jp>
 <s5hwpjroi5k.wl-tiwai@suse.de>
 <3165103a-b4b0-94a6-6fb5-4d7b00dc1ae1@sakamocchi.jp>
 <s5heg5znvtf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 20817267AE4
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:15:05 +0200 (CEST)
In-Reply-To: <s5heg5znvtf.wl-tiwai@suse.de>
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

On Aug 9 2016 00:07, Takashi Iwai wrote:
> On Mon, 08 Aug 2016 10:37:21 +0200,
> Takashi Sakamoto wrote:
>>
>> On Aug 8 2016 16:04, Takashi Iwai wrote:
>>> On Sun, 07 Aug 2016 11:48:47 +0200,
>>> Takashi Sakamoto wrote:
>>>>
>>>> In former commit, actual operations of each ioctl command get argument
>>>> in kernel space. Copying from/to user space is performed outside of
>>>> the function.
>>>>
>>>> This commit optimizes to the new design.
>>>>
>>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>
>>> While it's OK to split to small patches if you prefer, you don't have
>>> to do so.  Basically all the rest are doing the same thing (strip
>>> copy_*_user() and replace to the pointer accesses), and it's rather
>>> boring to read repeated mails.
>>
>> The mail server of alsa-project.org has a limitation of the size of
>> one message. It shrinks developers to split commit to a small
>> parts. Not from my taste.
> 
> Yeah, that's sometimes annoying, indeed.  Jaroslav, could you raise
> the bar to allow larger patches, or drop this restriction?

It's not what I want. I've already followed to the restriction for this
several years. The restriction is still OK as long as I can split my
patches as small parts and I'm not objected for them.

You completely puzzled me. Finally, what you'd like me to do?????


Regards

Takashi Sakamoto
