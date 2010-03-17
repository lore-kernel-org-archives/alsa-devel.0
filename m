From: Felix Homann <fexpop@web.de>
Subject: How to create an Alsa mixer for a USB device w/o mixer
	descriptor?
Date: Wed, 17 Mar 2010 09:37:13 +0100
Message-ID: <4BA094B9.8010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id EF633103806
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 09:37:14 +0100 (CET)
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

Hi,

as posted earlier, I've got a USB device (Fast Track Ultra 8R) wich 
*has* a mixer unit but doesn't have a descriptor for it. It's operated 
by standard control messages. Although I'm specifically interested in 
my  device, I guess there are many more USB interfaces out there with 
similar issues.

So in general:
What's the best way to build a Alsa mixer for such devices. Should one 
bypass all the descriptor parsing and build a mixer specifically for the 
device in interest? Or should one think about  passing a "fake" 
descriptor to the mixer build process?

Any ideas?


Kind regards,

Felix
