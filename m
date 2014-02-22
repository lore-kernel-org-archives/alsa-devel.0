From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC v3] [PATCH 00/52] Enhancement for support of
	firewire devices
Date: Sat, 22 Feb 2014 11:34:27 +0900
Message-ID: <53080CB3.9000504@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140221165444.GA25817@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A6DFE261A81
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 03:34:34 +0100 (CET)
In-Reply-To: <20140221165444.GA25817@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jay Fenlason <fenlason@redhat.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, Stefan Richter <stefanr@s5r6.in-berlin.de>, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jay,

Thanks for your testing.

But I  cannot respond to your bugs without enough information.

Please inform me what you tested. My RFC v3 patches or my repository in 
github? If my repository in github, please show me HEAD in your local 
repository.

Additionally, please send me:

1. PreSonus Inspire1394
  $ cat /proc/asound/cardX/#formation
  $ cat /proc/asound/cardX/#clock
  $ cat /proc/asound/cardX/#firmware
  $ aplay --verbose -D plughw:X /usr/share/sounds/alsa/Noise.wav
  $ arecord --verbose -D plughw:X /tmp/test.wav
  ('X' should be for inspire1394.)

2. FireWave
  $ cat /proc/asound/cards
  $ cat /proc/asound/cardY/#formation
  $ cat /proc/asound/cardY/#clock
  $ aplay --verbose -D plughw:Y /usr/share/sounds/alsa/Noise.wav
('Y' should be for FireWave.)

And I need dump of config_rom for FireWave.
  $ hexdump -C /sys/bus/firewire/devices/fwZ/config_rom
('Z' should be 1 or 2 for FireWave.)


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
