From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 16:38:25 +0200
Message-ID: <20080613143825.GD21255@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<48524882.6050606@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 788AC1037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:38:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48524882.6050606@superbug.co.uk>
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

On Fri, 13.06.08 11:14, James Courtier-Dutton (James@superbug.co.uk) wrote:

> > I would prefer to extend the current API than to change meaning of hw_ptr 
> > to handle extra latencies.

> I would prefer the definition of snd_pcm_delay() to be:
> Before the next sample is written to the buffer, snd_pcm_delay() returns 
> the expect time delay, in frames, indicating the time the next sample 
> will reach the speakers.

This is how I always understood the API. 

OTOH I actually can understand the WINE folks, that they want to have
an API that can be used to query how much of what has already been
written is still unplayed. Why? because snd_pcm_delay() in your
definition would return the time in samples *in the sound card time
domain*. To emulate what they need from this value is quite hard,
because you'd need to deal with deviating system/audio clocks. It's
pain.

(And that's why I'd love to see that much more generic
snd_pcm_get_timing() call implemented, which supports all of these
timing parameters)

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
