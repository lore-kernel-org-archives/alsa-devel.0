From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Sun, 28 Sep 2014 13:56:47 -0500
Message-ID: <CAPMSj_FxRYc8zhf_SBa7phHmRHatj7Y_CQQYpVriCyJsFh0Mag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f42.google.com (mail-yh0-f42.google.com
 [209.85.213.42])
 by alsa0.perex.cz (Postfix) with ESMTP id BAA6A2605AC
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 20:56:48 +0200 (CEST)
Received: by mail-yh0-f42.google.com with SMTP id t59so212026yho.29
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 11:56:47 -0700 (PDT)
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

First time bug submitter, forgive me if I'm not following proper procedure.

OS: Arch Linux 64-bit
Kernel version: 3.16.3-1-ARCH

What's happening:
When the Master channel is lowered below 35% in alsamixer,
all audio coming out of the C-Media USB sound card is muted.

Additional info:
PulseAudio is installed
Output of 'lsusb':
   Bus 005 Device 002: ID 0d8c:000c C-Media Electronics, Inc. Audio Adapter
Alsa hw ID name:
   'Set'
Output of 'cat /proc/asound/Set/usbmixer'
   http://ix.io/exb

Any assistance in resolving the issue is greatly appreciated
