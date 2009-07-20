From: Daniel Mack <daniel@caiaq.de>
Subject: Re: New Audio Driver Design
Date: Mon, 20 Jul 2009 08:56:39 +0200
Message-ID: <20090720065639.GA19257@buzzloop.caiaq.de>
References: <1b68c6790907132152pbfc1995k3be854627cb77f3e@mail.gmail.com>
	<20090715202208.GA13236@buzzloop.caiaq.de>
	<1b68c6790907151713y21148275t1768dbb5c6761c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1759110380A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 08:56:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790907151713y21148275t1768dbb5c6761c43@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 09:13:28AM +0900, jassi brar wrote:
> On Thu, Jul 16, 2009 at 5:22 AM, Daniel Mack <daniel@caiaq.de> wrote:
> > Are these decoder instruction something you need to do at runtime? Or
> > would it suffice to provide them once when the driver is probed?
> 
> The decoder insn, params atleast, depend upon the mp3 file i want the dsp to
> decode and play.
> So, let us assume, i have to load decoder insns and params into the dsp for
> every mp3 file playback.

Then the alsa control API seems appropriate. Unless there is any other
interface for that specific purpose I'm not aware of.

> Also, by what interface name(like I2S/PCM/AC97) shud my driver get encoded
> mp3 data from my mp3-player and then decode that mp3 data by dsp and play
> the output pcm stream?
> I am afraid i must bypass/hack ALSA stack to directly get mp3 data from
> user-space. Am i right?

Have a look at include/sound/pcm.h - there are more formats defined than
just linear PCM, and I think SNDRV_PCM_FMTBIT_MPEG could be something
you can use. But I'm not sure and never used something like that before,
so maybe anyone else can elaborate more?

Daniel
