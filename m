From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: [PATCH] cmipci - allow capture of raw spdif subframes
Date: Wed, 07 Nov 2007 15:12:46 +0300
Message-ID: <4731ABBE.8030805@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A76E2438B
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 13:12:47 +0100 (CET)
Received: from black.ipi.ac.ru (black.ipi.ac.ru [192.168.1.44])
	by ipi.ac.ru (8.14.1/8.14.1) with ESMTP id lA7CCkh8013664
	for <alsa-devel@alsa-project.org>; Wed, 7 Nov 2007 15:12:46 +0300
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

Hi.

Enable capturing of raw 32bit IEC958_SUBFRAME.

The 24-bits PCM data can be obtained using iec958 plugin.

Known problem: captured stream may begin with either left or right 
subframe. Since the iec958 plugin doesn't decode preamble it may swap 
the channels sometime.

Regards,
	Tim.
