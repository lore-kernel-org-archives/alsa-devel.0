From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: max channels of 3 jacks 6 channels motherboard using
 model=auto realtek codec
Date: Wed, 6 Jul 2011 11:53:47 +0800
Message-ID: <CAN8cciZ58WH+sctP0DsaHsEBgkCpPPEHDpf3J=tVMaxvk+RRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C7011037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 05:53:48 +0200 (CEST)
Received: by fxh2 with SMTP id 2so7195374fxh.9
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 20:53:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Refer to commit ce764ab22e40a046065c9417ee5f04ad2a816ac1

ALSA: hda - Add channel-mode support to Realtek auto-parser

It seem that max channel is six instead of two when the channel mode
is 2ch for those 3 jacks motherboard

using hda-emu and alsa-info from
http://thread.gmane.org/gmane.linux.alsa.devel/86816

> PCM 0 p 44100 2 16
Open PCM ALC887 Analog for play
Available PCM parameters:
  channels: 2/6
  formats: S16_LE S32_LE
  rates: 44100 48000 96000 192000
Prepare PCM, rate=44100, channels=2, format=16 bits


because

	spec->multiout.max_channels = spec->multiout.num_dacs * 2;

is assigned after  alc_auto_add_multi_channel_mode() increase
spec->multiout.num_dacs from 1 to 3

		spec->multiout.num_dacs = num_pins + 1;
