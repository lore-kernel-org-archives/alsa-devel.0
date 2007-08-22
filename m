From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: aplay giving underruns in non blocking mode
Date: Wed, 22 Aug 2007 21:56:36 +0530
Message-ID: <61445c750708220926p16351ed3gbb1cc4a2df1058c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id E061124469
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 18:26:39 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so243453wag
	for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2007 09:26:38 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
I am tesing my alsa driver for an arm based board. aplay works well when it
is used in blocking mode, but I see
underruns when I switch to non-blocking mode. What could be the reason?

I have tried to remove all latencies in driver by using minimal locking etc,
but it doesn't seem to make any difference.
Also, the audio quality degenerates gradually in non-blocking mode.

-Pharaoh.
