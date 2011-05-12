From: hong zhang <henryzhang62@yahoo.com>
Subject: plughw and hw
Date: Thu, 12 May 2011 15:57:44 -0700 (PDT)
Message-ID: <833657.37526.qm@web161706.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm20.bullet.mail.bf1.yahoo.com (nm20.bullet.mail.bf1.yahoo.com
	[98.139.212.179])
	by alsa0.perex.cz (Postfix) with SMTP id 126EA10382C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 00:57:46 +0200 (CEST)
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

Takashi,

Last e-mail, you mention do not use plughw but hw. I compare both of them. And wonder which way is correct to capture multiple pins.

my HDMI has 4 pins

1. HW failed with "-c 8"
# arecord -f dat -d 5 -D hw:0,1  -c 8 05-12-new-hw-3pins.wav
Recording WAVE '05-12-new-hw-3pins.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Channels 8
arecord: set_params:1059: Channels count non available

2. HW collect data for all 4 pins without "-c 8"

3. plughw with "-c 8" but only first pin has data inside 2 channels. The rest pins collect 0 data.

4. plughw collects data for all pins without "-c 8"

why "-c 8" would not work right?

Thanks.

---henry
