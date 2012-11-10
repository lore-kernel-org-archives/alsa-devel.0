From: Enno Fennema <ennofennema@tele2.nl>
Subject: snd_pcm_wait function
Date: Sat, 10 Nov 2012 17:43:49 +0100
Message-ID: <509E8445.8050001@tele2.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swip.net (mailfe07.tele2.nl [212.247.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 6862926160F
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 17:42:46 +0100 (CET)
Received: from [143.176.48.63] (account cxu-brf-4d3@tele2.nl HELO
 [192.168.1.7]) by mailfe07.swip.net (CommuniGate Pro SMTP 5.4.4)
 with ESMTPSA id 341944006 for alsa-devel@alsa-project.org;
 Sat, 10 Nov 2012 17:42:43 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The documentation says this functions waits for the pcm to become ready 
for I/O. I am not sure what ready means in this context.

I assume entering the PREPARED state. Is that correct?

Is there a function to wait for entering the SETUP state. In particular 
I would like to wait for pcm_snd_drain to finish.

Appreciate any help.

Enno Fennema
