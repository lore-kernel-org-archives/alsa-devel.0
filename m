From: Olek Poplavsky <woodenbits@gmail.com>
Subject: [PATCH] sound/usb: Add Opus #3 to quirks for native
	DSD support
Date: Thu, 24 Jan 2019 23:30:03 -0500
Message-ID: <CAKgOocdOAZuGH+-w6bh9AVKM642wWvhNP2HjPyWdSntz1QuDqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE5962674A9
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 05:30:15 +0100 (CET)
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so7213429ljh.13
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 20:30:15 -0800 (PST)
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

From: Olek Poplavsky <woodenbits@gmail.com>
This patch adds quirk VID/PID IDs for the Opus #3 DAP (made by 'The Bit')
in order to enable Native DSD support.

Signed-off-by: Olek Poplavsky <woodenbits@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ebbadb3a7094..9ac6309f7a73 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1495,6 +1495,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct
snd_usb_audio *chip,
        case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
        case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
        case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+       case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3*/
        case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
        case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
        case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
