From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA - enable snoop on sch
Date: Sat, 02 Feb 2008 10:33:29 -0800
Message-ID: <1201977209.24072.103.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AB3C24592
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 19:33:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This patch enables snoop on Intel SCH chipset, eliminating static during
playback.
 

Signed off by Tobin Davis <tdavis@dsl-only.net>


P.S. I know this is real close to the final release, but it is
critically needed for product enabling.  The patch has no effect on
other components, and has been tested on production desktop and laptop
systems, along with Intel's Mobile Internet Device.  This is the last
patch needed for release.
