From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/2] HDSPM - Documentation and TCO on AES(32)
Date: Tue,  2 Jul 2013 21:42:14 +0200
Message-ID: <1372794136-6591-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Here are two patches that I've received from Martin. The first only adds
comments to the driver to document the various register settings. Might
be useful for other developers.

The second patch adds TCO support on AES(32) cards. I took the liberty
to polish Martin's work to reflect the kernel coding style. It still
contains plenty of long-line warnings from checkpatch.pl, but I could
live with this.

There are also a few (five?) whitespace fixes and a typo fix which are
technically not related to TCO support. I could manually separate them
into two commits, but maybe it's acceptable as it is?


Cheers

Adrian Knoth (1):
  ALSA: hdspm - Add TCO support for RME AES(32)

Martin Dausel (1):
  ALSA: hdspm - Added some comments and control register documentation

 sound/pci/rme9652/hdspm.c | 438 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 317 insertions(+), 121 deletions(-)

-- 
1.8.3.1
