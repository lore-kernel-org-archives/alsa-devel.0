From: Britt Yazel <bwyazel@ucdavis.edu>
Subject: Gina 3g and Echomixer issue
Date: Fri, 28 Jul 2017 21:58:17 -0700
Message-ID: <1501304297.1407.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f43.google.com (mail-pg0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A84E266A51
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 06:58:21 +0200 (CEST)
Received: by mail-pg0-f43.google.com with SMTP id c14so25792789pgn.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 21:58:21 -0700 (PDT)
Received: from [10.0.0.116] (c-73-12-161-237.hsd1.ca.comcast.net.
 [73.12.161.237])
 by smtp.gmail.com with ESMTPSA id e5sm46634007pfd.41.2017.07.28.21.58.18
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Jul 2017 21:58:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey guys,

I work in an auditory neuroscience research lab, and we are using a PCI 
Gina 3g to communicate with a Fireface 800 over ADAT.

My issue is this, 1) each time I reboot the system the digital mode is 
set to Coaxial digital, rather than ADAT, and I must set it after each 
reboot. Is there a way to make this setting persist through reboot, or 
perhaps a parameter that can be set when the kernel module is loaded to 
force ADAT?

2) The first time I switch from Coaxial digital to ADAT upon a reboot, 
I consistently get a loud squeeling sound coming from my studio 
monitors. I don't think this is the intended behaviuor, and it makes me 
worried when switching into ADAT mode. Granted, after switching the 
first time to ADAT, I can switch between coaxial digital and ADAT 
without the squeeling happeneing, it is just that first time after the 
reboot.

Thanks for the help guys. The Gina 3g, even though it is an old audio 
device, is still our most reliable sound card. We have tried many 
others with horrible success, and most other ADAT capable PCI/PCIe 
sound cards are far too expensive, and don't have robust Linux support. 
However, if you guys have a good reccomendation of an ADAT capable PCIe 
sound card with full Linux support, please let me know.

-Britt
