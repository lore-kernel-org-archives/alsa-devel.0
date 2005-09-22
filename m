From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: 96KHz SPDIF output
Date: Thu, 22 Sep 2005 15:50:23 -0600
Message-ID: <4333271F.1080008@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B3D8148
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 23:50:26 +0200 (MEST)
Received: from [192.168.1.5] ([192.168.1.5])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j8MLoN32030098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 15:50:24 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was reading the datasheet on the VT1617A, that bit 3 (i.e. 0x0008) of
register 0x76 (miscellaneous register) controls the SPDIF_96 mode...

In this mode, the odd samples (N+1) go to SDATA_OUT1 (instead of
SDATA_OUT)... which is supported if bit 1 (0x0002) is set when this
register is read back (EN_DRA).

And was wondering if it was fairly simple/straightforward to add
support for this...

-Philip



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
