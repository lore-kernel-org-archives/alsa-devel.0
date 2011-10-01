From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Event flood on USB disconnect
Date: Sat, 01 Oct 2011 14:23:39 +0530
Message-ID: <1317459237.6559.20.camel@snowflake>
References: <1317459007.6559.18.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id DE3EE10381A
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Oct 2011 10:52:40 +0200 (CEST)
In-Reply-To: <1317459007.6559.18.camel@snowflake>
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

On Sat, 2011-10-01 at 14:19 +0530, Arun Raghavan wrote:
> Hi folks,
> We're seeing a problem when disconnecting USB headsets in PulseAudio.
> Steps to reproduce are basically: start PulseAudio, plug in USB device,
> wait for it to suspend (pcm is closed but mixer is not), disconnect.
> Fairly often, this results in PA getting killed because the polling
> thread is realtime and exceeds its rlimit. The problem is not limited to

Missed one detail -- I've only seen this happen on the alsa-source
thread, not on alsa-sink, but I've only tested with one device which has
playback as well as capture.

-- Arun
