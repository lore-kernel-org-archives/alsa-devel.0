From: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Subject: lack or LFS support for fopen in alsa-oss
Date: Thu, 15 Feb 2007 16:40:17 +0200
Message-ID: <45D470D1.2060007@gmail.com>
Reply-To: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070000050101080209070308"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070000050101080209070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

fopen64 is overloaded to call original fopen, not fopen64. This makes 
certain applications fail (vmware working with large disk images).

Attached patch fixes the problem and also makes open64 support more 
straightforward.

Ref: Filed as bug 2891 in bug tracking system.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------070000050101080209070308
Content-Type: text/x-patch;
 name="alsa-oss-lfs-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-oss-lfs-fix.diff"

--- alsa-oss.c.orig	2006-08-22 21:43:53.000000000 +0300
+++ alsa-oss.c	2007-02-15 15:43:00.000000000 +0200
@@ -69,6 +69,7 @@
 static int (*_select)(int n, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);
 static int (*_poll)(struct pollfd *ufds, unsigned int nfds, int timeout);
 static int (*_open)(const char *file, int oflag, ...);
+static int (*_open64)(const char *file, int oflag, ...);
 static int (*_close)(int fd);
 static ssize_t (*_write)(int fd, const void *buf, size_t n);
 static ssize_t (*_read)(int fd, void *buf, size_t n);
@@ -78,6 +79,7 @@
 static int (*_munmap)(void* addr, size_t len);
 
 static FILE *(*_fopen)(const char *path, const char *mode);
+static FILE *(*_fopen64)(const char *path, const char *mode);
 
 typedef struct ops {
 	int (*close)(int fd);
@@ -242,58 +244,70 @@
 	},
 };
 
-int open(const char *file, int oflag, ...)
-{
-	va_list args;
-	mode_t mode = 0;
-	int fd;
-
-	if (!initialized)
-		initialize();
-
-	if (oflag & O_CREAT) {
-		va_start(args, oflag);
-		mode = va_arg(args, mode_t);
-		va_end(args);
-	}
-	if (is_dsp_device(file)) {
-		fd = lib_oss_pcm_open(file, oflag);
-		if (fd >= 0) {
-			int nfds;
-			fds[fd] = calloc(sizeof(fd_t), 1);
-			if (fds[fd] == NULL) {
-				ops[FD_OSS_DSP].close(fd);
-				errno = ENOMEM;
-				return -1;
-			}
-			fds[fd]->class = FD_OSS_DSP;
-			fds[fd]->oflags = oflag;
-			nfds = lib_oss_pcm_poll_fds(fd);
-			if (nfds > 0) {
-				fds[fd]->poll_fds = nfds;
-				poll_fds_add += nfds;
-			}
-		}
-	} else if (is_mixer_device(file)) {
-		fd = lib_oss_mixer_open(file, oflag);
-		if (fd >= 0) {
-			fds[fd] = calloc(sizeof(fd_t), 1);
-			if (fds[fd] == NULL) {
-				ops[FD_OSS_MIXER].close(fd);
-				errno = ENOMEM;
-				return -1;
-			}
-			fds[fd]->class = FD_OSS_MIXER;
-			fds[fd]->oflags = oflag;
-		}
-	} else {
-		fd = _open(file, oflag, mode);
-		if (fd >= 0)
-			assert(fds[fd] == NULL);
-	}
-	return fd;
+#define DSP_OPEN() \
+{ \
+	fd = lib_oss_pcm_open(file, oflag); \
+	if (fd >= 0) { \
+		int nfds; \
+		fds[fd] = calloc(sizeof(fd_t), 1); \
+		if (fds[fd] == NULL) { \
+			ops[FD_OSS_DSP].close(fd); \
+			errno = ENOMEM; \
+			return -1; \
+		} \
+		fds[fd]->class = FD_OSS_DSP; \
+		fds[fd]->oflags = oflag; \
+		nfds = lib_oss_pcm_poll_fds(fd); \
+		if (nfds > 0) { \
+			fds[fd]->poll_fds = nfds; \
+			poll_fds_add += nfds; \
+		} \
+	} \
+}
+
+#define MIXER_OPEN() \
+{ \
+	fd = lib_oss_mixer_open(file, oflag); \
+	if (fd >= 0) { \
+		fds[fd] = calloc(sizeof(fd_t), 1); \
+		if (fds[fd] == NULL) { \
+			ops[FD_OSS_MIXER].close(fd); \
+			errno = ENOMEM; \
+			return -1; \
+		} \
+		fds[fd]->class = FD_OSS_MIXER; \
+		fds[fd]->oflags = oflag; \
+	} \
+} 
+
+#define DECL_OPEN(name, callback) \
+int name(const char *file, int oflag, ...) \
+{ \
+	va_list args; \
+	mode_t mode = 0; \
+	int fd; \
+	if (!initialized) \
+		initialize(); \
+	if (oflag & O_CREAT) { \
+		va_start(args, oflag); \
+		mode = va_arg(args, mode_t); \
+		va_end(args); \
+	} \
+	if (is_dsp_device(file)) \
+		DSP_OPEN() \
+	else if (is_mixer_device(file)) \
+		MIXER_OPEN() \
+	else { \
+		fd = callback(file, oflag, mode); \
+		if (fd >= 0) \
+			assert(fds[fd] == NULL); \
+	} \
+	return fd; \
 }
 
+DECL_OPEN(open, _open)
+DECL_OPEN(open64, _open64)
+
 int close(int fd)
 {
 	if (!initialized)
@@ -730,7 +744,7 @@
 		initialize(); 
 
 	if (!is_dsp_device(path))
-		return _fopen(path, mode);
+		return _fopen64(path, mode);
 
 	return fake_fopen(path, mode, O_LARGEFILE);
 }
@@ -766,19 +780,6 @@
 }
 #endif
 
-int open64(const char *file, int oflag, ...)
-{
-	va_list args;
-	mode_t mode = 0;
-
-	if (oflag & O_CREAT) {
-		va_start(args, oflag);
-		mode = va_arg(args, mode_t);
-		va_end(args);
-	}
-	return open(file, oflag | O_LARGEFILE, mode);
-}
-
 # define strong_alias(name, aliasname) \
   extern __typeof (name) aliasname __attribute__ ((alias (#name)));
 
@@ -809,6 +810,7 @@
 	if (!fds)
 		exit(1);
 	_open = dlsym(RTLD_NEXT, "open");
+	_open64 = dlsym(RTLD_NEXT, "open64");
 	_close = dlsym(RTLD_NEXT, "close");
 	_write = dlsym(RTLD_NEXT, "write");
 	_read = dlsym(RTLD_NEXT, "read");
@@ -819,5 +821,6 @@
 	_select = dlsym(RTLD_NEXT, "select");
 	_poll = dlsym(RTLD_NEXT, "poll");
 	_fopen = dlsym(RTLD_NEXT, "fopen");
+	_fopen64 = dlsym(RTLD_NEXT, "fopen64");
 	initialized = 1;
 }

--------------070000050101080209070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------070000050101080209070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070000050101080209070308--
