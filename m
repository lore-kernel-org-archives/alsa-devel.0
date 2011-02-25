From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: [PATCH 1/2] acore: deprecated function in wrappers.c
Date: Fri, 25 Feb 2011 16:35:18 +0100
Message-ID: <4D67CC36.4090004@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout4.mailmx.agnat.pl
	[193.239.44.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDC7244DC
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 16:35:26 +0100 (CET)
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.74)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1PszhO-0004cn-IT
	for alsa-devel@alsa-project.org; Fri, 25 Feb 2011 16:35:18 +0100
Received: from [78.133.172.40] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1PszhO-0004cZ-GZ
	for alsa-devel@alsa-project.org; Fri, 25 Feb 2011 16:35:18 +0100
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

This patch replace the call of pci_find_device() to pci_get_device(). 
The function pci_find_device() was deprecated for quite a long time, and 
now it is no longer in the kernel.

Signed-off-by: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
---

diff -uprN a/acore/wrappers.c b/acore/wrappers.c
--- a/acore/wrappers.c    2011-01-27 12:09:20.000000000 +0000
+++ b/acore/wrappers.c    2011-02-25 13:41:46.000000000 +0000
@@ -197,7 +197,7 @@ EXPORT_SYMBOL(snd_compat_devfs_mk_cdev);
 int snd_pci_dev_present(const struct pci_device_id *ids)
 {
     while (ids->vendor || ids->subvendor) {
-        if (pci_find_device(ids->vendor, ids->subvendor, NULL))
+        if (pci_get_device(ids->vendor, ids->subvendor, NULL))
             return 1;
         ids++;
     }
