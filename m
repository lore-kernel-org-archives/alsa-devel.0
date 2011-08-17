From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 13:29:07 +0530
Message-ID: <1313567970.533.21.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 21CB51038D0
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 09:58:21 +0200 (CEST)
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

Hello,
I'm trying to figure out the right way to set the NONAUDIO flag on an
iec958 device. The idea is that when we get a new stream in PulseAudio
that signals a non-PCM format, we'd like to set the NONAUDIO flag to let
receivers know that this isn't PCM data. I tried doing what iecset does
in the PA alsa-sink code but this fails.

As far as I can tell, this happens because: (a) if I set the flag before
snd_pcm_open(), the AES0 value from iec958.conf gets used, and (b) if I
set the flag after snd_pcm_open(), changing the value is no longer
permitted.

Any help/pointers would be appreciated.

Thanks,
Arun
