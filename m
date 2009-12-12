From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: dmix on hda-intel
Date: Sat, 12 Dec 2009 02:10:21 -0500
Message-ID: <604760770912112310wbee6d5dq3069f447fe3e3b56@mail.gmail.com>
References: <20091211155255.GA5383@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id A482B10382D
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 08:10:23 +0100 (CET)
Received: by pxi3 with SMTP id 3so1120311pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 23:10:21 -0800 (PST)
In-Reply-To: <20091211155255.GA5383@gamma.logic.tuwien.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norbert Preining <preining@logic.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Your controller and codec certainly have dmix, dsnoop, and softvol
enabled by default. However, nothing prevents a rogue application from
grabbing plughw or hw or using OSS emulation (you have the kernel
modules loaded). In other words, inspect the ALSA configurations of
the audio applications that you use. If any of them are not using
"default" as the device, there's a good chance you've located a
culprit.
