From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: About impacts to user-land
Date: Thu, 30 Jan 2014 09:16:04 +0900
Message-ID: <1391040964-4733-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBAE2652C1
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 01:16:29 +0100 (CET)
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In this message, let me describe impacts to user-land by adding the drivers.

(I'm sorry but I re-post because previous post is not archived.)

[Supported devices]
Currently snd-fireworks, snd-bebob and snd-oxfw totally supports 65 devices.
But there are some models detected as the same device, there are some
models whici is based on Fireworks/BeBoB/OXFW but its IDs are unknown.
So they can totally supports 80-90 models.


[The number of PCM channels is different depending on models and
sampling rates]
There are some models detected as the same device but the number of
channels is different. (i.e. Mackie Onyx-i series)
There are some models in which the number of channels are different at
each sampling rate. (i.e. M-Audio Firewire 410)
There are many variations for PCM channels/rates.

In this reason, I cannot write ALSA Configuration with 'route' plugin
for 'front' or 'surround'.
The 'route' plugin needs fixed value for the number of channels but I
have no will to write Configurations for each devices.
(Maybe 100 or more files I have to write...)

If ALSA applications don't resolve channel mismatch in application side,
use 'plughw' device WITHOUT 'SND_PCM_NO_AUTO_CHANNELS' flag for
snd_pcm_open().

But PulseAudio has an issue. See:
http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-January/019685.html


[Conflict against user-land driver]
The supported devices can transmit one AMDTP stream and receive one
AMDTP stream.
Then there is a conflict between kernel-land drivers and user-land drivers.

The supported devices manage their connection by Plug Register,
according to IEC 61883-1.
The drivers can know whether the device is used or not by reading this
register.

This mechanism is already implemented in kernel-land driver. So
kernel-land driver never interrupt user-land driver.

Currently I suggest a patch for this to FFADO project. See:
http://sourceforge.net/mailarchive/message.php?msg_id=31856195


[Both of PCM/MIDI functionality can starts streaming]
An AMDTP can transfer PCM samples and MIDI messages as its data channel,
according to IEC 61883-6 (in detail, MMA/AMEI RP-027).
This means that both of PCM/MIDI stream can be joined into the same
AMDTP stream.
So both of PCM/MIDI functionality can start AMDTP stream.
Then users can't simultaneously use ALSA's MIDI functionality and
user-land driver.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
