From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/39] firewire-lib: Add support for MIDI
	capture/playback
Date: Mon, 10 Mar 2014 13:13:44 +0900
Message-ID: <531D3BF8.3090909@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-7-git-send-email-o-takashi@sakamocchi.jp>
 <531CD39A.9090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F509265044
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 05:13:48 +0100 (CET)
In-Reply-To: <531CD39A.9090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 05:48), Clemens Ladisch wrote:
> This is a 32-bit value.

OK.

Is it OK to use an assignment conversion here? Like:
for (f = 0; f < frames; f++) {
+		buffer[s->pcm_channels + 1] = 0x00;

> snd_rawmidi_transmit() will not write an unsused byte, and in any
> case, zero can be a valid MIDI data byte.

OK. The line is needless.

> The buffer pointer must be increased even when there is no active port.

Exactly. I confirm M-Audio Ozonic (opens two MIDI ports) receives wrong 
sequence of MIDI data because of this bug...

> fw_iso_context_create() can return an error code, but for s->pcm,
> all the IS_ERR stuff is not necessary.  This should be a plain NULL
> check.

OK.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
