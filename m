From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: [PATCH]x2 full
 capture/playback/spdif support for Digidesign Mbox 2
Date: Sun, 23 Dec 2012 16:12:21 +1100
Message-ID: <CABXa2sE5VZzXSX4zmfDOwSrDEinDBC4r5roZ5jjWMUGJQzZgCA@mail.gmail.com>
References: <CABXa2sGkpfpj+XgzRJSb2Rsgz=HnWK--hw4k82u=uqWU0jE9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 5625226036C
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2012 06:12:22 +0100 (CET)
Received: by mail-ob0-f177.google.com with SMTP id uo13so5926871obb.36
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 21:12:21 -0800 (PST)
In-Reply-To: <CABXa2sGkpfpj+XgzRJSb2Rsgz=HnWK--hw4k82u=uqWU0jE9dA@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 23 December 2012 15:54, Damien Zammit <damien.zammit@gmail.com> wrote:
> Plus an incremental patch (Version 5-2)
Sorry I forgot the commit message:

Support for Digidesign Mbox 2 USB sound card:

This patch is the result of a lot of trial and error, since there are no specs
available for the device.

This is part two (2) of patch_for_next_dz5.txt and should be applied after it.

This patch fixes two things:
        1) A kernel panic caused by incorrect allocation of a u8
variable "bootresponse".
        2) A noisy dmesg (urb status -32) caused by broken pipe to an
invalid midi endpoint.

It is also a little cleaner because there is no need for a new
QUIRK_MIDI type as suggested
by kernel developers.


Signed-off-by: Damien Zammit <damien@zamaudio.com>

---

See previous message for the actual patch (version 5-2)
