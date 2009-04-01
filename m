From: Ernesto Torres <skullmate@gmail.com>
Subject: how to use mcbsp for i2s?
Date: Wed, 1 Apr 2009 12:29:02 -0600
Message-ID: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f159.google.com (mail-gx0-f159.google.com
	[209.85.217.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 605A51037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 20:29:03 +0200 (CEST)
Received: by gxk3 with SMTP id 3so409727gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2009 11:29:02 -0700 (PDT)
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

I'm currently working in adding an external codec to the beagleboard, so far
the i2c control part is functional, now i want to use mcbsp3 to provide i2s
transfers

Is there any way to test the mcbsp to validate the connection?

Also, I've done little modifications to the omap3beagle.c to change from
mcbsp2 to mcbsp3, can someone validate this is correct?

In:
static int __init omap3beagle_soc_init(void)

I changed to:
*(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 2; /* McBSP3 */

It was:
*(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 1; /* McBSP2 */

Is this correct? Or it should be changed in other places too?


Thanks
