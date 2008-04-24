From: warped <warpme@o2.pl>
Subject: =?utf-8?q?2=2E6=2E25-rc8=3A_why_=23define_SND=5FHDA?=
	=?utf-8?q?=5FNEEDS=5FRESUME_is_not_set_=3F?=
Date: Thu, 24 Apr 2008 11:31:04 +0000 (UTC)
Message-ID: <loom.20080424T112202-229@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CEF424500
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 13:35:07 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JozjC-0003G4-TV
	for alsa-devel@alsa-project.org; Thu, 24 Apr 2008 11:35:05 +0000
Received: from proxy.lucent.com ([192.11.236.114])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2008 11:35:02 +0000
Received: from warpme by proxy.lucent.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2008 11:35:02 +0000
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

Hi all,

I have issue with 2.6.24/25 kernels and analog outs after s3 resume.
Simply: after s3 resume analog outs are dead (no sound). SPDIF works OK.
With 2.6.23.xx all was OK

I browse ALSA code in 2.6.25-rc8 and see that in hda_codec.h 
define SND_HDA_NEEDS_RESUME is commented.

Q is:
-might uncommenting this line help me with my issue ?
-why it is commented ?

My hw is Abit AN-M2HD with ALC889.
During boot Kernel reports:
user.info kernel: hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS... 
