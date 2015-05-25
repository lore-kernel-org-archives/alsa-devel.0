From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Revert "ALSA: hda - Add mute-LED mode
 control to Thinkpad"
Date: Mon, 25 May 2015 14:44:04 +0800
Message-ID: <CAN8cciYdVa0Ej0koQN1yPCm6SKPPmhtu45V9YOhL2XoZKXHHZA@mail.gmail.com>
References: <1432449275-29789-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 13E7F260464
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 08:44:06 +0200 (CEST)
Received: by oihd6 with SMTP id d6so51809329oih.2
 for <alsa-devel@alsa-project.org>; Sun, 24 May 2015 23:44:05 -0700 (PDT)
In-Reply-To: <1432449275-29789-1-git-send-email-tiwai@suse.de>
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
Cc: Martin Steigerwald <martin@lichtvoll.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> This reverts commit 7290006d8c0900c56d8c58428134f02c35109d17.
>
> Through the regression report, it was revealed that the
> tpacpi_led_set() call to thinkpad_acpi helper doesn't only toggle the
> mute LED but actually mutes the sound.  This is contradiction to the
> expectation, and rather confuses user.
>
> According to Henrique, it's not trivial to judge which TP model
> behaves "LED-only" and which model does whatever more intrusive, as
> Lenovo's implementations vary model by model.  So, from the safety
> reason, we should revert the patch for now

Are there any ThinkPad which known to support mute led through ACPI SSMS ?
