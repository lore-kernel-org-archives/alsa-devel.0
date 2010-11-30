From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: CONFIG_SND_HDA_INTEL regression on 2.6.37-rc3 - no audio
Date: Tue, 30 Nov 2010 13:31:46 -0800
Message-ID: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I just booted 2.6.37-rc3 and noticed my sound with
CONFIG_SND_HDA_INTEL stopped working, I get no audio at all. Is this a
known regression? I can bisect if not.

$ lsmod| grep snd
snd_hda_codec_analog    79955  1
snd_hda_intel          25446  3
snd_hda_codec         101539  2 snd_hda_codec_analog,snd_hda_intel
snd_hwdep               6546  1 snd_hda_codec
snd_pcm                88139  3 snd_hda_intel,snd_hda_codec
snd_seq_midi            5900  0
snd_rawmidi            21916  1 snd_seq_midi
snd_seq_midi_event      7291  1 snd_seq_midi
snd_seq                56979  2 snd_seq_midi,snd_seq_midi_event
snd_timer              23148  2 snd_pcm,snd_seq
snd_seq_device          6912  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    63192  15
snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               1240  1 snd
snd_page_alloc          8716  2 snd_hda_intel,snd_pcm

  Luis
