From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 0/2] ASoC: OMAP: Add support for
	mono audio links in McBSP DAI (take #2)
Date: Tue, 25 Nov 2008 12:45:07 +0200
Message-ID: <1227609909-25273-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C49BA243A6
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 11:45:48 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAPAjclA006809
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 12:45:47 +0200
Received: from localhost.localdomain (esdhcp042162.research.nokia.com
	[172.21.42.162])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mAPAjNFf020780
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 12:45:24 +0200
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

Hi

Second version adding support for mono audio links in OMAP McBSP DAI. At this
time, the channels_min is defined to 1 in omap-mcbsp.c and no hacks in
machine drivers wanting to use mono link are required.

If channel restrictions are required, then machine driver can use
snd_pcm_hw_constraint_minmax. Now only N810 machine driver is affected since
all other OMAP machine drivers are using TWL4030 or TLV320AIC23 codecs which
all claim to support only 2 channels so the link remains always stereo even
playing mono audio.


-- 
Jarkko
