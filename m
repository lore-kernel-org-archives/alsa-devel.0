From: Daniel Mack <daniel@caiaq.org>
Subject: hardware-dependent features
Date: Mon, 12 Nov 2007 14:13:50 +0100
Message-ID: <20071112131350.GA25885@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F9A124346
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:13:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 105877F4018
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:13:55 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIburcDRvjsG for <alsa-devel@alsa-project.org>;
	Mon, 12 Nov 2007 14:13:50 +0100 (CET)
Content-Disposition: inline
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

some of the devices the caiaq driver supports have special hardware
features such as switchable ground lift, input impedance selection or
other, hardware-specific features. On both Windows and MacOSX there are
special tools to set those features but the ALSA driver still lacks
support for them which I want to change soon. However, I couldn't find a
generic way to do that. I was thinking about a sysfs entry which is
attached to the sound card instance but didn't find a driver which did
similar things.

Also, I'd like to support the LEDs and displays on the devices and was
wondering which interface to choose for that. I've got a patch ready
which uses the generic led subsystem, but that approach seems to be a
bit ugly as I end up having one entry per led on each device in one
single folder. Any idea of a better way?

Thanks,
Daniel
