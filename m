From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: How can you tell if the speaker jack on your
	sound	card has anything plugged into it???
Date: Fri, 25 Apr 2008 23:28:40 +0200
Message-ID: <20080425212839.GA20087@tango.0pointer.de>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk> <87fxt9k5ge.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D2FC247D6
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:28:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87fxt9k5ge.fsf@free.fr>
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

On Fri, 25.04.08 23:08, Robert Jarzmik (rjarzmik@free.fr) wrote:

> 
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > There's currently no standard way of getting this information from user
> > space even where the hardware provides it.
> Isn't the event api switch "SW_HEADPHONE_INSERT" standard ?
> I thought it was designed for such use.
> 
> If I'm not mistaken, the Neo teams handles it that way, as I do for the mio :
>  -> input_report_switch(mioa701_evdev, SW_HEADPHONE_INSERT, val);

AFAIK HDA generally supports Jack Sensing. However
it's not wired up properly on all hardware. And there's no driver support
in the Linux HDA driver to generate an input device for jack
sensing.

But I might be mistaken. Takashi and Jaroslav know the current state
of Jack Sensing on Linux much better.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
