From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils][PATCH 0/5] Add man page for alsaucm +
	other fixes
Date: Fri,  9 Dec 2016 14:02:27 +0100
Message-ID: <20161209130232.19457-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FCEB267718
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 14:02:52 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

Hi,

while adding the alsaucm man page (patch 4/5) I noticed some other
things worth fixing, so here is the whole patch set.

In patch 4/5 the reStructuredText content is exactly the same reviewed
by Liam, so I put his ACK in the commit message.

Thanks,
   Antonio

Antonio Ospite (5):
  alsaucm: mention the "list1" command in the usage output
  configure.ac: fix the check for xmlto availability
  configure.ac: add a check for rst2man, a reStructuredText man page
    generator
  alsaucm: add a man page, generated from reStructuredText
  INSTALL: document how to configure a build for installation in a local
    dir

 .gitignore          |   1 +
 INSTALL             |   7 ++
 alsaucm/Makefile.am |   7 ++
 alsaucm/alsaucm.rst | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 alsaucm/usecase.c   |   3 +-
 configure.ac        |  15 +++-
 6 files changed, 264 insertions(+), 4 deletions(-)
 create mode 100644 alsaucm/alsaucm.rst

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
