From: hong zhang <henryzhang62@yahoo.com>
Subject: asoc: no valid backend routes for PCM: SDP4430 Media
Date: Mon, 6 Jun 2011 17:13:07 -0700 (PDT)
Message-ID: <76445.36914.qm@web161713.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm2-vm0.bullet.mail.bf1.yahoo.com
	(nm2-vm0.bullet.mail.bf1.yahoo.com [98.139.213.127])
	by alsa0.perex.cz (Postfix) with SMTP id E5941103885
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 02:13:09 +0200 (CEST)
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

After capturing data from DMIC on OMAP4 blaze board with kernel 2.6.38 and save wav data to 38.wav.

But aplay complains "no valid backend routes". See following,

$aplay -f dat 38.wav 
[  157.167724] asoc: no valid backend routes for PCM: SDP4430 Media
aplay: main:654: audio open error: Invalid argument

$ uname -a
Linux ubuntu 2.6.38.4+ #58 SMP PREEMPT Fri Jun 3 09:44:19 PDT 2011 armv7l GNU/Linux

Does ALSA add new functionality of backend?


Thanks.

---henry
