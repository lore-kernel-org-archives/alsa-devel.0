From: "Philip A. Prindeville" <philipp@redfish-solutions.com>
Subject: Unknown PCI id
Date: Thu, 18 Aug 2005 16:15:48 -0600
Message-ID: <43050894.4060407@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DA311E7
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 00:15:53 +0200 (MEST)
Received: from [192.168.1.5] ([192.168.1.5])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j7IMFmPS027485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 16:15:49 -0600
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

New PCI id to add support to for the via82xx:

% lspci -n -v -s 11.5
00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1462:0430
        Flags: medium devsel, IRQ 185
        I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2

This is the AC97 audio hardware (implemented via a VT1617A) on
the MSI 7142 (K8MM-V) motherboard.

Thanks,

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
