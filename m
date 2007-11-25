From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Some drivers don't create all necessary sysfs symlinks
Date: Sun, 25 Nov 2007 22:08:32 +0100
Message-ID: <20071125210832.GD17108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 143B224608
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 22:08:33 +0100 (CET)
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

Apparently not all ALSA drivers set the "device" symlink
properly. This creates problems with HAL which then is unable to
manage permissions to those files properly. One example of such a
driver is EMU10K1X.

For more information, see:

https://bugzilla.redhat.com/show_bug.cgi?id=370821#c26

Also reported on the ALSA BTS:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3575

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
