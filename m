From: David Henningsson <david.henningsson@canonical.com>
Subject: [GIT PULL] hda-jack-retask
Date: Fri, 13 Apr 2012 13:49:24 +0200
Message-ID: <4F8812C4.3070307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 6F1072417B
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 13:49:24 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It was a while since Takashi suggested I would try to upstream my 
hda-jack-retask program into alsa-tools, but with Ubuntu 12.04 into 
final freeze I finally got some headroom to do so.

The program requires gtk3 to compile, and uses policykit (pkexec) as a 
run-time dependency to ask for root privileges where needed. I wasn't 
entirely sure where to document this in the best way, as the README file 
is primarily used for end-user documentation.

Also, for the integration stuff with the rest of the programs 
(gitcompile, autotools etc), I have mostly copy-pasted what I found in 
the echomixer program. I also tested by modfying a debian package to do 
a test build with this new program included, and it seemed to install 
files in the right places, so I hope all is correct in that regard as well.

Enjoy!

The following changes since commit a680841d4a2a142981d2038e9af0a07abc74c5d7:

   alsa-tools: hwmixvolume - update README for au88x0 (2012-03-13 
10:49:20 +0100)

are available in the git repository at:
   git://kernel.ubuntu.com/diwic/alsa-tools.git hda-jack-retask

David Henningsson (2):
       hdajackretask: Add new program for easy retask of hda pin nodes
       hdajackretask: Use autotools

  Makefile                          |    2 +-
  hdajackretask/AUTHORS             |    1 +
  hdajackretask/ChangeLog           |    1 +
  hdajackretask/Makefile.am         |   20 ++
  hdajackretask/NEWS                |    1 +
  hdajackretask/README              |   52 +++
  hdajackretask/apply-changes.c     |  285 +++++++++++++++++
  hdajackretask/apply-changes.h     |   15 +
  hdajackretask/configure.in        |   10 +
  hdajackretask/gitcompile          |   30 ++
  hdajackretask/main-gtk.c          |  523 +++++++++++++++++++++++++++++++
  hdajackretask/sysfs-pin-configs.c |  626 
+++++++++++++++++++++++++++++++++++++
  hdajackretask/sysfs-pin-configs.h |   63 ++++
  13 files changed, 1628 insertions(+), 1 deletions(-)
  create mode 100644 hdajackretask/AUTHORS
  create mode 100644 hdajackretask/ChangeLog
  create mode 100644 hdajackretask/Makefile.am
  create mode 100644 hdajackretask/NEWS
  create mode 100644 hdajackretask/README
  create mode 100644 hdajackretask/apply-changes.c
  create mode 100644 hdajackretask/apply-changes.h
  create mode 100644 hdajackretask/configure.in
  create mode 100755 hdajackretask/gitcompile
  create mode 100644 hdajackretask/main-gtk.c
  create mode 100644 hdajackretask/sysfs-pin-configs.c
  create mode 100644 hdajackretask/sysfs-pin-configs.h

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
