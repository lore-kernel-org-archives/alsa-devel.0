From: javi perez <havingfunwithjavi@gmail.com>
Subject: newie, adding a file to the project
Date: Wed, 23 Jun 2010 16:46:14 +0200
Message-ID: <AANLkTimjzHb5NdYhYzXVKl_tZV8yc9f4NHvDF_Zam-jn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8698C103902
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 16:46:15 +0200 (CEST)
Received: by gxk4 with SMTP id 4so835291gxk.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 07:46:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to add a file (aplay_miversion.c) to the project to make tests.
I have modified the Makefile.am file of the aplay directory in the project.
I have run ./configure and make and I don't get the file compiled. How shold
I change the lines?

LIBRT = @LIBRT@

INCLUDES = -I$(top_srcdir)/include
LDADD = $(LIBINTL) $(LIBRT)

# debug flags
#LDFLAGS = -static
#LDADD += -ldl

bin_PROGRAMS = aplay aplay_miversion

aplay_SOURCES = aplay.c
aplay_miversion_SOURCES = aplay_miversion.c

man_MANS = aplay.1 arecord.1
noinst_HEADERS = formats.h



EXTRA_DIST = aplay.1 arecord.1
EXTRA_CLEAN = arecord

arecord: aplay
    rm -f arecord
    $(LN_S) $< $@

arecord.1: aplay.1
    rm -f arecord.1
    $(LN_S) $< $@

install-exec-hook: arecord
    rm -f $(DESTDIR)$(bindir)/arecord
    (cd $(DESTDIR)$(bindir) && $(LN_S) aplay arecord)

install-data-hook:
    rm -f $(DESTDIR)$(mandir)/man1/arecord.1
    (cd $(DESTDIR)$(mandir)/man1 && $(LN_S) aplay.1 arecord.1)
