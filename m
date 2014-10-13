From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Mon, 13 Oct 2014 14:02:12 +0200
Message-ID: <543BBF44.3020109@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <543BB04D.8000906@googlemail.com> <543BB9CF.7010806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id BB50E260461
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 14:02:22 +0200 (CEST)
Received: by mail-wg0-f45.google.com with SMTP id m15so8363299wgh.28
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 05:02:22 -0700 (PDT)
In-Reply-To: <543BB9CF.7010806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 13/10/14 13:38, Clemens Ladisch wrote:
> Tobias Hoffmann wrote:
>> On 07/10/14 17:16, David Henningsson wrote:
>>> +    err = set_ctl_urb2(mixer->chip, UAC2_CS_CUR, 0x0100, 0x29, "\x80\xbb\x00\x00", 4);
>> There have been two reports of users that had to replace the set_ctl_urb2 line with:
>>
>>     char buffer[4] = { '\x80', '\xbb', '\x00', '\x00' };
>>     err = set_ctl_urb2(mixer->chip, UAC2_CS_CUR, 0x0100, 0x29, buffer, 4);
>>
>> otherwise they would get a kernel oops, e.g.:
> [...]
>
> This crash is inside memcpy(), where this memory type cannot make any
> difference.
>
> Please show the entire oops.

The first reporter (18i8) only sent me a patch with exactly that change, 
claiming:
> It also oopses my kernel because of some constness issues.

Here are two reports (6i6) with oops trace:
   https://github.com/smilingthax/alsa-driver_scarlett/issues/7
   
https://github.com/smilingthax/alsa-driver_scarlett/issues/2#issuecomment-54364354

   Tobias
