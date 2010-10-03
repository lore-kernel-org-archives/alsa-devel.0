From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
	dropping samples
Date: Sun, 3 Oct 2010 12:02:39 +0200
Message-ID: <20101003100239.GW7159@buzzloop.caiaq.de>
References: <4C9DC7A1.8050001@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BCEB5103820
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 12:02:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C9DC7A1.8050001@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 25, 2010 at 11:57:53AM +0200, Felix Homann wrote:
> in that past months I've been trying get the Fast Track Ultra
> devices working properly in Alsa. We've had lots of progress, most
> of the code has moved to Alsa git and today I've even posted a patch
> for getting mixer support for these devices.
> 
> Now, I need to get some expert's advice: The devices seem to drop
> samples or frames. Here's a report I've got today on the M-Audio
> forum:
> 
> "I've got a subtle problem to report: I think audio playback is dropping
> sample frames. To hear the problem, open Audacity at 48 kHz and play
> a 10-kHz. sine wave. When I do that I hear a regular clicking sound, about
> four clicks a second. I've tried recording the output and if I'm
> seeing correctly,
> exactly one sample frame in every 13312 (13x1024) is being dropped
> on output.

How is this device clocked? It could be the PLL can't get a valid link
to its clock source and hence "jumps" once in awhile to compensate the
drift. Is there any possibility to sync the device to some sort o
digital input?

If the clicks you hear are very regular, it could also be that some
kind of buffer boundary is not handled properly. Do you have access to
an USB hardware analyzer to check whether the dropout is in fact part of
the USB data stream?

Daniel
