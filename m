From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re:
	=?utf-8?q?Questions_about_/dev/snd_and_/proc/asound_?=
	=?utf-8?q?=28new=09ASoC_driver=29?=
Date: Tue, 12 Aug 2008 19:36:33 +0000 (UTC)
Message-ID: <loom.20080812T193359-309@post.gmane.org>
References: <489B6322.8080307@videotron.qc.ca>
	<20080808114334.GB17329@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A98224495
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 21:40:12 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KSzit-0002YQ-BQ
	for alsa-devel@alsa-project.org; Tue, 12 Aug 2008 19:40:05 +0000
Received: from modemcable024.51-130-66.mc.videotron.ca ([66.130.51.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 19:40:03 +0000
Received: from bidou by modemcable024.51-130-66.mc.videotron.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 19:40:03 +0000
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

Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:

> > I think all I have in /proc/asound is correct too:
> 
> udev and mdev rely on the information in /sys/class/sound to create
> device files - check the dev files in the directories under there.
> 
> > I think it's because I have nothing in /dev/snd. I'm right?
> 
> Yes.
> 

Thank you, I fixed my problem with creating manually my /dev/snd files.

Simon
