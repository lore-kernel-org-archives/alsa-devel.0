From: komputes <komputes@gmail.com>
Subject: Playback sound is only audible starting at 50% on Dell
 Inspiron 1420 (Ubuntu 32-bit)
Date: Tue, 02 Jun 2009 10:16:47 -0400
Message-ID: <4A25344F.5060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 400932454F
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 16:16:53 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so4486868qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 07:16:51 -0700 (PDT)
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

Hello ALSA Developers,

I would like to know if anyone can help me correct the following issue.

Playback sound is only audible starting at 50% on Dell Inspiron 1420
running Ubuntu 9.04 Desktop x86. This is true with 9.04, 8.10, 8.04 (all
x86) but does not affect Ubuntu 9.04 AMD64 on which sound is audible at
~4%. Both of these volume levels refer to the "Master" level, all other
playback levels are at 100% (even the ones that are invisible/disabled
by default).

I hang out on #alsa where I was proposed to start alsa with the options
"options snd-hda-intel model=dell-3stack" then "options snd-hda-intel
model=3stack" none of which corrected this 50% volume issue.

This issue as well as all technical details can be found here (includes
alsa-info output):
https://bugs.edge.launchpad.net/ubuntu/+source/alsa-driver/+bug/382488

Thank you for your time,

-komputes
