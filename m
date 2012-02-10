From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 10 Feb 2012 15:50:03 +0000
Message-ID: <20120210155003.GA11701@sirena.org.uk>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FBF82441B
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 16:50:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F3516E4.2080706@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 10, 2012 at 02:08:52PM +0100, David Henningsson wrote:
> On 02/10/2012 11:55 AM, Takashi Iwai wrote:
> > David Henningsson wrote:

> >> I guess it could be easier to parse if we avoid spaces in names,

> > Exactly, it was the reason.

> Given that the normal desktop user does not usually look at these values 
> these days, I'd say being parser friendly weighs heavier than being 
> "normal English".

Not all the world is desktop.

> > OTOH, we can take an optional directional suffix, i.e.
> > "[location] base [direction] [channel]", too.  For example, base can
> > be "Video" or "Line", and direction can be "Out" or "In".

> > I'd like to hear rather comments from others.

> I think both naming schemes are good, and I'm not too worried about them 
> being too verbose. If we run into names being longer than the string 
> length we could back off and drop the location, I guess.

It's a complete pain for actually working with them and doing
development - it renders badly in UIs (think about alsamixer for
example, or people looking at things on 80 column terminals) and isn't
friendly to people typing things in.

> If we extend the thought about applying this scheme for mixer control 
> names as well, we might run into controls that apply to two outputs but 
> not the third, and then the complexity will increase, like "Front 
> HP,Line-Out Playback Switch". (And what if the Headphone is located on 
> the Front side and the Line-Out is on the back, etc) But then we run 
> into the entire story of exposing a graph instead, I guess. :-/

There's no solution except to expose a graph - modern devices are going
to have sufficiently flexible routing that most of the controls have no
association with a particular output (or input for that matter).  
