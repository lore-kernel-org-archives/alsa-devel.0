From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 0/2] minor clean-ups and aic3x
	naming change
Date: Tue,  7 Oct 2008 14:49:21 +0300
Message-ID: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 643BF24543
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 13:50:19 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m97BnJIB012761
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 06:50:03 -0500
Received: from localhost.localdomain (esdhcp04034.research.nokia.com
	[172.21.40.34])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	m97BnhLi008894
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 14:49:43 +0300
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

These two patches are generated agains Takashi's topic/asoc branch.

First one will remove unused AUDIO_NAME define from codec drivers. IMO
it didn't look so readable to use this define so I end up removing it.

Second one will use uniform naming like other tlv320aic drivers for
tlv320aic3x.


-- 
Jarkko
