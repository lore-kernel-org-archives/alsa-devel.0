From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Fri, 19 Jun 2009 17:37:44 +0100
Message-ID: <20090619163743.GA7861@sirena.org.uk>
References: <s5hk538ejj4.wl%tiwai@suse.de>
	<20090619095322.GC5270@sirena.org.uk>
	<s5h1vpgilhq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8501224574
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 18:37:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1vpgilhq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 12:08:49PM +0200, Takashi Iwai wrote:

> Sorry, my wording was unclear.  Let me clarify: the input jack API is
> there and used as is now.  What I meant as "supersedes" is that the
> code to create and handle the input jack instances in HD-audio driver
> is generalized to one and used together with the control API.

Ah, OK - in that case it sounds like a great idea.  Normally superceding
something implies replacing it (so ALSA supercedes OSS).

> > > For example, you'll have "Jack HP-Out" (or a bit more verbose like
> > > "Jack HP-Out at Ext Rear") control via control API as well as other
> > > mixer controls.  This can notify when a jack is plugged/unplugged.

> > Including the colours (where reported) is often very helpful for
> > figuring out what's what.  The pictures manufacturers seem fond of using
> > for describing the jack functions aren't always models of clarity to the
> > general user.

> Yes, HD-audio spec gives such information, too.

It was HDA that I was thinking about.

> However, the verbose information like a color doesn't fit into the id
> string.  A better option would be through the additional TLV like dB
> scale.  I just considered but didn't write up yet.

Yeah, so long as the information is there it doesn't really matter how
it gets there.
