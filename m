From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 56/63] sound/usX2Yhwdep: change parameters of usb_{control,bulk}_msg() to msecs
Date: Tue, 8 Feb 2005 22:42:56 -0800
Message-ID: <20050209064256.GA1419@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5168726D
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 18:15:12 +0100 (MET)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j19HF6Bu176414
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 12:15:07 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j19HEoTm299732
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 10:14:51 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j19HEnv5005089
	for <alsa-devel@alsa-project.org>; Wed, 9 Feb 2005 10:14:49 -0700
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hi,

Description: Change units of parameters being passed to
usb_{control,bulk}_msg() to milliseconds. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/sound/usb/usx2y/usX2Yhwdep.c	2005-02-03 16:57:41.000000000 -0800
+++ 2.6.11-rc3-kj/sound/usb/usx2y/usX2Yhwdep.c	2005-02-08 14:24:09.000000000 -0800
@@ -226,7 +226,7 @@ static int snd_usX2Y_hwdep_dsp_load(snd_
 		if (err)
 			snd_printk("usb_set_interface error \n");
 		else
-			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6*HZ);
+			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6000);
 		kfree(buf);
 	}
 	if (err)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
