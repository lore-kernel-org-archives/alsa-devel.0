From: David Henningsson <david.henningsson@canonical.com>
Subject: ALSA: hda - Fix a regression of the position-buffer
	check
Date: Fri, 07 Oct 2011 21:39:54 +0200
Message-ID: <4E8F558A.2080600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id A46B2103828
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 21:39:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

The offending commit a810364a042 seems to be in v3.0-rc2 (according to 
git describe), so is there a reason why the below is not sent to 3.0 
stable tree?

commit 798cb7e897210dbf827f69a302c0967e0380ebac
Author: Takashi Iwai <tiwai@suse.de>
Date: Fri Sep 30 08:52:26 2011 +0200

     ALSA: hda - Fix a regression of the position-buffer check

     The commit a810364a0424c297242c6c66071a42f7675a5568
         ALSA: hda - Handle -1 as invalid position, too
     caused a regression on some machines that require the position-buffer
     instead of LPIB, e.g. resulting in noises with mic recording with
     PulseAudio.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
