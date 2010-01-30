From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] playing / recording mono on a stereo-only hardware
Date: Sat, 30 Jan 2010 10:49:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9C1571037F2
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 10:49:14 +0100 (CET)
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>) id 1Nb9x9-0001lq-MQ
	for alsa-devel@alsa-project.org; Sat, 30 Jan 2010 10:49:19 +0100
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

Hi

I know this question belongs rather to alsa-users, and I did ask it there, 
but got no solution so far. Maybe someone here can help.

The recently posted SuperH SIU driver only supports stereo playback and 
capture (channels_min = channels_max = 2). Is there a way to tell alsa-lib 
to duplicate the mono-channel during playback and to mix recorded channels 
(or use one of them), if mono recording is requested?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
