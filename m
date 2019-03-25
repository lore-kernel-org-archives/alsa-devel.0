From: <twischer@de.adit-jv.com>
Subject: [PATCH 00/10] ALSA: aloop: Support selection of snd_timer
Date: Mon, 25 Mar 2019 17:00:34 +0100
Message-ID: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

With the following patch set any sound timer can be used as timer source
for the aloop devices if selected. It can be select by the additional
timer_source kernel module parameter:
-2   the jiffies timer will be used as done without this patch (default)
-1   the sound timer will be selected depending on the linked sound cards
     (snd_pcm_link()). The sound timer of the first linked card which is not
     a aloop device nor a dummy device will be used.
0..N Select the sound timer by the card number.

This patch set is required for forwarding audio data between a HW sound card
and an aloop device without the usage of an asynchronous sample rate converter.


Best regards,

Timo
