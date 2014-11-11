From: Chris Pemberton <cjpembo@gmail.com>
Subject: possible snd_hda_intel jack-sensing issue with device
	8086:1c20
Date: Tue, 11 Nov 2014 12:34:41 -0600
Message-ID: <546256C1.80604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C6F902606FD
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 19:34:43 +0100 (CET)
Received: by mail-oi0-f47.google.com with SMTP id a3so7478856oib.34
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 10:34:42 -0800 (PST)
Received: from [192.168.1.110] (ks-67-239-111-142.dhcp.embarqhsd.net.
 [67.239.111.142])
 by mx.google.com with ESMTPSA id di8sm8537788obb.17.2014.11.11.10.34.41
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Nov 2014 10:34:41 -0800 (PST)
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

CentOS 7 x86_64
Asus P8Z68-V motherboard
Realtek ALC892
Gnome 3 desktop
nVidia GTX 770 with nVidia's driver

With BIOS set to HD for both rear and front jacks, I experience the problems I reported here:

https://bugs.freedesktop.org/show_bug.cgi?id=86158

Basically, sound works, but the selected output keeps auto-magically flipping from Analog-Out to Headphones and back so fast you barely hear a click..

Tried all sorts of snd_hda_intel module options and it didn't change.

Finally changed BIOS to set front jacks to AC97 (left rear jacks as HD) and sound works great... but no jack sensing occurs at all...

I can live without the jack sensing... but if anyone wants a stab at a fix, I'm game.

I've got the HDA Analyzer downloaded and running if that helps.

My device has id 8086:1c20

Perhaps similar to this bug that was brought to my attention?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=1565cc358585be40608b46f18f7ac431a1aae2bc

Output of alsa-info.sh is here:

http://www.alsa-project.org/db/?f=8cf116b0bc230524bcfa7285b2adb698078d4224

Thanks.
