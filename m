From: Christian Esken <c.esken@cityweb.de>
Subject: cs464xx: "Unexpected hw_pointer value"
Date: Tue, 11 Feb 2003 23:48:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302112348.36330.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I have tons of  "Unexpected hw_pointer value" messages when trying to play DVD's using xine.
The notable effect is that DVD audio (and video) playback is interrupted every few seconds for
perhaps 100ms.

Is this more a driver issue (bug) or a hardware fault?!?

Feb 11 23:37:39 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -496, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:41 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -256, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:45 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -448, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:45 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -496, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:47 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -240, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:47 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:47 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -224, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:48 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -336, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:49 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -288, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:49 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -368, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:50 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
Feb 11 23:37:50 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -256, max jitter = 8192): wrong interrupt acknowledge?

Chris


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
