From: Bernhard Walle <bernhard@bwalle.de>
Subject: [ice1712] Word Clock with Delta1010 E
Date: Wed, 19 May 2010 21:00:38 +0200
Message-ID: <4BF43556.3050505@bwalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
	[80.67.18.15]) by alsa0.perex.cz (Postfix) with ESMTP id 78FB21038F5
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 21:00:42 +0200 (CEST)
Received: from [83.171.173.183] (helo=galilei.fritz.box)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <bernhard@bwalle.de>) id 1OEoVS-0005ms-HH
	for alsa-devel@alsa-project.org; Wed, 19 May 2010 21:00:38 +0200
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

we have a problem with the word clock input of the Delta 1010 E. At
first: I modified the source code of envy24control to accept the Delta
1010 E as subdevice so that it allows to set the word clock. I'll post
the patch after it works with the driver. However, the problem also
exists when I use plain alsamixer or amixer.

With the unmodified driver, I'm able to turn word clock on but whenever
I record something, the arecord program (or Audacity) doesn't get any
samples.

With OSS (which we're using now but we're trying to switch to ALSA) my
colleague Markus Prosch made a patch with lots of try & error that made
the word clock working:

http://opensound.hg.sourceforge.net/hgweb/opensound/opensound/rev/6a4bad6e7422

When I try to "port" that patch to ALSA, the behaviour changes: The
recording works, but the sample rate is too low so that it sounds quite
strange.

In any case: In the same hardware setup, it works flawlessly with OSS.
Also, we had no problem with the older Delta 1010. It seems to be an
incompatible change (or bug ;)) in revision E.

Are there any devs here that know the hardware better and could help me
in debugging that issue? Without any deeper sound driver knowledge and
without any data sheet, that's quite hard for me.

Thanks for your help!


Regards,
Bernhard

PS: Please keep me in Cc since I'm not on the list.
