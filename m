From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RESEND 00/11] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Mon, 7 Aug 2017 21:30:29 +0900
Message-ID: <46d253b3-abe3-e2f4-f787-38a600bd5214@sakamocchi.jp>
References: <1502106645-6731-1-git-send-email-andr2000@gmail.com>
 <ccaa1c31-f733-c582-38b9-7e9eca25a0c2@sakamocchi.jp>
 <813def1d-4052-0f21-418f-811b5294a539@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <813def1d-4052-0f21-418f-811b5294a539@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On Aug 7 2017 21:18, Oleksandr Andrushchenko wrote:
>> Your first patch includes code difference under line 26, thus it 
>> expects existence of a file 'sound/drivers/xen-front.c' in tree. 
>> However, the file is not introduced in any upstream yet; at least, 
>> Linus's tree and Iwai-san's tree.
> I missed the very first patch in the series, this is why, my bad

When I did the same mistake, I take git-hash for a first commit in 
series as an argument into git-format-patch command. But this operation 
generated patchset which starts at second commit. I solved this to add 
'~', like.

$ git format-patch -s the-git-hash~...

Or pick up the hash for a commit just before a first commit in the 
series. For your information ;)


Regards

Takashi Sakamoto
