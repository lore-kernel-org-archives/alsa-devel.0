From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Extra options for sscape_ctl
Date: Sat, 28 Sep 2002 19:24:10 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209281824.g8SIOARM003377@wittsend.radionet>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@perex.cz
List-Id: alsa-devel@alsa-project.org


This quick patch should make the sscape_ctl utility slightly more user-friendly.

Chris


Index: sscape_ctl.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/sscape_ctl/sscape_ctl.c,v
retrieving revision 1.1
diff -u -u -r1.1 sscape_ctl.c
--- sscape_ctl.c	22 Sep 2002 08:58:04 -0000	1.1
+++ sscape_ctl.c	28 Sep 2002 18:21:49 -0000
@@ -16,6 +16,23 @@
 const char scope[] = "scope.cod";
 
 
+static void
+show_usage(void)
+{
+  printf("sscape_ctl: [--card card number]\n"
+         "            [--directory firmware directory]\n"
+         "sscape_ctl: --help\n"
+         "sscape_ctl: --version\n");
+}
+
+
+static void
+show_version(void)
+{
+  printf("ALSA SoundScape control utility: v" VERSION "\n");
+}
+
+
 void
 safe_close(int fd)
 {
@@ -120,13 +137,16 @@
   return err;
 }
 
+
 static const struct option long_option[] = {
   { "card", 1, NULL, 'c' },
   { "directory", 1, NULL, 'd' },
+  { "help", 0, NULL, 'h' },
+  { "version", 0, NULL, 'v' },
   { NULL, 0, NULL, '\0' }
 };
 
-static const char option[] = "c:d:";
+static const char option[] = "c:d:hv";
 
 int
 main(int argc, char *argv[])
@@ -157,14 +177,21 @@
       directory = optarg;
       break;
 
+    case 'h':
+      show_usage();
+      return EXIT_SUCCESS;
+
+    case 'v':
+      show_version();
+      return EXIT_SUCCESS;
+
     default:
-      fprintf(stderr, "Unknown option \'%c\'\n", c);
-      break;
+      return EXIT_FAILURE;
     } /* switch */
   } /* while */
 
   ret = EXIT_FAILURE;
-  sprintf(devicename, "hw:%i,0", card);
+  snprintf(devicename, sizeof(devicename), "hw:%i,0", card);
   err = snd_hwdep_open(&handle, devicename, O_WRONLY);
   if (err < 0)
   {


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
