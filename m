From: Andrei Boros <andrei@srr.ro>
Subject: dummy driver and Makefile inconsistency
Date: Wed, 19 Mar 2003 10:48:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E782EC9.EBB0A68@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 alsa-kernel/core/seq/Makefile contains the following:

obj-$(CONFIG_SND_SEQ_DUMMY) += snd-seq-dummy.o

However, there is no definition of CONFIG_SND_SEQ_DUMMY anywhere !!!

I believe CONFIG_SND_SEQ_DUMMY should be set to "m" if dummy driver and
sequencer support are enabled.

---------------------------------------------------------------
I made several changes so that ./configure sets this properly and the
module gets built properly, but I am having some trouble integrating it
with autoconf in the cvs tree before running cvscompile.

Here are the modifications I made in my alsa-driver/ : 

Makefile line 50:
-----------------------------------------------------------------
CONFIG_PCMCIA           = @CONFIG_PCMCIA@
CONFIG_SND_SEQUENCER    = @CONFIG_SND_SEQUENCER@
+CONFIG_SND_SEQ_DUMMY    = @CONFIG_SND_SEQ_DUMMY@
CONFIG_SND_OSSEMUL      = @CONFIG_SND_OSSEMUL@
ifeq (y,$(CONFIG_SND_OSSEMUL))
  CONFIG_SND_MIXER_OSS  = m
  CONFIG_SND_PCM_OSS    = m
-----------------------------------------------------------------
configure.in line 792 :
-----------------------------------------------------------------
fi
AC_SUBST(CONFIG_SND_SEQUENCER)
+dnl if test "$CONFIG_SND_DUMMY" = "m"; then
+  CONFIG_SND_SEQ_DUMMY="m"
+  AC_SUBST(CONFIG_SND_SEQ_DUMMY)
+  AC_DEFINE_CONFIG_SND_SEQ_DUMMY)
+dnl fi
if test "$CONFIG_SND_SEQUENCER" = "m"; then
  AC_DEFINE(CONFIG_SND_SEQUENCER)
-----------------------------------------------------------------
configure line 2930 : (I don't know how to integrate this with autoconf
and cvscompile)
-----------------------------------------------------------------
#define CONFIG_SND_DUMMY_MODULE 1
EOF
+        if test "$CONFIG_SND_SEQUENCER" = "m"; then
+            CONFIG_SND_SEQ_DUMMY="m"
+        fi

        CONFIG_SND_VIRMIDI="m"
        cat >> confdefs.h <<\EOF
-----------------------------------------------------------------
configure line 3408 : (I don't know how to integrate this with autoconf
and cvscompile)
-----------------------------------------------------------------
#define CONFIG_SND_DUMMY_MODULE 1
EOF
+                if test "$CONFIG_SND_SEQUENCER" = "m"; then
+                    CONFIG_SND_SEQ_DUMMY="m"
+                fi

                ;;
-----------------------------------------------------------------

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
