From: adelias <adelias@freemail.gr>
Subject: XMOS UAC2
Date: Thu, 09 Aug 2012 22:33:08 +0300
Message-ID: <50241074.8050001@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id EC827266348
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 21:03:35 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SzYTx-0003nf-7p
 for alsa-devel@alsa-project.org; Thu, 09 Aug 2012 21:33:21 +0200
Received: from 212.54.222.117.dsl.dyn.forthnet.gr ([212.54.222.117])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 21:33:21 +0200
Received: from adelias by 212.54.222.117.dsl.dyn.forthnet.gr with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 21:33:21 +0200
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
Cc: adelias@freemail.gr
List-Id: alsa-devel@alsa-project.org

I have an XMOS Reference board with the latest firmware (v3.3). With 
ALSA 1.0.23 it enumerates and functions properly. With ALSA 1.0.25 it 
appears to enumerate properly after boot up but will not output sound. 
Removing and reinserting snd-usb-audio with modprobe doesn't help. Only 
after I reset it by unpluging and repluging the usb cable will it 
function as it should.
