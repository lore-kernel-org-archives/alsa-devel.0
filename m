From: Brad Midgley <bmidgley@xmission.com>
Subject: alsa-lib plugin for bluetooth
Date: Mon, 29 Nov 2004 14:37:34 -0700
Message-ID: <41AB969E.3020709@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030500030806090304050803"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mgr2.xmission.com (mgr2.xmission.com [198.60.22.202])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 74EC02B8
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 22:32:34 +0100 (MET)
Received: from [198.60.22.201] (helo=mgr1.xmission.com)
	by mgr2.xmission.com with esmtp (Exim 4.34)
	id 1CYt8K-0006Ls-Pp
	for alsa-devel@alsa-project.org; Mon, 29 Nov 2004 14:32:32 -0700
Received: from [127.0.0.1] (helo=xmission.com)
	by mgr1.xmission.com with asmtp (Exim 4.32)
	id 1CYt8J-0007e4-6H
	for alsa-devel@alsa-project.org; Mon, 29 Nov 2004 14:32:31 -0700
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

This is a multi-part message in MIME format.
--------------030500030806090304050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I am working on the bluetooth-alsa project.

I want to try moving our code out of kernel space and I've looked at the 
jack plugin. It's a little confusing.

Is there a blow-by-blow somewhere to explain how to get asound 
configured and running with the jack plugin?

To start with, I will create a plugin that consumes writes and produces 
a square wave when it's read. I'll start working on the bluetooth stuff 
once I'm happy with that.

Does the card,dev,subdev device description map well to bluetooth? Would 
it be bluetooth-adapter,headset,service or something like that?

I've been digging in the api docs and I've attached my first patch. :)

Brad

--------------030500030806090304050803
Content-Type: text/plain;
 name="three-bytes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="three-bytes"

diff -u alsa-lib-1.0.6-orig/src/pcm/pcm.c alsa-lib-1.0.6/src/pcm/pcm.c
--- alsa-lib-1.0.6-orig/src/pcm/pcm.c   2004-05-04 09:13:23.000000000 -0600
+++ alsa-lib-1.0.6/src/pcm/pcm.c        2004-11-29 14:25:31.000000000 -0700
@@ -206,7 +206,7 @@

 The full list of formats present the #snd_pcm_format_t type.
 The 24-bit linear samples uses 32-bit physical space, but the sample is
-stored in low three bits. Some hardware does not support processing of full
+stored in low three bytes. Some hardware does not support processing of full
 range, thus you may get the significant bits for linear samples via
 #snd_pcm_hw_params_get_sbits() function. The example: ICE1712
 chips support 32-bit sample processing, but low byte is ignored (playback)

--------------030500030806090304050803--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
