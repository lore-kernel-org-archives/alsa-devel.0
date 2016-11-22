From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Tue, 22 Nov 2016 14:09:44 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1611221406590.1908@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1504111011090.1174@localhost.localdomain>
 <s5hvbh13mxe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1A0266539
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 14:09:48 +0100 (CET)
Received: by mail-qt0-f193.google.com with SMTP id n6so2069468qtd.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 05:09:48 -0800 (PST)
In-Reply-To: <s5hvbh13mxe.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Sorry, at the end I did not do what you recommended me. Sorry.

But maybe now it's better to reconsider the whole story.
right now (running kernel 4.9.0-rc5ho+) (I compild it from vanilla and added that custom version name), the situation changed somewhat.
Infact, it seems opening the audio device at the wrong moment can panic the kernel.
Actually I am in a hurry, still: a line like this
options snd_hda_intel power_save_controller=0 power_save=0

seems to let the system survive fine.

To anyone reading: this isn't a solution.
thank you and sorry again,
Enrico
