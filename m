From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for Focusrite
 Scarlett 18i6
Date: Sat, 29 Dec 2012 20:10:44 +1100
Message-ID: <CACckToUXjebb23w1AqM3zB2fwWHmLHJwEiySsuEKDKnVdLmC0A@mail.gmail.com>
References: <20121109202023.60f6dcdc@martins.ozlabs.org>
 <s5hvcdavwoy.wl%tiwai@suse.de>
 <20121113193803.2e0d7c4a@martins.ozlabs.org>
 <s5hzk2lvpxh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 05CA6261606
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 10:10:45 +0100 (CET)
Received: by mail-ob0-f174.google.com with SMTP id ta14so10393608obb.33
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 01:10:45 -0800 (PST)
In-Reply-To: <s5hzk2lvpxh.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Martin Schwenke <martin@meltin.net>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

Last week on #alsa  I found yet another person who's having problems with
snd-usb-audio not supporting UAC2 Feature units.  Worse still the relevant
part of the descriptor is incomplete according to lsusb so while the device
is in the main compliant the feature unit has a descriptor that lsusb
thinks is too short and I suspect isn't compliant (so even if we were
trying to parse feature units it'd blow up here)

      AudioControl Interface Descriptor:        bLength
16        bDescriptorType        36        bDescriptorSubtype      9
(EXTENSION_UNIT)      Warning: Descriptor too short        bUnitID
           51        wExtensionCode          0        bNrPins
       1        baSourceID( 0)          2        bNrChannels
  4        wChannelConfig          0        iChannelNames           3
       bmControls        0x00        iExtension             26


(a full lsusb -v is here: http://pastebin.ubuntu.com/1451668/)
So while we could submit another quirk for this to ignore the mixer for
now. and this would probably make the device "work"  without access to the
feature unit is it sensible? (we verified that modifying martin's quirk
above (just changing vid:pid) was enough to make the device "work")

Note also this is the problem for the eleven rack as discussed in April
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-April/050899.html

How difficult would it be to have the mixer/control code just "skip"
feature units rather than the current failure mode? or default to ignore
the interface if the control parser fails but continue to remaining
interfaces?  I've tried understanding this code. but my C foo is lacking.

Grant.
