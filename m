From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: =?utf-8?q?Salsa-lib_pcm=5Flink_broken?=
Date: Fri, 15 Feb 2008 16:34:20 +0000 (UTC)
Message-ID: <loom.20080215T163237-493@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E2F8103831
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 17:34:27 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JQ3W6-0002Wz-JB
	for alsa-devel@alsa-project.org; Fri, 15 Feb 2008 16:34:26 +0000
Received: from 6.177.115-78.rev.gaoland.net ([6.177.115-78.rev.gaoland.net])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 16:34:26 +0000
Received: from matthieu.castet by 6.177.115-78.rev.gaoland.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 16:34:26 +0000
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

snd_pcm_link use SNDRV_PCM_IOCTL_UNLINK insted of SNDRV_PCM_IOCTL_LINK.


Matthieu
