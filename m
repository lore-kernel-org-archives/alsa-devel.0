From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] Use different buffer metrics in the PulseAudio
	plugin
Date: Sun, 25 Nov 2007 22:09:53 +0100
Message-ID: <20071125210953.GE17108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 70DD924623
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:09:53 +0100 (CET)
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

Please commit this patch to alsa-plugins we ship in Fedora:

http://cvs.fedoraproject.org/viewcvs/*checkout*/devel/alsa-plugins/1.0.14-buffer-attr.patch?rev=1.1

It increases the "pre-buffering level" (i.e. start threshold) to the
full buffer size minus one period. This makes PA work a little bit
more like normal audio devices, and makes a few drop outs go away for
software which uses very small period sizes.

It also increases the initial maximum buffer size, which allows a
small overcommit. That's not really an issue, but cleaner nonetheless
so I smuggled it into this patch.

Also reported in the ALSA BTS:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3578

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
