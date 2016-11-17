From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] pcm_dshare: Do not discard slave reported
 delay in status result.
Date: Thu, 17 Nov 2016 14:18:04 +0000
Message-ID: <67297312-c4f9-e47d-4b58-893ddb55d2c8@IEE.org>
References: <5810BDF9.1020204@IEE.org> <s5hinseoygk.wl-tiwai@suse.de>
 <5819F566.2000404@IEE.org> <581A23B9.3050609@IEE.org>
 <ccd82798-b3be-7a4f-444d-47e8d5408324@IEE.org> <s5h4m36xurh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CBE266671
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 15:18:06 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id a20so21747389wme.2
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 06:18:06 -0800 (PST)
In-Reply-To: <s5h4m36xurh.wl-tiwai@suse.de>
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

On 17/11/16 10:31, Takashi Iwai wrote:
> On Thu, 17 Nov 2016 09:20:16 +0100,
> Alan Young wrote:
>> snd_pcm_dshare_status() gets the underlying status from the slave PCM.
>> This may contain a delay value that includes elements such as codec and
>> other transfer delays. Use this as the base for the returned delay
>> value, adjusted for any frames buffered locally (within the dshare
>> plugin).
>>
>> Note: snd_pcm_dshare_delay() is not updated.
> Thanks for the patch, but it doesn't look like a proper patch to be
> applied to the latest git tree.  I guess you created a patch on top of
> the modified tree.
>
> Please rebase and resubmit.
>
> Also, don't forget to add your sign-off.  We prefer having it in
> alsa-lib code like the kernel code (although it's not strictly
> needed).

I can add a signoff but first I need to understand what is wrong with 
the patch.

I did a git pull of master from git://git.alsa-project.org/alsa-lib.git, 
committed my patch on top (previous commit a668a94238d: "mixer: Don't 
install smixer modules unless python is enabled") and did a git 
format-patch to generate the supplied patch. What did I do wrong?
