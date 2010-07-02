From: Eliot Blennerhassett <linux@audioscience.com>
Subject: linux vs c99 fixed width types
Date: Fri, 02 Jul 2010 13:13:26 +1200
Message-ID: <4C2D3D36.3020009@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EABE2452C
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jul 2010 03:13:31 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L4W008SAOQFK320@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 02 Jul 2010 13:13:27 +1200 (NZST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi, & list

it is quite likely that we will be moving our own codebase to use the
C99 fixed width types rather than our own  e.g. uint32_t vs HW32 etc.

Currently HW32 is translated into u32 before I submit patches to you.
Should I do the same for the C99 types, or let them pass through unaltered?

regards

-- 
Eliot Blennerhassett
AudioScience Inc.
