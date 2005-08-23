From: Bernard Leak <bernard@brenda-arkle.demon.co.uk>
Subject: Re: Building ALSA away from the source tree: some patches
Date: Tue, 23 Aug 2005 11:28:37 +0100
Message-ID: <430AFA55.2070108@brenda-arkle.demon.co.uk>
References: <43026EFB.9030802@brenda-arkle.demon.co.uk>	<s5hvf1x6hoa.wl%tiwai@suse.de>	<430A3CE2.30900@brenda-arkle.demon.co.uk> <s5hmzn957vs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040201080408040103060708"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzn957vs.wl%tiwai@suse.de>
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
--------------040201080408040103060708
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Dear List,

Takashi Iwai wrote

>Thanks.  But please attach one patch per one file.
>Also, don't forget to add the description of the patch (to commit as
>the changelog).
>  
>

Aargh! I shouldn't send patches so late at night:
I misunderstood/forgot/went blank on the instructions.

I am very likely being dense here, but it is not
obvious *how* I specify a description to use as
a CVS commitment comment... A quick scan of
recent threads with patches attached seems not
to help.

I suggest:
Allow separate build and source trees

... which will do for both alsa-lib and alsa-utils,
though the patches for these two packages are independent.


Bernard Leak.
--
Before they made me, they broke the mould.

--------------040201080408040103060708
Content-Type: text/x-patch;
 name="alsa-lib-1.0.9-include-Makefile.am.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-1.0.9-include-Makefile.am.patch"

#Output of diff -ru alsa-lib-1.0.9/include/Makefile.am{-old,}
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


--------------040201080408040103060708
Content-Type: text/x-patch;
 name="alsa-lib-1.0.9-src-Makefile.am.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-1.0.9-src-Makefile.am.patch"

#Output of diff -ru alsa-lib-1.0.9/src/Makefile.am{-old,}
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

--------------040201080408040103060708
Content-Type: text/x-patch;
 name="alsa-utils-1.0.9-alsaconf-Makefile.am.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-utils-1.0.9-alsaconf-Makefile.am.patch"

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

--------------040201080408040103060708
Content-Type: text/x-patch;
 name="alsa-utils-1.0.9-alsaconf-po-Makefile.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-utils-1.0.9-alsaconf-po-Makefile.in.patch"

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


--------------040201080408040103060708--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
