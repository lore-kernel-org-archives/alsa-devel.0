From: Zhen Fu <fuzh@marvell.com>
Subject: then there was "overrun" occue every time once trigger
 the audio recording
Date: Thu, 5 Jul 2012 19:28:49 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453625BABA@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 581AC24701
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 04:30:59 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Zhen Fu <fuzh@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi developer,

When I use arecord command, then there was "overrun" occue every time once trigger the audio recording. I have no clue of alsa driver when and how handler xrun. In other words, how to understand function snd_pcm_update_hw_ptr0 in pcm_lib.c. Please enlighten me on this issue. Thanks a lot in advance.

--
Best Regards,
Zhen Fu
