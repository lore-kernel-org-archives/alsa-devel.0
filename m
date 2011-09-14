From: <john@johnandjuliet.com>
Subject: =?utf-8?q?snd=5Fpcm=5Fpause_kills_plaback_handle_on_?=
	=?utf-8?q?OMAP4?=
Date: Wed, 14 Sep 2011 11:13:22 -0700
Message-ID: <20110914111322.98fd97237cc930a62b888eb89e535f85.3e53ce80b3.wbe@email12.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plwbeout12-05.prod.phx3.secureserver.net
	(p3plsmtp12-05-2.prod.phx3.secureserver.net [173.201.192.62])
	by alsa0.perex.cz (Postfix) with SMTP id 6DDD710380B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 20:14:20 +0200 (CEST)
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

I'm trying to control the McBSP2 that is used for the modem in an
android environment (BLAZE OMAP4)

What I am trying to do is control the audio paths for capture and
playback seperatly like in a SIMPLEX (half duplex) instead of full
DUPLEX mode audio .. I also want to stop the audio without total
shutdown of the audio system.

>From what I can see that would be to call snd_pcm_pause(handle,bool)

But here is what happens.  With the handle forthe plaback path
everything works OK... But if I call that then the capture path stops
working... even if I try to turn on (unpause) both paths.

This implies some sort of bug in the omap soc driver?

Any help on how to figure this out?

Thnkx

JBP
