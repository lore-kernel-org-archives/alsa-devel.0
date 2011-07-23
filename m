From: hong zhang <henryzhang62@yahoo.com>
Subject: ABE routing table without TWL6040
Date: Fri, 22 Jul 2011 17:40:04 -0700 (PDT)
Message-ID: <1311381604.15805.YahooMailClassic@web161706.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm9.bullet.mail.bf1.yahoo.com (nm9.bullet.mail.bf1.yahoo.com
	[98.139.212.168])
	by alsa0.perex.cz (Postfix) with SMTP id 5B27B103809
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 02:40:06 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

List,

My custom OMAP4 board does not have TWL6040 device. What I do is
1. comment out TWL6040 in arch/arm/mach-omap2/Kconfig
2. comment out twl6040 inside sdp4430_dai[] at sound/soc/omap/sdp4430.c

I find ABE routing table is no longer useful because of changes in steps 1 and 2.

run "arecord -f S16_LE -r 48000 -c 2 -D plughw:0,0 try.wav" returns error:

Recording WAVE 'try.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
try.wav: No such file or directory

dmesg shows dmic_trigger is called.

1. Could anyone please give me hint where I should look into?
2. Try Legacy DMIC to turn off ABE by comment out ABE in 
   sound/soc/omap/kconfig but "No Sound card Found" when boot.

Thanks.


---henry
