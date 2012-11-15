From: Daniel Griscom <griscom@suitable.com>
Subject: USB hardware that supports implicit feedback?
Date: Thu, 15 Nov 2012 15:11:46 -0500
Message-ID: <p06240805cccafc72f23b@[192.168.1.36]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway13.websitewelcome.com (gateway13.websitewelcome.com
 [67.18.72.140]) by alsa0.perex.cz (Postfix) with ESMTP id A02BD26162A
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 21:11:50 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway13.websitewelcome.com (Postfix) with ESMTP id 92E0F7327F076
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 14:11:50 -0600 (CST)
Received: from 75-144-159-89-newengland.hfc.comcastbusiness.net
 ([75.144.159.89]:52091 helo=[192.168.1.8])
 by gator683.hostgator.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <griscom@suitable.com>)
 id 1TZ5mv-0008Si-6s
 for alsa-devel@alsa-project.org; Thu, 15 Nov 2012 14:11:49 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[I posted this to the user list with no response; perhaps it was too 
technical.]

I'm having trouble getting implicit feedback working with my custom 
capture/playback USB audio class device, even with the latest kernel. 
I presume it's a problem with my device's configuration, but can't 
figure out exactly what the problem is (after a whole lotta 
investigation).

Specifically, my device captures an AES/EBU data stream (at a frame 
rate dictated by an external device), sends it to the computer via 
USB and ALSA, and then takes a processed audio stream from the 
computer via ALSA and USB, and sends it out at the same frame rate. 
The output stream should have the exact same frame rate as the input 
stream, governed by implicit feedback.

I understand that only recently has ALSA included support for 
implicit feedback. I'm running with kernel 3.6.6, which I believe 
includes the support, but still can't get it working. I'd really love 
to see something functioning in this mode so I can determine where 
the problem is.

Is there any commercial USB hardware out there that supports implicit 
feedback? I assume the ALSA developers are testing against something, 
but I can't find anything appropriate.

Or, is there source available that runs on some USB-capable micro 
board that supports it?


Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
