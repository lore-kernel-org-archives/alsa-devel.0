From: Adam Goode <adam@spicenitz.org>
Subject: OPL3 on cmipci doesn't survive suspend/resume
Date: Wed, 27 May 2015 09:23:17 -0400
Message-ID: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BB2265AC1
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 15:23:38 +0200 (CEST)
Received: by obew15 with SMTP id w15so7166902obe.1
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 06:23:37 -0700 (PDT)
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

Hi,

I have this card:

05:00.0 Multimedia audio controller: C-Media Electronics Inc
CMI8738/CMI8768 PCI Audio (rev 10)
Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
Flags: bus master, stepping, medium devsel, latency 32, IRQ 19
I/O ports at d000 [size=256]
Capabilities: [c0] Power Management version 2
Kernel driver in use: snd_cmipci
Kernel modules: snd_cmipci


When I suspend/resume, the sound from the OPL3 is permanently
distorted. It sounds like not all of the operators are active. I can
fix this by doing a full PCI remove/rescan cycle: the driver correctly
initializes the card at this time.

Any ideas before I peek into the code?



Thanks,

Adam
