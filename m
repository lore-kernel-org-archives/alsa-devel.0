From: "thomas.luo" <thomas.luo@ieee.org>
Subject: alsa driver problem
Date: Fri, 12 Jan 2007 16:06:10 +0800
Message-ID: <00e101c73622$7e988060$0e96a8c0@Thomas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0579481559=="
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

--===============0579481559==
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
Content-Transfer-Encoding: 7bit

Dear all:
 i meet some problem in using the ALSA in the ARM base SOC. 
the get avail_min return zero!
but it is have value in the debug info.

output from the driver.
Rule 1 [bf00713c]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 2 [bf0072a4]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 3 [bf007240]: FRAME_BITS = [32 32] -> [32 32]
Rule 4 [bf007370]: FRAME_BITS = [32 32] -> [32 32]
Rule 5 [bf007370]: FRAME_BITS = [32 32] -> [32 32]
Rule 6 [bf0072a4]: CHANNELS = [2 2] -> [2 2]
Rule 7 [bf007370]: RATE = [44100 44100] -> [44100 44100]
Rule 8 [bf007370]: RATE = [44100 44100] -> [44100 44100]
Rule 9 [bf0072a4]: PERIODS = [4 4] -> [4 4]
Rule 10 [bf0072a4]: PERIOD_SIZE = [4096 4096] -> [4096 4096]
Rule 11 [bf007370]: PERIOD_SIZE = [4096 4096] -> [4096 4096]
Rule 12 [bf007308]: PERIOD_SIZE = [4096 4096] -> [4096 4096]
Rule 13 [bf007240]: BUFFER_SIZE = [16384 16384] -> [16384 16384]
Rule 14 [bf007370]: BUFFER_SIZE = [16384 16384] -> [16384 16384]
Rule 15 [bf007308]: BUFFER_SIZE = [16384 16384] -> [16384 16384]
Rule 16 [bf007308]: PERIOD_BYTES = [16384 16384] -> [16384 16384]
Rule 17 [bf007308]: BUFFER_BYTES = [65536 65536] -> [65536 65536]
Rule 18 [bf007370]: PERIOD_TIME = (92879 92880) -> (92879 92880)
Rule 19 [bf007370]: BUFFER_TIME = (371519 371520) -> (371519 371520)
Rule 20 [bf033c00]: CHANNELS = [2 2] -> [2 2]
Rule 21 [bf033e74]: RATE = [44100 44100]s->codec_idx:0x0,s->rate_idx:0x0
 -> [44100 44100]
Rule 22 [bf0062ec]: BUFFER_BYTES = [65536 65536] -> [65536 65536]

output form the aplayer.....
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4096
xfer_align: 4096
silence_threshold: 0
silence_size: 0
boundary: 1073741824
aplay: set_params:1013: snd_pcm_sw_params
ALSA lib pcm.c:873:(snd_pcm_sw_params) params->avail_min is 0
aplay: set_params:1017: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 113608
silence_threshold: 0
silence_size: 0
boundary: 1073741824

when i force the avail_min to 4096, the whole system work well.
who can tell me any idea?

Thanks!

Br
Thomas




--===============0579481559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0579481559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0579481559==--
