From: Timur Tabi <timur@freescale.com>
Subject: Question about pcm_formats[] array in
	sound/core/pcm_misc.c
Date: Tue, 11 Dec 2007 14:31:32 -0600
Message-ID: <475EF3A4.70304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 49263103822
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 21:31:45 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBBKVWiT013477
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 13:31:38 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBBKVWNC020709
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 14:31:32 -0600 (CST)
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

I'm confused about the entries for unsigned 24-bit sound in the pcm_formats[] array:

	[SNDRV_PCM_FORMAT_U24_BE] = {
		.width = 24, .phys = 32, .le = 0, .signd = 0,
		.silence = { 0x80, 0x00, 0x00 },
	},

and

	[SNDRV_PCM_FORMAT_U24_3BE] = {
		.width = 24, .phys = 24, .le = 0, .signd = 0,
		.silence = { 0x80, 0x00, 0x00 },
	},

SNDRV_PCM_FORMAT_U24_BE means a 24-bit sample packed into a 32-bit word.  So I 
presume that if the 24-bit sample is:

0x123456

then when that sample is written to memory, it looks like this:

X	X + 1	X + 2	X + 3
0x00	0x12	0x34	0x56

(where X is some address in memory).

If that's so, shouldn't the entry for SNDRV_PCM_FORMAT_U24_BE look like this:

	[SNDRV_PCM_FORMAT_U24_BE] = {
		.width = 24, .phys = 32, .le = 0, .signd = 0,
		.silence = { 0x00, 0x80, 0x00, 0x00 },
	},                  ^^^^^^

-- 
Timur Tabi
Linux kernel developer at Freescale
