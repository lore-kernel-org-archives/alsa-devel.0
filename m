From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001370]: Please apply patch to Rules.make
Date: Thu, 25 Aug 2005 14:12:09 +0200
Message-ID: <3371521cd7ce5a7287f6ec7d56904aee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA72F201
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 14:12:11 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1370> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1370
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-25-2005 14:12 CEST
Last Modified:              08-25-2005 14:12 CEST
======================================================================
Summary:                    Please apply patch to Rules.make
Description: 
In Debian we have to patch Rules.make so that it puts a temporary file
at a different location.  (Details: we use the mktemp program to create
the file and return the name of the file.)  It would be nice if upstream
would apply a patch to make our patch smaller.

Here is the proposed patch, which applies against 1.0.10rc1.  It
shouldn't
change any behavior by default, but when applied it allows distros to
change the location of the temporary file with a one-line patch.

diff -urNad alsa-driver-1.0.8/Rules.make
/tmp/dpep.jldRsB/alsa-driver-1.0.8/Rules.make
--- alsa-driver-1.0.8/Rules.make        2004-12-09 20:39:11.000000000
+0100
+++ /tmp/dpep.jldRsB/alsa-driver-1.0.8/Rules.make       2005-01-16
15:04:22.000000000 +0100
@@ -287,7 +287,7 @@
        genksyms_smp_prefix :=
 endif

-$(MODINCL)/$(MODPREFIX)%.ver: %.c
+$(MODINCL)/$(MODPREFIX)%.ver: %.c update-sndvers
        @if [ ! -r $(MODINCL)/$(MODPREFIX)$*.stamp -o
$(MODINCL)/$(MODPREFIX)$*.stamp -ot $< ]; then \
                if [ ! -f
$(CONFIG_SND_KERNELDIR)/include/linux/modules/$*.stamp ]; then \
                echo '$(CC) -D__KERNEL__ $(CFLAGS) $(EXTRA_CFLAGS) -E
-D__GENKSYMS__ $<'; \
@@ -308,7 +308,8 @@
 endif # export-objs

 define update-sndvers
-       @(echo "#ifndef _LINUX_SNDVERSIONS_H"; \
+       (tmpfile=`echo $(SNDVERSIONS).tmp`; \
+       (echo "#ifndef _LINUX_SNDVERSIONS_H"; \
          echo "#define _LINUX_SNDVERSIONS_H"; \
          echo "#include <linux/modsetver.h>"; \
          cd $(TOPDIR)/include/modules; \
@@ -316,14 +317,14 @@
            if [ -f $$f ]; then echo "#include \"modules/$${f}\""; fi; \
          done; \
          echo "#endif"; \
-       ) > $(SNDVERSIONS).tmp
-       @if [ -r $(SNDVERSIONS) ] && cmp -s $(SNDVERSIONS)
$(SNDVERSIONS).tmp; then \
+       ) > $${tmpfile}; \
+       if [ -r $(SNDVERSIONS) ] && cmp -s $(SNDVERSIONS) $${tmpfile};
then \
                echo $(SNDVERSIONS) was not updated; \
-               rm -f $(SNDVERSIONS).tmp; \
+               rm -f $${tmpfile}; \
        else \
                echo $(SNDVERSIONS) was updated; \
-               mv -f $(SNDVERSIONS).tmp $(SNDVERSIONS); \
-       fi
+               mv -f $${tmpfile} $(SNDVERSIONS); \
+       fi)
 endef

 $(SNDVERSIONS):
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-25-05 14:12 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
