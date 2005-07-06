From: Lee Revell <rlrevell@joe-job.com>
Subject: memory leaks
Date: Tue, 05 Jul 2005 22:52:27 -0400
Message-ID: <1120618347.5803.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

WHen reloading ALSA modules I got this message:

ALSA sound/core/memory.c:71: Not freed snd_alloc_kmalloc = 1728
ALSA sound/core/memory.c:80: kmalloc(164) from dc8506f9 not freed
ALSA sound/core/memory.c:80: kmalloc(268) from dc850606 not freed
ALSA sound/core/memory.c:80: kmalloc(164) from dc8506f9 not freed
ALSA sound/core/memory.c:80: kmalloc(268) from dc850606 not freed
ALSA sound/core/memory.c:80: kmalloc(164) from dc8506f9 not freed
ALSA sound/core/memory.c:80: kmalloc(268) from dc850606 not freed
ALSA sound/core/memory.c:80: kmalloc(164) from dc8506f9 not freed
ALSA sound/core/memory.c:80: kmalloc(268) from dc850606 not freed

These are the closest symbols:

dc850590 t snd_hwdep_ioctl      [snd_hwdep]
dc850630 t snd_hwdep_mmap       [snd_hwdep]
dc850660 t snd_hwdep_control_ioctl      [snd_hwdep]

AFAICT this means the leaks are in snd_hwdep_ioctl and control_ioctl.

Lee




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
