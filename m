From: hong zhang <henryzhang62@yahoo.com>
Subject: OMAP4 DMIC only works on 2 channels but 4 or 6 channels
Date: Fri, 10 Jun 2011 15:16:56 -0700 (PDT)
Message-ID: <419980.39764.qm@web161716.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm24.bullet.mail.bf1.yahoo.com (nm24.bullet.mail.bf1.yahoo.com
	[98.139.212.183]) by alsa0.perex.cz (Postfix) with SMTP id 15DF2243A9
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 00:16:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Liam,

OMAP4 DMIC only works on 2 channels but 4 or 6 channels by means of arecord and ABE diagram.

1. "arecord -f dat -c 4 plughw:0,0 dmic-4.wav" returns

   Recording WAVE 'dmic-4.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Channe[  929.988220] omap-dmic-dai omap-dmic-dai: is
ls 4
[  929.996002] asoc: interface omap-dmic-abe-dai-0 hw params failed
[  930.002563]  SDP4430 Media: omap_abe_dai_hw_params: backend hw_params failed -22
[  930.011016] asoc: interface MultiMedia1 hw params failed
arecord: set_params:1116: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 64
CHANNELS: 4
RATE: 48000
PERIOD_TIME: 42625
PERIOD_SIZE: 2046
PERIOD_BYTES: 16368
PERIODS: 4
BUFFER_TIME: 170500
BUFFER_SIZE: 8184
BUFFER_BYTES: 65472
TICK_TIME: 0

2. "arecord -f dat -c 2 plughw:0,0 dmic-4.wav" 
   collects wrong data, no voice is capture in dmic-4.wav. 
   if following is set.
   amixer cset numid=58 4
   amixer cset numid=59 3
   amixer cset numid=60 2
   amixer cset numid=61 1

item 1 indicates DMIC refuses to take more than 2 channels using arecord.
item 2 indicates DMIC capture no voice data if 2 DMIC pins (4 channels)
       are enabled and arecord using 2 channels. 

amixer does not handle any channel number. And ABE does not overwrite number of channels set by arecord.

Do you think it is bug?

Thanks.

---henry
