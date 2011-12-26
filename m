From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Period time/size in adaptive USB - alignment to
	nrpacks?
Date: Mon, 26 Dec 2011 21:07:23 +0100
Message-ID: <4EF8D3FB.8090109@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id A4BE1243CC
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 21:07:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id A0F2DA1A40B18
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 21:07:28 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sm1GsY8Cfy1e for <alsa-devel@alsa-project.org>;
	Mon, 26 Dec 2011 21:07:23 +0100 (CET)
Received: from [192.168.105.101] (ip28.insite.cz [81.0.237.28])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id A2B43A1A40B07
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 21:07:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have been analyzing USB URBs in wireshark. Output stream, adaptive
mode, 16 bits, 48kHz, stereo. Each URB is issued always at nrpacks
milliseconds. Each URB transfers 48 samples * 2 bytes * 2 channels *
nrpacks milliseconds of bytes. The last URB of period keeps the same
pace (nrpacks milliseconds), however holds only the remaining number of
bytes. This creates ripples in the data stream bitrate, possibly leading
to increased jitter of the PLL'd clock in the USB receiver.

When period size is aligned to multiples of samplerate/1000 * audio
frame bytes * nrpacks, all URBs carry constant number of bytes.

I am wondering if for the xx.000 Hz samplerates it made sense to offer
only these aligned multiples in snd_pcm_hw_params_set_period_time_near.

Thank you for your expert opinion.

Best regards,

Pavel.
