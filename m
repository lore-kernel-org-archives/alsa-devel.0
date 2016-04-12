From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Update documentation
Date: Tue, 12 Apr 2016 15:34:46 +0200
Message-ID: <1460468086-11051-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9617D2651B4
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:34:48 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6B504AB9D
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 13:34:47 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the URLs for alsa-info.sh and hda-emu.  Also drop the
alsa-driver snapshot URL since it's been discontinued recently.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio.txt | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio.txt b/Documentation/sound/alsa/HD-Audio.txt
index e7193aac669c..d4510ebf2e8c 100644
--- a/Documentation/sound/alsa/HD-Audio.txt
+++ b/Documentation/sound/alsa/HD-Audio.txt
@@ -655,17 +655,6 @@ development branches in general while the development for the current
 and next kernels are found in for-linus and for-next branches,
 respectively.
 
-If you are using the latest Linus tree, it'd be better to pull the
-above GIT tree onto it.  If you are using the older kernels, an easy
-way to try the latest ALSA code is to build from the snapshot
-tarball.  There are daily tarballs and the latest snapshot tarball.
-All can be built just like normal alsa-driver release packages, that
-is, installed via the usual spells: configure, make and make
-install(-modules).  See INSTALL in the package.  The snapshot tarballs
-are found at:
-
-- ftp://ftp.suse.com/pub/people/tiwai/snapshot/
-
 
 Sending a Bug Report
 ~~~~~~~~~~~~~~~~~~~~
@@ -699,7 +688,12 @@ problems.
 alsa-info
 ~~~~~~~~~
 The script `alsa-info.sh` is a very useful tool to gather the audio
-device information.  You can fetch the latest version from:
+device information.  It's included in alsa-utils package.  The latest
+version can be found on git repository:
+
+- git://git.alsa-project.org/alsa-utils.git
+
+The script can be fetched directly from the following URL, too:
 
 - http://www.alsa-project.org/alsa-info.sh
 
@@ -836,15 +830,11 @@ can get a proc-file dump at the current state, get a list of control
 (mixer) elements, set/get the control element value, simulate the PCM
 operation, the jack plugging simulation, etc.
 
-The package is found in:
-
-- ftp://ftp.suse.com/pub/people/tiwai/misc/
-
-A git repository is available:
+The program is found in the git repository below:
 
 - git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/hda-emu.git
 
-See README file in the tarball for more details about hda-emu
+See README file in the repository for more details about hda-emu
 program.
 
 
-- 
2.8.1
