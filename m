From: Hans de Goede <hdegoede@redhat.com>
Subject: rt5645 Jack detect code on an Asus T100HA not being
 able to distinguish between headphones vs headset ?
Date: Fri, 27 Apr 2018 16:19:24 +0200
Message-ID: <2cab6fb3-f5b0-948a-8d4f-2e42768d84e8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com
 [209.85.128.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 107D12677FD
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:19:26 +0200 (CEST)
Received: by mail-wr0-f169.google.com with SMTP id g21-v6so1950190wrb.8
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:19:26 -0700 (PDT)
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
To: Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Bard,

I'm having some trouble with the rt5645.c codec code not
being able to distinguish between headphones vs headset
on an Asus T100HA laptop. It recognizes everything as
headphones.  This statement in the jack-detect code:

                 dev_dbg(component->dev, "val = %d\n", val);

Always prints 4 for the value, no matter what I plug in.

Also the headset microphone input does not work, not
even if I select it manually.

The ACPI id for the device is 10EC3270, and I opened the
tablet and the marking on the codec says: ALC3270,
so I guess we may need some special handling for the
jack-detect (and headset microphone input) on this
variant, can you help?

I checked and the jack connector does seem to be of
the TRRS type.

Regards,

Hans
