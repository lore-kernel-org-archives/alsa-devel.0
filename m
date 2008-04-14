From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: line6usb in alsa
Date: Mon, 14 Apr 2008 18:39:43 -0400
Message-ID: <17eedd8a0804141539x670e268eld1f93817ad8e3086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id CBDE62463C
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 00:39:44 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 25so2425824wfa.23
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 15:39:43 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

There is a "driver" which I long wanted to be in official alsa: line6usb.
http://www.tanzband-scream.at/line6/

While the code exists, I looked at it and in my opinion it's not ready
for inclusion in alsa. For example, there is some MIDI code which
belongs to userspace but it's in the kernel module.

I have already contacted the maintainer of the project, so we can make
this happen. My question are:
- what "communication" steps do we need to put this code here?
- do we have to put the initial line6usb support in one single patch
or a step by step is preferred?
- once the code is here, how can we improve it or make changes?
- any other trap we could avoid right now? any suggestion of how can
we make this the smoothest way possible?


Thanks a lot!
-- 
Aldrin Martoq
Episodio 002 (Lunes 24 Marzo)!
http://aldrinvideopodcast.podshow.com/
