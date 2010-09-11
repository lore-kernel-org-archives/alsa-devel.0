From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: Sound Blaster 5.1vx with CA0106
Date: Sat, 11 Sep 2010 15:31:20 +1000
Message-ID: <1284183080.5246.14.camel@marvin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id E3EDD2445D
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Sep 2010 07:31:30 +0200 (CEST)
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

Hi, I recently bought a Sound Blaster 5.1vx (which has a ca0106 chip on
it) and found that it didn't quite work properly in ALSA. 

The fix I made changes a few bits of code which aren't specific to my
sound card, and I don't have a way to test it. The code looks to be more
correct (I had to change a few spots to get the controls to operate on
the correct channels, and also to get the rear channels to work at all).

Could someone please review the patch, which I've attached to this bug
report:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5108

Thanks for your time.

Andy
