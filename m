From: Sverker Wiberg <sverkerw@swipnet.se>
Subject: [PATCH] snd_instr_iwffff_open_rom() fails
Date: Thu, 14 Nov 2002 02:40:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15826.65303.482611.464553@catskinner.nonet.update.uu.se>
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


Opening the patch ROM on GusPnP always fails:

* iwffff_get_rom_header() gets the card directory wrong when opening
  the ROM file.

* iwffff_get_rom_header() forgets that the ROM header is padded to 512
  bytes length.

I also fixed some small stuff:

* Tried to improve snd_instr_iwffff_open_rom()'s doxygen comment. The
  commingling of file-system files (denoted by names) and ROM-embedded
  files (numbers) is somewhat confusing --- I'm still looking for the
  right words to explain it.

* Oh, and snd_instr_iwffff_open_rom() returns -EPERM for invalid
  bank/file values --- it means the wrong thing: ENOENT would be
  better.

/Sverker Wiberg

Index: alsa-lib/src/instr/iwffff.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/instr/iwffff.c,v
retrieving revision 1.20
diff -u -r1.20 iwffff.c
--- alsa-lib/src/instr/iwffff.c	4 Feb 2002 11:18:40 -0000	1.20
+++ alsa-lib/src/instr/iwffff.c	14 Nov 2002 01:20:03 -0000
@@ -39,8 +39,8 @@
 
 #ifndef DOC_HIDDEN
 
-#define IW_RAM_FILE		"/proc/asound/%i/gus-ram-%i"
-#define IW_ROM_FILE		"/proc/asound/%i/gus-rom-%i"
+#define IW_RAM_FILE		"/proc/asound/card%i/gus-ram-%i"
+#define IW_ROM_FILE		"/proc/asound/card%i/gus-rom-%i"
 
 #undef IW_ROM_DEBUG
 
@@ -208,6 +208,10 @@
 		close(fd);
 		return -EIO;
 	}
+	if (lseek(fd, IWFFFF_ROM_HDR_SIZE, SEEK_SET) < 0) {
+	        close(fd);
+		return -errno;
+	}
 	return fd;
 }
 
@@ -276,7 +280,10 @@
  * \param card card number
  * \param bank ROM bank number (0-3)
  * \param file ROM file number
- * \return 0 on success otherwise a negative error code
+ * \return 0 on success otherwise a negative \c errno code
+ *
+ * Opens \a file in \a bank in the ROM image of card \a card, and
+ * writes a handle pointer into \a *handle. 
  */
 int snd_instr_iwffff_open_rom(snd_iwffff_handle_t **handle, int card, int bank, int file)
 {
@@ -291,7 +298,7 @@
 	*handle = NULL;
 	idx = 0;
 	if (bank > 3 || file > 255)
-		return -1; 
+		return -ENOENT;
 	fd = iwffff_get_rom_header(card, bank, &header);
 	if (fd < 0)
 		return fd;


-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
