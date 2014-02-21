From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] rawmidi: remove undefined functions.
Date: Fri, 21 Feb 2014 11:18:57 +0900
Message-ID: <5306B791.4030101@sakamocchi.jp>
References: <1392908364-8301-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hk3cpvltc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010804020707040707070404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C377C261718
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 03:19:04 +0100 (CET)
In-Reply-To: <s5hk3cpvltc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010804020707040707070404
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Could you give your sign-off?

Oops, I forgot it...
Would you use attached patch instead of previous one?

Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


--------------010804020707040707070404
Content-Type: text/x-patch;
 name="0001-rawmidi-remove-undefined-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-rawmidi-remove-undefined-functions.patch"

>From 1cc92cabd87472deb58a461344c0d70b3ecd93bd Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 20 Feb 2014 23:45:39 +0900
Subject: [PATCH] rawmidi: remove undefined functions.

'snd_rawmidi_transmit_reset()' and 'snd_rawmidi_receive_reset()' are declared
but not defined.

This state has been continue over 10 years. So let us remove them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/rawmidi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index adf0885..311dafe 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -157,10 +157,8 @@ void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
 
 /* callbacks */
 
-void snd_rawmidi_receive_reset(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
 			const unsigned char *buffer, int count);
-void snd_rawmidi_transmit_reset(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 			      unsigned char *buffer, int count);
-- 
1.8.3.2


--------------010804020707040707070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010804020707040707070404--
