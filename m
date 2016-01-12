From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] sound: hda_intel: add card number to
 irq description
Date: Tue, 12 Jan 2016 20:26:56 +0100
Message-ID: <56955380.5000101@gmail.com>
References: <567991C1.3040507@gmail.com> <s5ha8p1wr24.wl-tiwai@suse.de>
 <FFE409AE-564B-48EA-BECB-6C4A03134DFA@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 416F7260508
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 20:27:07 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id l65so32979484wmf.3
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 11:27:07 -0800 (PST)
In-Reply-To: <FFE409AE-564B-48EA-BECB-6C4A03134DFA@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Am 23.12.2015 um 22:58 schrieb Clemens Ladisch:
> Takashi Iwai wrote:
>> I have a small hesitation to
>> add such a new filed blindly to snd_card struct.   Although it's
>> relatively small (32 bytes), it's not zero, after all.
> 
> There is only one struct per card.
> 
> And it is doubtful that other solutions would save space
> when the code size is taken into account.
> 
> 
> Regards,
> Clemens
> 
Any final opinion regarding this patch?

Regards, Heiner
