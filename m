From: Enno Fennema <ennofennema@tele2.nl>
Subject: Re: snd_pcm_wait function
Date: Mon, 12 Nov 2012 08:23:42 +0100
Message-ID: <50A0A3FE.4090901@tele2.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swip.net (mailfe05.tele2.nl [212.247.154.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B50D2615F3
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 08:22:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, daniellsanz2@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks for your reply. I may not have expressed myself clearly. I appear 
to have the opposite problem from Daniel Sanz re Non-blocking 
snd_pcm_drain (also posted 10 Nov). He wants the new sound to start 
immediately. I want to close the pcm AFTER the sound finished.

The docs say calling drain() puts the pcm in the DRAINING state. When I 
obtain the state immediately after drain() it is already SETUP.
I hoped a state change from DRAINING to SETUP  would be the right time 
to close the pcm but there appears to be no such state change.

Currently I solved my problem by a usleep() based on an estimate of the 
time needed to finish playing the last samples in the buffer.

If there is a more elegant way I would like to know. Otherwise I will 
stick with usleep(),

Regards,
Enno
