From: Dylan Reid <dgreid@chromium.org>
Subject: Jack detection on HDA vs SoC
Date: Fri, 3 Feb 2012 18:01:41 -0800
Message-ID: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1567B2439A
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 03:02:03 +0100 (CET)
Received: by wera1 with SMTP id a1so3569722wer.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Feb 2012 18:02:01 -0800 (PST)
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

under hda I see: new, control-based jack notification, and
auto-switching of the output/input done in the driver.
under soc it is: /dev/input used for jack notification, with the
switching _not_ done in the driver.

Is there a plan for the soc code to use the control-based method?
Is there a consensus on whether new drivers should auto-switch or not?

Thanks,

Dylan
