From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problems with nonblocking capture every 20ms
Date: Mon, 10 Mar 2008 19:38:50 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803101937360.7942@tm8103.perex-int.cz>
References: <47D55396.3080705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 94B0D245AD
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 19:38:50 +0100 (CET)
In-Reply-To: <47D55396.3080705@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Dohmen <johannes.dohmen@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Mar 2008, Johannes Dohmen wrote:

> Hi there,
> 
> With a sampling rate of 8000 I want to capture every 20ms a chunk (160 
> frames) of data from the soundcard. That works ok, but every ~5 seconds 
> I get a EGAIN from snd_pcm_readi().
> I understand that this is not an error but a notification that the sound
> card is not ready and should be asked again for data later on.
> 
> Probably the easiest way to get rid of the EGAINs would be to use
> blocking IO, which I would prefer, but I have timing restrictions and
> snd_pcm_readi() has no sort of timeout (which I could see at least).

Just use poll() - it's standard unix interface to wait for an event.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
