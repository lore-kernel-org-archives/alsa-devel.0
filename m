From: Hendrik-Jan Heins <hjheins@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Fix microphone for Sony
 VAIO Pro 13 (Haswell model)
Date: Wed, 25 Dec 2013 10:55:01 +0100
Message-ID: <CAAU0D9crynAdUq5gWGnV1S3mfBK=VvohQgR8GqSahbAd+tg_+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A138261677
 for <alsa-devel@alsa-project.org>; Wed, 25 Dec 2013 10:55:01 +0100 (CET)
Received: by mail-lb0-f171.google.com with SMTP id w7so3189344lbi.16
 for <alsa-devel@alsa-project.org>; Wed, 25 Dec 2013 01:55:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi, David,

it looks like this quirk also appears on the 11 Inch model of the Sony
Vaio pro ( SVP112A1CM ).

However, the device addess is different.
Instead of:

SND_PCI_QUIRK(0x104d, 0x90b6, "Sony VAIO Pro 13",
ALC286_FIXUP_SONY_MIC_NO_PRESENCE),

I see address 0x90b5 (no clue where I should find the 0x104d, can you
please send me a pointer how to find this one?).

Would it be possible to please also incorporate the fix for the 11 inch Vaio?

Thanks,

Hendrik-Jan Heins
