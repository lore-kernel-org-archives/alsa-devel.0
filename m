From: "Brett Keating" <brett.keating@broadcom.com>
Subject: ALSA on top of OpenMAX
Date: Fri, 11 Jan 2008 13:08:10 -0800
Message-ID: <26D7B63815512D48B1847ACD65CCED100290E9F3@NT-SJCA-0751.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mms1.broadcom.com (mms1.broadcom.com [216.31.210.17])
	by alsa0.perex.cz (Postfix) with ESMTP id A79ED2463E
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 22:08:25 +0100 (CET)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
	mail-irva-10.broadcom.com (Postfix) with ESMTP id 163992AE for
	<alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 13:08:15 -0800 (PST)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
	[10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
	6B01020504 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 13:08:14
	-0800 (PST)
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

Hi!
 
We are interested in providing ALSA on our embedded linux platform. Our
interface to the sound devices is OpenMAX, through a multimedia
coprocessor. The host processor runs Linux and ALSA would hopefully be
able to "talk" to the coprocessor through OpenMAX.
 
I see many examples of using ALSA as a sink for OpenMAX, but not any
examples of OpenMAX acting as a device that ALSA can drive.
 
Is there any information available along these lines in terms of mapping
ALSA to OpenMAX?
 
Thanks for any help,
Brett
