From: Eliot Blennerhassett <linux@audioscience.com>
Subject: alsa-driver patches
Date: Wed, 12 May 2010 13:05:54 +1200
Message-ID: <4BE9FEF2.6080803@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 270F91037F5
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:05:58 +0200 (CEST)
Received: from [192.168.1.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L2A00J6P8DVOE30@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 12 May 2010 13:05:56 +1200 (NZST)
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

since the acceptance of asihpi driver, and move to alsa-kernel, you
created a couple of patch files in alsa-driver/pci/asihpi
(that add conditional compilation for older kernels)

Can you tell me how these patches are generated and maintained?
(I guess this applies to any driver with this kind of patch).

I think that this arrangement means that my one upstream file needs to
be converted to two files (kernel .c + patch) when I submit updates?


thanks

-- 
Eliot Blennerhassett
AudioScience Inc.
