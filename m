From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC, SPDIF and AC97
Date: Wed, 28 May 2008 16:15:40 -0400
Message-ID: <9e4733910805281315p3ced192aoddf368d5d201758b@mail.gmail.com>
References: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
	<20080528101430.GB12414@sirena.org.uk>
	<9e4733910805280640nd460258i547c8bc6581b411a@mail.gmail.com>
	<20080528161001.GF12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E7071245D6
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 22:15:42 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id k32so1799837rnd.21
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 13:15:41 -0700 (PDT)
In-Reply-To: <20080528161001.GF12414@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/28/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 28, 2008 at 09:40:13AM -0400, Jon Smirl wrote:
>
>  > can do this. Does ALSA hand me the two buffers simultaneously? I
>  > haven't located any code yet supporting independent playback.
>
>
> It shouldn't be fundamentally different to multiple independent records
>  which the PXA code does support.  If you present them as separate PCMs
>  then ALSA won't synchronize them for you.

Any words of wisdom on how to synchronize?


>  > > The ASoC AC97 support doesn't use the AC97 patch infrastructure at all -
>  > >  it's completely independent so things are pretty much as you describe,
>  > >  everything is in the CODEC drivers.
>
>  > I've figured out now that the pci codec code is independent of the
>  > asoc code. Are there plans to unify this in the future?
>
>
> I'm not aware of anyone working on doing so.
>


-- 
Jon Smirl
jonsmirl@gmail.com
