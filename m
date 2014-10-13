From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Mon, 13 Oct 2014 14:21:58 +0200
Message-ID: <543BC3E6.3080805@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>	<543BB04D.8000906@googlemail.com>
 <543BB9CF.7010806@ladisch.de> <543BBF44.3020109@googlemail.com>
 <543BC106.1050003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D5E260547
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 14:22:08 +0200 (CEST)
Received: by mail-wi0-f174.google.com with SMTP id h11so3553259wiw.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 05:22:08 -0700 (PDT)
In-Reply-To: <543BC106.1050003@ladisch.de>
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

On 13/10/14 14:09, Clemens Ladisch wrote:
> Tobias Hoffmann wrote:
>> Here are two reports (6i6) with oops trace:
>>    https://github.com/smilingthax/alsa-driver_scarlett/issues/7
>>    https://github.com/smilingthax/alsa-driver_scarlett/issues/2#issuecomment-54364354
> Both kernels are tainted.
> Anyway, in both cases, the simplest explanation would be that the driver
> was not compiled for the correct kernel version/configuration.
But it does not explain why it works after applying the patch (issue 7).
In issue 2 I apparently did not connect the dots by then, and did not 
give the patch to the reporter, so we don't know if it would have worked 
there.

And the original reporter's problem also occurred at the same location, 
i.e. where I initialize the sampling rate register with a defined value. 
I can (try to) ask him, whether he can provide more information for his 
case.

   Tobias
