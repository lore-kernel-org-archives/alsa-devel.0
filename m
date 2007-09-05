From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: aplay -M (mmap) omap
Date: Wed, 5 Sep 2007 18:04:30 -0500
Message-ID: <B082902A12CAEE4EA7FE2ED20609013B01858F1D@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from calf.ext.ti.com (calf.ext.ti.com [198.47.26.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 89539243AD
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 01:04:39 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id l85N4Wvp029451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 5 Sep 2007 18:04:38 -0500
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.7/8.13.7) with ESMTP id l85N4W8b017330
	for <alsa-devel@alsa-project.org>; Wed, 5 Sep 2007 18:04:32 -0500 (CDT)
Content-class: urn:content-classes:message
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

Hi,
 
I'm experiencing kernel crashes in an omap platform when playing audio
files with 'aplay -M' (mmap option) the second time a file is played.
 
Any suggestion where to start debugging this? Is there a common cause
for this failure?
 
Misael
