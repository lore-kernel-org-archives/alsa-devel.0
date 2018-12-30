From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: libhinawa v1.1.0 release
Date: Sun, 30 Dec 2018 17:06:57 +0900
Message-ID: <20181230080657.GA7327@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 41174267783
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 09:07:08 +0100 (CET)
Received: by mail-pf1-f195.google.com with SMTP id g62so12156643pfd.12
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:07:08 -0800 (PST)
Content-Disposition: inline
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
Cc: hayashi@clear-code.com, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Today I released libhinawa v1.1.0.
https://github.com/takaswie/libhinawa/releases/tag/1.1.0

This library is designed to send asynchronous transaction from Linux userspace
applications to units on IEEE 1394 bus by any language binding for GObject
Introspection. This library also includes some functionalities to handle model
specific features with helps of drivers in ALSA firewire stack.

In this release, a minor part of version number is incremented from 0 to 1
to submit an addition of new GObject object; HinawaSndTscm.

This object corresponds to a work in ALSA firewire stack in Linux sound
subsystem[1]. In a development period toward v4.21, a new feature was added
into ALSA firewire-tascam driver to support userspace interface for status and
control information demultiplexed from isochronous packet from target device.

The new object supports two features:

 * 'control' GObject signal to handle events of control surface on target device
 * 'hinawa_snd_tscm_get_state()' to read the latest status of target device

Additionally, in this release, thread model is changed. Till former releases,
this library internally starts a thread to handle both of Linux firewire
character device (/dev/fw*) and ALSA hwdep character device (/dev/snd/hw*).
Nowadays I recognize a need to poll /dev/fw* during operating /dev/snd/hw*
for asynchronous transactions on IEEE 1394 bus. To achieve this, this library
is changed to start two threads for the both.

Finally, I note that this series of work for ALSA firewire-tascam driver was
assisted by Scott Bahling. Without his help to investigate content of status and
control information on transferred image, we might not have handled events of
control surface. For detail, please refer to archived messages for Sep. 2018 to
Nov. 2018 in alsa-devel@alsa-project.org[2]. I greatly appreciate his help.

[1] [GIT PULL] sound updates for 4.21
http://lkml.iu.edu/hypermail/linux/kernel/1812.2/04303.html
[2] Alsa-devel Info Page
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


Happy new year.

Takashi Sakamoto
