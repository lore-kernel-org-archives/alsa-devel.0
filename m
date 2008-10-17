From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: New BIOS, new vendor and device IDs
Date: Thu, 16 Oct 2008 21:51:27 -0500
Message-ID: <48F7FDAF.3010300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id D49B51037F0
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 04:51:56 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so126363eyc.56
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 19:51:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Developer Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My machine is a Lenovo 3000 N100 laptop (0768 model).  I had to recently 
update the BIOS.

Old BIOS:  lspci -> device id:  [17aa:2066] which is a Realtek ALC861VD 
(found in patch_realtek.c)

New BIOS: lspci -> device id: [8086:27d8] (found in hda_intel.c)

In both cases, I use the module option "model=3stack" to get sound working:
Laptop speakers work. 
Built-in mic works. 
External mic works
Headphones work; but automatic speaker muting does not. 

I tried to debug why I needed this module option at all, several months 
ago (old BIOS), but I didn't get far and just became complacent with 
using the module option.

If anyone is interested, I'll do what I can to help debug.  It would be 
nice to be able to use Skype with headphones...

Output of the alsa info script is at:  
http://www.alsa-project.org/db/?f=701ca6efa0500080dc78a555813f66c1d42096e6
That is with driver 1.0.17.  I'll try to update to the latest snapshot 
and run the script again.

Thanks,

Chris
