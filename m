From: Daniel T Chen <crimsunkg@yahoo.com>
Subject: Re:
	=?utf-8?q?alsa-utils=3A_alsactl_restore_not_working_?=
	=?utf-8?q?after_system=09restart?=
Date: Tue, 16 Dec 2008 15:50:02 +0000 (UTC)
Message-ID: <loom.20081216T154437-656@post.gmane.org>
References: <d9690f190812160458t79cef08dt56ad7bd68e174d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D15D12433B
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 16:55:05 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LCcGG-0005lX-Er
	for alsa-devel@alsa-project.org; Tue, 16 Dec 2008 15:55:04 +0000
Received: from smith.missi.ncsc.mil ([144.51.50.70])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:55:04 +0000
Received: from crimsunkg by smith.missi.ncsc.mil with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:55:04 +0000
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

Klaus Schulz <kls.schlz <at> googlemail.com> writes:
> It seems that either a link  /var/lib/alsa/asound.state to /etc/asound.state
> is needed
> or that /etc/init.d/alsa-utils needs to be updated within the restore
> section accordingly.

Please note that the Debian (and all its derivatives) source package of
alsa-utils does, in fact, patch for the former link:

http://svn.debian.org/wsvn/pkg-alsa/trunk/alsa-utils/debian/patches/move_asound_state_to_var.patch?op=file&rev=0&sc=0
