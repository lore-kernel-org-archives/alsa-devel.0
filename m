From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: Audigy 24 bits?
Date: Mon, 8 Nov 2004 07:30:30 -0300
Message-ID: <200411080730.30688.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi! I'm using an audigy card. I can't open it for capture nor with a buffer size
of less than 384

>>bits<< 
sorry.... frames, I guess it's time to go to bed

neither with a 24 bits format. I'm not sure about the
first restriction but audigy are 24 bits cards, aren't they? This is the
ouput from snd_pcm_hw_params_dump for a capture stream:

ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: [16 32]
CHANNELS: [1 2]
RATE: [8000 48000]
PERIOD_TIME: [8000 2048000]
PERIOD_SIZE: [384 16384]
PERIOD_BYTES: [768 65536]
PERIODS: 2
BUFFER_TIME: [16000 4096000]
BUFFER_SIZE: [768 32768]
BUFFER_BYTES: [1536 65536]
TICK_TIME: 1000

Thank you in advance,
Carlos.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
