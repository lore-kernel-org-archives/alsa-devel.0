From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Buffer underrun
Date: Thu, 11 Sep 2008 19:39:17 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B6167057C397408@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A603C2441C
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 02:39:27 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8C0dKxI013373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2008 19:39:25 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8C0dK9e009145
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2008 19:39:20 -0500 (CDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I'm observing an issue with my audio driver in omap platform. When playing back audio files several 'buffer underrun' messages appear, but using -M option of 'aplay', audio is played fine.

Since the driver is for omap, I'm using the alsa driver for that platform with minor changes (sound/arm/omap/omap-alsa.c from omap-kernel)? Any idea what could be wrong?

Regards,
Misael
