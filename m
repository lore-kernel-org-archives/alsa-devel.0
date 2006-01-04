From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001370]: Please apply patch to Rules.make
Date: Wed, 4 Jan 2006 14:39:21 +0100
Message-ID: <f70d091b374e82f344faddd31da70063@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 21FDE184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:39:22 +0100 (MET)
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


A NOTE has been added to this issue.
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
Last Modified:              01-04-2006 14:39 CET
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

----------------------------------------------------------------------
 jdthood - 01-04-06 14:39 
----------------------------------------------------------------------
We are still hoping for this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-25-05 14:12 jdthood        New Issue                                    
08-25-05 14:13 jdthood        File Added:
move-tmp-file-in-rules_20050825jdth1.patch                    
01-04-06 14:39 jdthood        Note Added: 0007420                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
