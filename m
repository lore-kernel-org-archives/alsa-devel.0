From: Matthew Hodgson <matthew@mxtelecom.com>
Subject: oss-redir/libaoss doesn't set blocked IO correctly [PATCH]
Date: Sat, 19 Mar 2005 14:52:48 +0000
Message-ID: <423C3CC0.80307@mxtelecom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070400040505020308010903"
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.
--------------070400040505020308010903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm investigating switching videolan's OSS-style audio-capture (used to 
complement streaming from a v4l source) to use the alsa-oss oss-redir 
abstraction layer.  Whilst writing the patch, I came up against the 
quirk that

i_fd = oss_pcm_open(devname, O_RDONLY | O_NONBLOCK)

doesn't return a non-blocking file descriptor.  This is a bit of a 
showstopper, as vlc relies on the fd being nonblocking in order for the 
thread to yield to allow interleaved video capture to occur.

The problem appears to be a typo in alsa-oss/alsa/pcm.c:oss_dsp_open(), 
where the mode parameter rather than the oflags parameter is checked for 
the O_NONBLOCK flag.  I've included a trivial patch to fix it.

cheers;

M.

-- 
______________________________________________________________
Matthew Hodgson   matthew@mxtelecom.com   Tel: +44 845 6667778
                 Systems Analyst, MX Telecom Ltd.

--------------070400040505020308010903
Content-Type: text/plain;
 name="alsa-oss-nbiofix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-oss-nbiofix.patch"

Index: pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-oss/alsa/pcm.c,v
retrieving revision 1.19
diff -u -r1.19 pcm.c
--- pcm.c       27 Dec 2004 19:25:47 -0000      1.19
+++ pcm.c       19 Mar 2005 14:43:04 -0000
@@ -534,7 +534,7 @@
                errno = ENOENT;
                return -1;
        }
-       if (mode & O_NONBLOCK)
+       if (oflag & O_NONBLOCK)
                pcm_mode = SND_PCM_NONBLOCK;
        switch (oflag & O_ACCMODE) {
        case O_RDONLY:

--------------070400040505020308010903--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
