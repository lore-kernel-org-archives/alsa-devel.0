From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ignore conflicts with kernel .ver files
Date: Thu, 04 Dec 2003 11:35:32 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312041125550.22168-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Is there a reason that the makefile rule below prevents creating .ver
files if there is a .c file with exports in the kernel with the same
name?  (this happens for ac97_codec.c and sb_common.c)

Without .ver files, the make dependencies get out of whack, and the
affected .o files are rebuilt in each make run, even when they're up
to date.

As far as I can see, the kernel's and ALSA's .ver files could coexist
without problems, as they get their own directory, and don't (try to)
access each other.


Regards,
Clemens


-- 
Index: alsa-driver/Rules.make
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Rules.make,v
retrieving revision 1.35
diff -u -r1.35 Rules.make
--- alsa-driver/Rules.make	11 Nov 2003 13:12:15 -0000	1.35
+++ alsa-driver/Rules.make	4 Dec 2003 10:15:18 -0000
@@ -266,14 +266,12 @@

 $(MODINCL)/$(MODPREFIX)%.ver: %.c
 	@if [ ! -r $(MODINCL)/$(MODPREFIX)$*.stamp -o $(MODINCL)/$(MODPREFIX)$*.stamp -ot $< ]; then \
-		if [ ! -f $(CONFIG_SND_KERNELDIR)/include/linux/modules/$*.stamp ]; then \
 		echo '$(CC) -D__KERNEL__ $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'; \
 		echo '| $(GENKSYMS) $(genksyms_smp_prefix) > $@.tmp'; \
 		$(CC) -D__KERNEL__ $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $< \
 		| $(GENKSYMS) $(genksyms_smp_prefix) > $@.tmp; \
 		if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is unchanged; rm -f $@.tmp; \
 		else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
-		fi; \
 	fi; touch $(MODINCL)/$(MODPREFIX)$*.stamp

 $(addprefix $(MODINCL)/$(MODPREFIX),$(export-objs:.o=.ver)): $(TOPDIR)/include/config.h $(TOPDIR)/include/config1.h




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
