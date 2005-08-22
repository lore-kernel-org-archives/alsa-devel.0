From: Bernard Leak <bernard@brenda-arkle.demon.co.uk>
Subject: Re: Building ALSA away from the source tree: some patches
Date: Mon, 22 Aug 2005 22:00:18 +0100
Message-ID: <430A3CE2.30900@brenda-arkle.demon.co.uk>
References: <43026EFB.9030802@brenda-arkle.demon.co.uk> <s5hvf1x6hoa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090904070609000904040201"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvf1x6hoa.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090904070609000904040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear List,

Takashi Iwai wrote:

>> The patches look almost fine to me, but they are broken because of the bad
>> behavior of your mailer, replacing tab with spaces.
>
My MTA has been sent to bed with no supper, and
will be allowed no GUI for a month.

> In addition, some of targeted files look wrong:  they should be
> Makefile.am instead of Makefile.in.

The patches deliberately cover Makefile.am and Makefile.in.
(a) All of these are part of the release I am patching.
(b) I wanted to show a minimalist set of changes to
     the Makefile.in files.  The diffs after I run my
     copy of automake are mostly version-specific
     junk, and I wanted to produce a clean replacement
     which won't screw up anyone who doesn't share my
     autotools chain.
(c) alsa-utils-1.0.9/alsaconf/po/Makefile.in was released
     with no corresponding Makefile.am file.

Anyway, I'll try again.

Bernard Leak.
--
Before they made me, they broke the mould.


--------------090904070609000904040201
Content-Type: text/x-patch;
 name="alsa-lib-1.0.9-sepbuild-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-1.0.9-sepbuild-1.patch"

#Output o f diff -ru alsa-lib-1.0.9/include/Makefile.am{-old,}
--- alsa-lib-1.0.9/include/Makefile.am-old	2005-04-14 15:01:10.000000000 +0100
+++ alsa-lib-1.0.9/include/Makefile.am	2005-08-16 21:38:08.000000000 +0100
@@ -12,10 +12,13 @@
 		      pcm_ordinary.h mixer_ordinary.h \
 		      alisp.h pcm_external.h pcm_ioplug.h pcm_extplug.h
 
-noinst_HEADERS = sys.h search.h list.h aserver.h local.h alsa-symbols.h
+noinst_HEADERS = alsa sys.h search.h list.h aserver.h local.h alsa-symbols.h
 
 CLEANFILES = stamp-vh version.h alsa
 
+alsa:
+	ln -s $(top_srcdir)/include alsa
+
 version.h: stamp-vh
 	@:
 
@@ -45,4 +48,4 @@
 
 install-data-hook:
 	test -d $(DESTDIR)$(sysincludedir) || mkdir -p $(DESTDIR)$(sysincludedir)
-	$(INSTALL_DATA) sys.h $(DESTDIR)$(sysincludedir)/asoundlib.h
+	$(INSTALL_DATA) $(srcdir)/sys.h $(DESTDIR)$(sysincludedir)/asoundlib.h

#Output o f diff -ru alsa-lib-1.0.9/include/Makefile.in{-old,}
--- alsa-lib-1.0.9/include/Makefile.in-old	2005-05-27 14:12:08.000000000 +0100
+++ alsa-lib-1.0.9/include/Makefile.in	2005-08-16 21:38:08.000000000 +0100
@@ -162,7 +162,7 @@
 		      alisp.h pcm_external.h pcm_ioplug.h pcm_extplug.h
 
 
-noinst_HEADERS = sys.h search.h list.h aserver.h local.h alsa-symbols.h
+noinst_HEADERS = alsa sys.h search.h list.h aserver.h local.h alsa-symbols.h
 
 CLEANFILES = stamp-vh version.h alsa
 
@@ -507,6 +507,9 @@
 	uninstall-info-am uninstall-info-recursive uninstall-recursive
 
 
+alsa:
+	$(LN_S) $(top_srcdir)/include alsa
+
 version.h: stamp-vh
 	@:
 
@@ -534,7 +537,7 @@
 
 install-data-hook:
 	test -d $(DESTDIR)$(sysincludedir) || mkdir -p $(DESTDIR)$(sysincludedir)
-	$(INSTALL_DATA) sys.h $(DESTDIR)$(sysincludedir)/asoundlib.h
+	$(INSTALL_DATA) $(srcdir)/sys.h $(DESTDIR)$(sysincludedir)/asoundlib.h
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
 .NOEXPORT:

#Output o f diff -ru alsa-lib-1.0.9/src/Makefile.am{-old,}
--- alsa-lib-1.0.9/src/Makefile.am-old	2005-05-10 11:52:30.000000000 +0100
+++ alsa-lib-1.0.9/src/Makefile.am	2005-08-16 21:38:08.000000000 +0100
@@ -1,9 +1,9 @@
 SUBDIRS=control mixer ordinary_mixer pcm ordinary_pcm rawmidi timer hwdep seq instr compat conf alisp
-EXTRA_DIST=Versions
+EXTRA_DIST=$(srcdir)/Versions
 COMPATNUM=@LIBTOOL_VERSION_INFO@
 
 if VERSIONED_SYMBOLS
-VSYMS = -Wl,--version-script=Versions
+VSYMS = -Wl,--version-script=$(srcdir)/Versions
 else
 VSYMS =
 endif

#Output o f diff -ru alsa-lib-1.0.9/src/Makefile.in{-old,}
--- alsa-lib-1.0.9/src/Makefile.in-old	2005-05-27 14:12:09.000000000 +0100
+++ alsa-lib-1.0.9/src/Makefile.in	2005-08-16 21:42:16.000000000 +0100
@@ -148,10 +148,10 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 SUBDIRS = control mixer ordinary_mixer pcm ordinary_pcm rawmidi timer hwdep seq instr compat conf alisp
-EXTRA_DIST = Versions
+EXTRA_DIST = $(srcdir)/Versions
 COMPATNUM = @LIBTOOL_VERSION_INFO@
 
-@VERSIONED_SYMBOLS_TRUE@VSYMS = -Wl,--version-script=Versions
+@VERSIONED_SYMBOLS_TRUE@VSYMS = -Wl,--version-script=$(srcdir)/Versions
 @VERSIONED_SYMBOLS_FALSE@VSYMS = 
 
 lib_LTLIBRARIES = libasound.la


--------------090904070609000904040201
Content-Type: text/x-patch;
 name="alsa-utils-1.0.9-sepbuild-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-utils-1.0.9-sepbuild-1.patch"

#Output of diff -ru alsa-utils-1.0.9/alsaconf/po/Makefile.in{-old,}
--- alsa-utils-1.0.9/alsaconf/po/Makefile.in-old	2005-01-13 15:32:56.000000000 +0000
+++ alsa-utils-1.0.9/alsaconf/po/Makefile.in	2005-08-16 22:56:04.000000000 +0100
@@ -7,6 +7,7 @@
 
 top_builddir = ../..
 
+srcdir = @srcdir@
 datadir = @datadir@
 exec_prefix = @exec_prefix@
 prefix = @prefix@
@@ -33,24 +34,26 @@
 
 .SUFFIXES: .po .gmo .mo
 
-.po.mo:
+%.mo : $(srcdir)/%.po
 	$(MSGFMT) -c -o t-$@ $< && mv t-$@ $@
 
-.po.gmo:
-	@lang=`echo $* | sed -e 's,.*/,,'`; \
-	rm -f $${lang}.gmo && $(GMSGFMT) -c --statistics -o t-$${lang}.gmo $${lang}.po && mv t-$${lang}.gmo $${lang}.gmo
+%.gmo : $(srcdir)/%.po
+	@lang=`echo $(srcdir)/$* | sed -e 's,.*/,,'`; \
+	rm -f $${lang}.gmo && $(GMSGFMT) -c --statistics -o t-$${lang}.gmo $(srcdir)/$${lang}.po && mv t-$${lang}.gmo $${lang}.gmo
 
 $(DOMAIN).pot: $(GETTEXT_SRC)
 	$(XGETTEXT) -o$@ --default-domain=$(DOMAIN) \
 	  --add-comments=TRANSLATORS: --language=Shell \
 	  $(XGETTEXT_OPTIONS) $<
 
+check check_recursive:
+
 clean:
 	rm -f $(CATALOGS) $(POFILES:.po=.mo) $(DOMAIN).pot
 
 update-po: $(DOMAIN).pot
 	@for po in $(POFILES); do \
-	$(MSGMERGE_UPDATE) $$po $(DOMAIN).pot; \
+	$(MSGMERGE_UPDATE) $(srcdir)/$$po $(DOMAIN).pot; \
 	done
 
 install-data-no:

#Output of diff -ru alsa-utils-1.0.9/alsaconf/Makefile.am{-old,}
--- alsa-utils-1.0.9/alsaconf/Makefile.am-old	2005-05-13 13:14:16.000000000 +0100
+++ alsa-utils-1.0.9/alsaconf/Makefile.am	2005-08-16 23:04:13.000000000 +0100
@@ -17,7 +17,7 @@
 	  esac; \
 	  $(mkinstalldirs) $(DESTDIR)$(mandir)$$loc/man$$ext; \
 	  echo " $(INSTALL_DATA) $$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext"; \
-	  $(INSTALL_DATA) $$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext; \
+	  $(INSTALL_DATA) $(srcdir)/$$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext; \
 	done
 
 uninstall-man8:
#Output of diff -ru alsa-utils-1.0.9/alsaconf/Makefile.in{-old,}
--- alsa-utils-1.0.9/alsaconf/Makefile.in-old	2005-05-27 14:21:16.000000000 +0100
+++ alsa-utils-1.0.9/alsaconf/Makefile.in	2005-08-16 23:03:57.000000000 +0100
@@ -472,7 +472,7 @@
 	  esac; \
 	  $(mkinstalldirs) $(DESTDIR)$(mandir)$$loc/man$$ext; \
 	  echo " $(INSTALL_DATA) $$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext"; \
-	  $(INSTALL_DATA) $$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext; \
+	  $(INSTALL_DATA) $(srcdir)/$$i $(DESTDIR)$(mandir)$$loc/man$$ext/$$inst.$$ext; \
 	done
 
 uninstall-man8:

--------------090904070609000904040201--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
