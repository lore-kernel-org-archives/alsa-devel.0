From: Eliot Blennerhassett <linux@audioscience.com>
Subject: device_create_drvdata missing on older kernels
Date: Wed, 30 Jul 2008 15:00:34 +1200
Message-ID: <200807301500.34579.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id EDFC210380D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 05:00:41 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K4S006UFTOMHS20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 30 Jul 2008 15:00:23 +1200 (NZST)
Content-disposition: inline
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

I could not compile current git. (Error on acore/init.c)

Adding this to adriver.h fixed it for me. I'm not sure if this is the correct 
general fix?

#ifndef CONFIG_SND_HAS_DEVICE_CREATE_DRVDATA
#define device_create_drvdata(c,d,m,p,s,n) device_create((c),(d),(m),(s),(n))
#endif 

(My kernel 2.6.24-19-generic)

-- 
--
Eliot Blennerhassett
www.audioscience.com
