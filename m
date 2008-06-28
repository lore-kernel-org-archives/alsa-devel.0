From: Spike <spike@spykes.net>
Subject: Re: emu20k1 in 1.0.17?
Date: Fri, 27 Jun 2008 20:49:37 -0400
Message-ID: <20080627204937.0d5b0e60@darius>
References: <485CBD5A.6070305@charter.net>
	<s5h1w2l8qjr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 5184B2452D
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jun 2008 02:49:38 +0200 (CEST)
In-Reply-To: <s5h1w2l8qjr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, daedra <daedra@charter.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Jun 2008 17:47:36 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 21 Jun 2008 01:35:38 -0700,
> daedra wrote:
> > 
> > I was just wondering if there is a chance of the emu20k1 driver making 
> > it's way into 1.0.17?
> 
> Very unlikely...
> 
> CA0110 (HD-audio port) would be easy to support.  I already have a
> test patch on my unstable git tree.  But the real DSP seems hard, and
> I have no spec, too.  James could comment on this more.
> 

So James had the specs for the 20K1 for over a month now,
and there hasn't been any news for equally as long. I assume this
datasheet has an NDA attached, but James hasn't made any mention of
that.

So which is it? You have the specs, Creative themselves state this, so
is the writing of this driver going to be a 1 man job? It would explain
the delay.

If the specs were public, we'd probably have a driver by now, but
nobody has a clue if they're in NDA or not, as James wont talk about it.

Creative also states that their own driver will be all source by the
end of this year, so maybe James has no intention on reinventing the
wheel. Maybe he is behind rewriting this driver to open source, who
knows. Nobody knows a darn thing.

Bren
