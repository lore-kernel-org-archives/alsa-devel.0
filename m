From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: memory leak in mmap ops
Date: Sat, 30 Jul 2011 11:15:41 +0800
Message-ID: <CAHG8p1CQHHi=G6mevNdxDU5h_4NW4tZ+nSO1hnC5K2JX2nT+aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id EB7A22414A
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jul 2011 05:15:42 +0200 (CEST)
Received: by qwf7 with SMTP id 7so2304858qwf.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2011 20:15:42 -0700 (PDT)
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
no memory leak. This driver is based on asoc.
I tested with aplay to play a wav file.
Because there is a lot of changes in ALSA between 2.6.34 and 3.0, so
can anyone who familiar with the change history tell me which patch
has solved this bug?
Thanks in advance.

Scott
