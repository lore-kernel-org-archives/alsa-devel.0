From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: mmap ops in snd_pcm_ops
Date: Fri, 29 Jul 2011 18:31:23 +0800
Message-ID: <CAHG8p1DBT=M9S_31DravZTensR26fYvAnr+FX=DLBfLOmhWcqA@mail.gmail.com>
References: <CAHG8p1CCmtTRtM5i+Fg3-5+MDCEN7B-rXS=zKDCBrakoR4Ao5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id CC258244DC
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 12:31:23 +0200 (CEST)
Received: by qwf7 with SMTP id 7so1919946qwf.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2011 03:31:23 -0700 (PDT)
In-Reply-To: <CAHG8p1CCmtTRtM5i+Fg3-5+MDCEN7B-rXS=zKDCBrakoR4Ao5A@mail.gmail.com>
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

Hi all,

I found there is a memory leak about 128K every time in linux-2.6.34,
but it doesn't exist in linux-3.0.
If I use mmap ops in driver the bug will come out, while use copy ops
no memory leak.
I tested with aplay to play a wav file.
Because there is a lot of changes in ALSA between 2.6.34 and 3.0, so
can anyone familiar
with the change history tell me which patch has solved this bug?
Thanks in advance.

Scott
