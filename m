From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Routing irq throw a gpio using the wm9713
Date: Tue, 25 May 2010 18:01:19 +0200
Message-ID: <4BFBF44F.1010000@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id B7CB824621
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 18:02:09 +0200 (CEST)
Received: from [10.30.3.4] (HELO granpasso.retis)
	by sssup.it (CommuniGate Pro SMTP 5.3.2)
	with ESMTPS id 60456236 for alsa-devel@alsa-project.org;
	Tue, 25 May 2010 17:59:15 +0200
Received: from [192.168.74.18] ([193.205.82.13])
	by granpasso.retis (8.14.4/8.14.4) with ESMTP id o4PG22p6082139
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 18:02:03 +0200 (CEST)
	(envelope-from trimarchi@gandalf.sssup.it)
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

Hi all,

I'm trying to rise an irq using irq2 of the wm9713 so I have configured
the codec like this:

#define GPIO2 (1 << 2)
#define GPIO6 (1 << 6)

/* Enable Interrupt Output enable on GPIO02 */
reg = codec->read(codec, AC97_MISC_AFE);
codec->write(codec, AC97_MISC_AFE, reg & ~GPIO02);

reg = codec->read(codec, AC97_GPIO_CFG);
codec->write(codec, AC97_GPIO_CFG, reg & ~GPIO02);

reg = codec->read(codec, AC97_GPIO_STICKY);
codec->write(codec, AC97_GPIO_STICKY, reg | GPIO06);

reg = codec->read(codec, AC97_GPIO_WAKEUP);
codec->write(codec, AC97_GPIO_WAKEUP, reg | GPIO06);


Then create a soc-jack on a gpio that is wired with the gpio6
of the codec.

I don't received any interrupt

Michael Trimarchi
