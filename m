From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: HDA - hdmi_show_short_audio_desc puts wrong rates in
	eld#N
Date: Tue, 07 Dec 2010 13:01:18 +0200
Message-ID: <4CFE13FE.5070703@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 960AB1039DE
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 12:01:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Just noticed that the sample rates reported in eld#X.Y are wrong.

They are printed by hdmi_show_short_audio_desc() in hda_eld.c. That
function uses the snd_print_pcm_rates() function to convert the rates
bitmap to a string. However, snd_print_pcm_rates() takes a HDA rates
bitmap, not a generic SNDRV_ one.  (BTW, an interesting function name
for an internal HDA thing...)

This results in several errors.

For example, my 32000 44100 48000 88200 96000 176400 192000
becomes 44100 48000 88200 176400 192000 384000.

-- 
Anssi Hannula
