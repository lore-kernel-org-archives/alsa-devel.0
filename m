From: Alban Browaeys <prahal@yahoo.com>
Subject: acer ferrari one hda realtek - attempt to improve
 forte mic IC support
Date: Thu, 19 Jan 2012 22:59:55 +0100
Message-ID: <1327010395.22934.12.camel@argos.server.maison>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A954103C58
	for <Alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 23:00:42 +0100 (CET)
Received: from argos.server.maison (unknown [IPv6:2a01:e35:8a6b:8030::2])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3BF199402D1
	for <Alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 23:00:37 +0100 (CET)
Received: from prahal by argos.server.maison with local (Exim 4.77)
	(envelope-from <prahal@yahoo.com>) id 1Ro027-0007mB-6T
	for Alsa-devel@alsa-project.org; Thu, 19 Jan 2012 23:00:35 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A lot of reports about aspire one issues lead me to think the mic IC
processing is the same as on this acer ferrari one 200.

Looking at alsa-driver-aspire_one-v1.09 assembly I see that it setup the
bdl entries to point to a capture buffer which it then split in two
buffers : namely mic and speaker .
This split happens by moving the first 32 bits to mic , the next 32 to
speaker , then to mic and so forth.
azx_pcm_hw formats is set to S16 LE.
I was wondering about the the 32 bits step between mic and speaker
buffer and ended up on azx_pcm_preapre where for the capture case
snd_hda_calc_stream_format is hardcoded a number of channels of 4.

My issue is I attempted the same trick and it seems I still miss
something . Ie the azx_dev->format passed in azx_setup_controller to
SD_FORMAT registry is incremented by 3 namely 0x33 . Though I still miss
half of each samples same as when I was passing runtime->channels ie 2
and 0x31. 

The codec is ALC272X ATI SB.

Best regards,
Alban Browaeys
