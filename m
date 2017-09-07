From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [bug] Missing "front" definition for byt-max98090
Date: Thu, 07 Sep 2017 15:25:44 +0300
Message-ID: <1504787144.2980.23.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 24CC5266AE1
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 14:25:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

PulseAudio 11 stopped using "hw:" as a fallback for analog stereo if
"front:" doesn't work. This caused a regression on "Toshiba Chromebook
2 (Swanky)", because PulseAudio doesn't any more do automatic mixer
adjustments when plugging in headphones. Apparently on this machine
"hw:1,0" works fine as a substitute for "front:1,0", but we're not
going to revert the change in PulseAudio, so could someone add the
"front" definition for this machine in alsa-lib? Unfortunately I'm not
proficient enough in the alsa-lib configuration system to make a patch
myself.

alsa-info here: https://bugs.freedesktop.org/attachment.cgi?id=133993

[1] https://bugs.freedesktop.org/show_bug.cgi?id=102560

-- 
Tanu

https://www.patreon.com/tanuk
