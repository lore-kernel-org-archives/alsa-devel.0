From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: Question about snd_mixer_selem_get_playback_dB_range()
Date: Mon, 21 Mar 2011 14:52:13 +0200
Message-ID: <1300711933.24854.263.camel@IT-W2076>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B15B24399
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 13:52:14 +0100 (CET)
Received: from smtp1.digia.com (unknown [127.0.0.1])
	by IMSVA80 (Postfix) with ESMTP id AC28C37008F
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 14:52:13 +0200 (EET)
Received: from IT-EXCH02-HKI.it.local (unknown [10.9.52.53])
	by smtp1.digia.com (Postfix) with ESMTP id 9F36437006D
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 14:52:13 +0200 (EET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have added code to Pulseaudio that checks that the kernel driver
returns the same values if I call
snd_mixer_selem_get_playback_dB_range() or
snd_mixer_selem_ask_playback_vol_dB() with the lowest and highest volume
steps. The reason I do this is that I've seen a driver that didn't
return correct values from _dB_range() (it's fixed nowadays), so it's
possible that the same kind of bugs will be seen in the future too.
Doing this check at Pulseaudio startup helps to detect such bugs early.

My question is about the case where the lowest volume step is mute. Is
it a bug in the driver if _dB_range() returns something else than
SND_CTL_TLV_DB_GAIN_MUTE as the min gain in such case?

-- 
Tanu
