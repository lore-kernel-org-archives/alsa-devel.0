From: "Cosmin Humeniuc" <cosmin@mandrivausers.ro>
Subject: How to change the sound volume?
Date: Tue, 5 Feb 2008 09:21:34 +0200
Message-ID: <d067a0840802042321g2321b4cfq1445c444b697dcb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 394A924526
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 08:21:36 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so3518571pyg.36
	for <alsa-devel@alsa-project.org>; Mon, 04 Feb 2008 23:21:34 -0800 (PST)
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

Hi,

How would a simple alsa-based sound player change the playback volume?
I've been looking into the mixer interface, but there's no connection
to snd_pcm_t*, so I'm not sure this is what I need to use.
I only want to change the sound volume of my player, without altering
the sound streams of the other applications.

Thanks,

Cosmin
