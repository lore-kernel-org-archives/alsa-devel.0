From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Salsa-lib memleak
Date: Tue, 5 Feb 2008 10:22:30 +0000 (UTC)
Message-ID: <loom.20080205T101316-708@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E1A124562
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 11:22:40 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMKwn-0007Q5-Jq
	for alsa-devel@alsa-project.org; Tue, 05 Feb 2008 10:22:37 +0000
Received: from 6.177.115-78.rev.gaoland.net ([6.177.115-78.rev.gaoland.net])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2008 10:22:37 +0000
Received: from matthieu.castet by 6.177.115-78.rev.gaoland.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2008 10:22:37 +0000
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

it seems Salsa-lib leak memory in case of errors.
For snd_pcm_open, snd_pcm_t is allocated, but not free in case of
snd_pcm_hw_mmap_status error.

The same things happen in _snd_pcm_mmap, there error return in middle of the
code, without freeing the allocated memory.


Thanks

Matthieu
