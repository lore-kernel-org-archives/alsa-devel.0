From: Clemens Ladisch <clemens@ladisch.de>
Subject: [Bug] MODULE_PARM_SYNTAX for snd_maximum_substreams
Date: Tue, 23 Jul 2002 18:50:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3D8949.FE1C1687@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

alsa-kernel/core/pcm_memory.c:

static int snd_maximum_substreams = 4;
MODULE_PARM(snd_maximum_substreams, "i");
MODULE_PARM_DESC(snd_maximum_substreams, "Maximum substreams with preallocated DMA memory.");
MODULE_PARM_SYNTAX(snd_maximum_substreams, SNDRV_BOOLEAN_TRUE_DESC);

This shouldn't be BOOLEAN.


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
