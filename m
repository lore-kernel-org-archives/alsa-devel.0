From: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Subject: Re: lack or LFS support for fopen in alsa-oss
Date: Mon, 19 Feb 2007 13:53:09 +0200
Message-ID: <45D98FA5.2030408@gmail.com>
References: <45D470D1.2060007@gmail.com>	<s5hire3a2n0.wl%tiwai@suse.de>	<45D83F4B.3040405@gmail.com>
	<s5hsld274zr.wl%tiwai@suse.de>
Reply-To: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020409080905080803020001"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hsld274zr.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020409080905080803020001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Sun, 18 Feb 2007 13:58:03 +0200,
> Constantine Gavrilov wrote:
>   
>> OK. Attached.  Not changed in the bug tracking system as I could not find a way to
>> remove original patch.
>>     
>
> That doesn't matter.
>
>
>   
>> --- alsa/alsa-oss.c.orig	2007-02-18 13:29:08.000000000 +0200
>> +++ alsa/alsa-oss.c	2007-02-18 13:37:45.000000000 +0200
>>     
> (snip)
>   
>> +#define DECL_OPEN(name, callback) \
>> +int name(const char *file, int oflag, ...) \
>> +{ \
>> +	va_list args; \
>> +	mode_t mode = 0; \
>> +	int fd; \
>> +	if (!initialized) \
>> +		initialize(); \
>> +	if (oflag & O_CREAT) { \
>> +		va_start(args, oflag); \
>> +		mode = va_arg(args, mode_t); \
>> +		va_end(args); \
>> +	} \
>> +	if (is_dsp_device(file)) \
>> +		dsp_open_helper(file, oflag); \
>> +	else if (is_mixer_device(file)) \
>> +		mixer_open_helper(file, oflag); \
>>     
>
> Missing returns (or fd = ) here...
>
>
> Takashi
>
>   
You are right. Missing fd = coming from macro -> function conversion. 
Fixed patch attached.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------020409080905080803020001
Content-Type: text/x-patch;
 name="alsa-oss-lfs-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-oss-lfs-fix.diff"

--- alsa/alsa-oss.c.orig	2007-02-18 13:29:08.000000000 +0200
+++ alsa/alsa-oss.c	2007-02-19 13:48:18.000000000 +0200
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
@@ -242,58 +244,74 @@
 	},
 };
 
-int open(const char *file, int oflag, ...)
+static int dsp_open_helper(const char *file, int oflag)
 {
-	va_list args;
-	mode_t mode = 0;
 	int fd;
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
+	fd = lib_oss_pcm_open(file, oflag);
+	if (fd >= 0) {
+		int nfds;
+		fds[fd] = calloc(sizeof(fd_t), 1);
+		if (fds[fd] == NULL) {
+			ops[FD_OSS_DSP].close(fd);
+			errno = ENOMEM;
+			return -1;
 		}
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
+		fds[fd]->class = FD_OSS_DSP;
+		fds[fd]->oflags = oflag;
+		nfds = lib_oss_pcm_poll_fds(fd);
+		if (nfds > 0) {
+			fds[fd]->poll_fds = nfds;
+			poll_fds_add += nfds;
 		}
-	} else {
-		fd = _open(file, oflag, mode);
-		if (fd >= 0)
-			assert(fds[fd] == NULL);
 	}
 	return fd;
 }
 
+static int mixer_open_helper(const char *file, int oflag)
+{
+	int fd;
+	fd = lib_oss_mixer_open(file, oflag);
+	if (fd >= 0) {
+		fds[fd] = calloc(sizeof(fd_t), 1);
+		if (fds[fd] == NULL) {
+			ops[FD_OSS_MIXER].close(fd);
+			errno = ENOMEM;
+			return -1;
+		}
+		fds[fd]->class = FD_OSS_MIXER;
+		fds[fd]->oflags = oflag;
+	}
+	return fd;
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
+		fd = dsp_open_helper(file, oflag); \
+	else if (is_mixer_device(file)) \
+		fd = mixer_open_helper(file, oflag); \
+	else { \
+		fd = callback(file, oflag, mode); \
+		if (fd >= 0) \
+			assert(fds[fd] == NULL); \
+	} \
+	return fd; \
+}
+
+DECL_OPEN(open, _open)
+DECL_OPEN(open64, _open64)
+
 int close(int fd)
 {
 	if (!initialized)
@@ -730,7 +748,7 @@
 		initialize(); 
 
 	if (!is_dsp_device(path))
-		return _fopen(path, mode);
+		return _fopen64(path, mode);
 
 	return fake_fopen(path, mode, O_LARGEFILE);
 }
@@ -766,19 +784,6 @@
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
 
@@ -809,6 +814,7 @@
 	if (!fds)
 		exit(1);
 	_open = dlsym(RTLD_NEXT, "open");
+	_open64 = dlsym(RTLD_NEXT, "open64");
 	_close = dlsym(RTLD_NEXT, "close");
 	_write = dlsym(RTLD_NEXT, "write");
 	_read = dlsym(RTLD_NEXT, "read");
@@ -819,5 +825,6 @@
 	_select = dlsym(RTLD_NEXT, "select");
 	_poll = dlsym(RTLD_NEXT, "poll");
 	_fopen = dlsym(RTLD_NEXT, "fopen");
+	_fopen64 = dlsym(RTLD_NEXT, "fopen64");
 	initialized = 1;
 }

--------------020409080905080803020001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020409080905080803020001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020409080905080803020001--
