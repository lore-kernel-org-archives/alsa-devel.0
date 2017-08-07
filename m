From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH RESEND 00/11] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Mon, 7 Aug 2017 15:33:24 +0300
Message-ID: <2b1fea9d-3c5c-bfc7-24f6-6d4bcc691357@gmail.com>
References: <1502106645-6731-1-git-send-email-andr2000@gmail.com>
 <ccaa1c31-f733-c582-38b9-7e9eca25a0c2@sakamocchi.jp>
 <813def1d-4052-0f21-418f-811b5294a539@gmail.com>
 <46d253b3-abe3-e2f4-f787-38a600bd5214@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 86DF626721A
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 14:33:27 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id t138so863245wmt.4
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 05:33:27 -0700 (PDT)
In-Reply-To: <46d253b3-abe3-e2f4-f787-38a600bd5214@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org



On 08/07/2017 03:30 PM, Takashi Sakamoto wrote:
> On Aug 7 2017 21:18, Oleksandr Andrushchenko wrote:
>>> Your first patch includes code difference under line 26, thus it 
>>> expects existence of a file 'sound/drivers/xen-front.c' in tree. 
>>> However, the file is not introduced in any upstream yet; at least, 
>>> Linus's tree and Iwai-san's tree.
>> I missed the very first patch in the series, this is why, my bad
>
> When I did the same mistake, I take git-hash for a first commit in 
> series as an argument into git-format-patch command. But this 
> operation generated patchset which starts at second commit. I solved 
> this to add '~', like.
>
> $ git format-patch -s the-git-hash~...
>
> Or pick up the hash for a commit just before a first commit in the 
> series. For your information ;)
>
thank you for the hint, will use instead of specifying number of patches
(this is why I missed one and made so much noise)
>
> Regards
>
> Takashi Sakamoto
Thank you,
Oleksandr
