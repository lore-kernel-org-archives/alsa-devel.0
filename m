From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: iBook PMac Tumber, no sound output
Date: Sun, 25 May 2003 14:58:37 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030525145837.7410b0ce.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi all,

I've just compiled and installed the following:

	alsa-driver-0.9.3c
	alsa-lib-0.9.3
	alsa-utils-0.9.3

The driver was compiled with gcc-2.95 (to match the kernel) and the
other two with gcc-3.2.

    erikd@miles > cat /proc/asound/cards 
    0 [Tumbler        ]: PMac Tumbler - PowerMac Tumbler
                         PowerMac Tumbler (Dev 16) Sub-frame 0

Everything seems to be working but I get no sound. I have tried using
alsamixer, alsamixergui and amixer to set PCM and Master volumes to a 
sensible setting. Still no sound, not do I get anything that even looks
like and error message.

Anybody have an idea of whats going on?

Cheers,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
The mouse has been moved. Windows must be restarted for the change
to take effect. Reboot now?


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
