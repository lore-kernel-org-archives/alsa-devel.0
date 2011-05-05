From: hong zhang <henryzhang62@yahoo.com>
Subject: multi channels input and single channel out
Date: Thu, 5 May 2011 16:47:55 -0700 (PDT)
Message-ID: <190162.6375.qm@web161716.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm12.bullet.mail.bf1.yahoo.com (nm12.bullet.mail.bf1.yahoo.com
	[98.139.212.171]) by alsa0.perex.cz (Postfix) with SMTP id B3D8424133
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 01:47:57 +0200 (CEST)
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

I have 8 channels of hdmi input and one channel output on my board.
When arecord -f dat hdmi-rx.wav to store 8 channels data, aplay -f dat hdmi-rx.wav releases noise.

Ia there any way arecord stores each channel data to 8 different files?
Or I have to do beam forming to sort 8 channels out by custom application?

Thanks.

---henry
