From: Josh Lehan <alsa@krellan.com>
Subject: [PATCH - alsa-utils 0/5] The amidicat program as a
	patch
Date: Mon, 30 Jun 2014 01:54:58 -0700
Message-ID: <1404118503-22921-1-git-send-email-alsa@krellan.com>
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
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

This is my "amidicat" program, which makes it easy and straightforward
to interact with the ALSA MIDI sequencer from the command line,
by simply using standard input and output.

It took just over a year, to find the time to work on it again,
but here it is, formatted as a patch to alsa-utils, as requested.

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-May/062353.html

It has been cleaned up to match "checkpatch" coding standards,
and all compiler warnings have been fixed.

The documentation has also been cleaned up, in particular, the Perl
examples have been brought up to date: the raw bytes no longer
cause errors on Unicode systems.

I respectfully submit this program to alsa-utils,
and hope that it makes it in there :)

Josh Lehan

Josh Lehan (5):
  Adding amidicat subdirectory to SUBDIRS
  Add amidicat Makefile to AC_OUTPUT list
  Makefile for amidicat, includes manual page
  Documentation manual page for amidicat
  The amidicat program itself, better late than never

 Makefile.am          |    2 +-
 amidicat/Makefile.am |    5 +
 amidicat/amidicat.1  |  392 ++++++++++++
 amidicat/amidicat.c  | 1708 ++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac         |    2 +-
 5 files changed, 2107 insertions(+), 2 deletions(-)
 create mode 100644 amidicat/Makefile.am
 create mode 100644 amidicat/amidicat.1
 create mode 100644 amidicat/amidicat.c

-- 
1.8.3.2
