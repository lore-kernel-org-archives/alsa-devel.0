From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] PulseAudio plugin: report XRUN state back to
	application
Date: Sun, 25 Nov 2007 22:12:26 +0100
Message-ID: <20071125211226.GF17108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 28D4F24626
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:12:27 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

Please consider merging this patch we ship in Fedora:

http://cvs.fedoraproject.org/viewcvs/*checkout*/devel/alsa-plugins/1.0.14-state-xrun.patch?rev=1.1

It adds support to report back XRUN to the application if one
happens. This is required to make some applications work on top of the
pulse plugin. One being XMMS, which checks if a song finished to play
by waiting for an XRUN (yes, I don't argue that XMMS shouldn't do
that, but nonetheless it is a good thing if XRUNs are reported
properly.)

Now, this patch is a bit problematic, since it touches pcm->io.state
which is not supposed to be touched by ioplug-based plugins --
according to the comments in ioplug. However, I saw no other way to
fix this, and from judging the ioplug code overwriting the variable
should be safe. Thus I decided to simply touch the variable but
documented it in a comment.

Alternatively, ioplug could be beefed up to properly handle XRUNs, but
I thought this fix is simpler.

Also reported on the ALSA BTS:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3579

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
