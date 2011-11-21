From: auto30512278@hushmail.com
Subject: No sound on Dell StudioXPS 1340
Date: Mon, 21 Nov 2011 00:56:28 -0300
Message-ID: <20111121035628.5F5956F442@smtp.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp10.hushmail.com (smtp10.hushmail.com [65.39.178.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C3F7324547
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 04:56:32 +0100 (CET)
Received: from smtp10.hushmail.com (localhost.localdomain [127.0.0.1])
	by smtp10.hushmail.com (Postfix) with SMTP id 8778DBF092
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 03:56:29 +0000 (UTC)
Received: from smtp.hushmail.com (w7.hushmail.com [65.39.178.32])
	by smtp10.hushmail.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 03:56:28 +0000 (UTC)
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

Hi, I've this problem from months ago (I think it started with an
ubuntu upgrade), I reinstalled Ubuntu at least 2 times since and I
couldn't get the sound working again.Now I'm on a fresh installation
of xubuntu, and still have the same problem.
Recently I asked for help at #alsa and after a couple of minutes of
troubleshooting with a nice guy without luck, he recommend me to post
the problem here with the link below.
Short story: No sound from internal speakers, neither from headphones
jack (both works fine on win). Applications seems to reproduce the
audio without throwing errors but I never heard a sound. We tried a
lot of thing, I can recall:- Disable pulseaudio (echo "autospawn =
false" > ~/.pulse/client.conf && pactl exit)- I ran speaker-test -c 2
-d plughw0,0, no luck- I see the meters moving on pavucontrol (while
running speaker-test -d pulse -c 2)
http://www.alsa-project.org/db/?f=d9612384067fb86a13668607496e52ebcb90415e
Anyone? It's really annoying :(Thanks 
