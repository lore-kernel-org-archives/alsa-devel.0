From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: pcm_lib.c & pcm_memory.c
Date: Mon, 22 Jul 2002 11:35:40 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020722183540.63433.qmail@web11501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi all,

I would have a few questions regarding buffer mgt:

When is substream->dma_area used for capture or playback? (probably never, as
snd_pcm_lib_malloc_pages() seems to imply that one should only use
substream->runtime->dma_area)

Where should captured audio data be copied into runtime->dma_area? Is it up to
the driver or do capture_copy() and capture_silence() functions take the same
role as for playback?

When does the pointer to the next playback/capture audio period rewind? I
noticed that for more than 2 periods_max, this can happen anytime (eg. after 2,
3, ...) even before we reached the end of the buffer.

Cheers!
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
