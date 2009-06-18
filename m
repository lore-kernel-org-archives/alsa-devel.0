From: Sergey Lapin <slapin@ossfans.org>
Subject: preventing SNDRV_PCM_STATE_XRUN
Date: Thu, 18 Jun 2009 12:48:37 +0400
Message-ID: <20090618084837.GA28278@build.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (build.ossfans.org [67.223.233.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 72AE524347
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Jun 2009 10:48:41 +0200 (CEST)
Received: from build.ossfans.org ([127.0.0.1])
	by build.ossfans.org (8.14.3/8.14.3/Debian-5) with ESMTP id
	n5I8mcCc028309
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2009 12:48:38 +0400
Received: (from slapin@localhost)
	by build.ossfans.org (8.14.3/8.14.3/Submit) id n5I8mcKj028308
	for alsa-devel@alsa-project.org; Thu, 18 Jun 2009 12:48:38 +0400
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

Hi, all!
I have uncontrollable data stream which I need to play through kernel
via ALSA snd_pcm_lib_write call. Everything is fine, but once
a few seconds I get SNDRV_PCM_STATE_XRUN on stream and thus, -EPIPE.
Sound glitches are minor, but annoying.

Is it possible to somehow prevent this from happenning? Is it possible
to distinguish if my next chunk of data will fit?

Thanks a lot,
S.
