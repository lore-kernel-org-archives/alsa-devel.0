From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Digital sound card conventions
Date: Fri, 3 Jan 2003 21:33:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301032118550.500-100000@pnote.perex-int.cz>
References: <200301032044.04034.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA07089
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 21:35:07 +0100
In-Reply-To: <200301032044.04034.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Jan 2003, Anders Torger wrote:

> I'm doing a maintenance update on the rme96 driver, and I wonder if 
> there are any conventions to follow in the driver concerning digital 
> sound cards.
> 
> The specific questions are how to handle sample rates and sound formats 
> on the input.
> 
> The sound card supports several sample rates and formats. What should 
> happen if the user tries to open the input with 48000 kHz ADAT, but the 
> format is actually 44100 kHz and SPDIF? I can allow it if I want to, 
> the user will get data, but at 48000 kHz of course.
> 
> What should happen when there is no input signal at all? The hardware 
> supports opening the input, but should I do so in the driver?
> 
> The signal can of course change in runtime as well...
> 
> I'm thinking of allowing it all, but I don't know if that is the right 
> way to go.

This part of PCM API has not been discussed. I think that we should follow
the most easy way: It is - allow only sample rate given by application, if
the master clock is using another sample rate - in trigger() callback -
driver will fail. Also it will fail, when sample rate is changed during
operation. We probably need to add a new PCM state -
SNDRV_PCM_STATE_STREAM_CHANGED (equal to DRAINING, but informative for
applications). The notification of master clock / sample rate (or other
parameter) changes should be implemented using the control API.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
