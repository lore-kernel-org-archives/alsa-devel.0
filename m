From: hong zhang <henryzhang62@yahoo.com>
Subject: --separate-channels issues
Date: Tue, 10 May 2011 09:34:40 -0700 (PDT)
Message-ID: <119279.84562.qm@web161712.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm11-vm0.bullet.mail.bf1.yahoo.com
	(nm11-vm0.bullet.mail.bf1.yahoo.com [98.139.213.136])
	by alsa0.perex.cz (Postfix) with SMTP id AAD03244DE
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 18:34:42 +0200 (CEST)
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

When I run following commands with 2 pins inputs.

$ arecord -f S16_LE -r 48000 -c 4 -D plughw:0,1 --separate-channels c1.wav c2.wav c3.wav c4.wav

hd c3.wav and c4.wav returns 0 but c1.wav and c2.wav got right data.
Such as 
$ hd c3.wav 
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
005ad000

Also, I see trigger Rx start command and then stop command immediately.

Any hint to look into?

Thanks.

---henry
