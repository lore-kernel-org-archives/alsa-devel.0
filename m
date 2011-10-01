From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Event flood on USB disconnect
Date: Sat, 01 Oct 2011 14:19:42 +0530
Message-ID: <1317459007.6559.18.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id AC5B8103810
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Oct 2011 10:48:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks,
We're seeing a problem when disconnecting USB headsets in PulseAudio.
Steps to reproduce are basically: start PulseAudio, plug in USB device,
wait for it to suspend (pcm is closed but mixer is not), disconnect.
Fairly often, this results in PA getting killed because the polling
thread is realtime and exceeds its rlimit. The problem is not limited to
one machine or one USB headset, and I'm running kernel 3.0.4

I'm basically seeing a flood of events on the mixer pollfds (goes as
high as 4+ million of them). As far as I can tell, they all contain
(POLLERR|POLLNVAL). From a preliminary look at the code this seems to be
expected on a card disconnect, but I assume not so often.

I'm going to try to handle this by just stopping PA from listening on
these fds when I get a (POLLERR|POLLNVAL), but it seems to me that this
is a bug in the driver somewhere. Any ideas w.r.t. what might be going
wrong or where I should be looking to debug further?

Cheers,
Arun
