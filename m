From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix Dock Headphone on Thinkpad
 X250 seen as a Line Out
Date: Wed, 24 Jun 2015 19:23:06 +0800
Message-ID: <CAN8cciY3Fam7+9A6URg81FzRwyXPetuidSE2dJLF3=KMUMiLPg@mail.gmail.com>
References: <1435135593-6176-1-git-send-email-david.henningsson@canonical.com>
 <s5hsi9hwker.wl-tiwai@suse.de> <558A8F1D.1000606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A3AA260542
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:23:07 +0200 (CEST)
Received: by oigx81 with SMTP id x81so27478636oig.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 04:23:06 -0700 (PDT)
In-Reply-To: <558A8F1D.1000606@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>>>
>>> Thinkpad X250, when attached to a dock, has two headphone outs but
>>> no line out. Make sure we don't try to turn this into one headphone
>>> and one line out (since that disables the headphone amp on the dock).
>>>
>>> Alsa-info at
http://www.alsa-project.org/db/?f=36f8764e1d782397928feec715d0ef90dfddd4c1
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>
>>
>> This is one of fixes I had in mind (and asked for testing in bugzilla
>> kernel.org report).
>
>
> Sorry, I'm missing context. What report?

https://bugzilla.kernel.org/show_bug.cgi?id=99721

T440 support headset and thinkpad pro dock combo jack has headset icon

If headset mic has higher priority than dock headset mic, it is strange
that headset don't auto mute dock headset
