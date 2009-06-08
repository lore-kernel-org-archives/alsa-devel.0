From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: M-Audio Transit: alsamixer shows 100% and -0.5db at
	the same time !?
Date: Mon, 8 Jun 2009 11:13:32 +0200
Message-ID: <d9690f190906080213g5103efd7mf2a9bdd7aeeb131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F8041037F1
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 11:13:33 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1582502ywq.2
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 02:13:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks.

My M-Audio Transit shows at 100% and 0.5db attentuation in alsamixer at the
same time.

See below printout.

What could be the explanation for this behaviour?

THX
\Klaus



amixer -Dhw:0
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 254
  Mono:
  Front Left: Playback 254 [100%] [0.50dB] [on]
  Front Right: Playback 254 [100%] [0.50dB] [on]
