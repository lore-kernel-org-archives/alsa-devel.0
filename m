From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sound: max98090: Remove executable bit
Date: Thu, 21 Mar 2013 12:16:45 -0700
Message-ID: <1363893405.30275.39.camel@joe-AO722>
References: <1363730323.16270.11.camel@joe-AO722>
 <20130320095758.GD28775@opensource.wolfsonmicro.com>
 <1363792936.16270.30.camel@joe-AO722>
 <20130320163627.GS28775@opensource.wolfsonmicro.com>
 <1363820072.16270.43.camel@joe-AO722>
 <20130321162503.GC14768@opensource.wolfsonmicro.com>
 <1363886175.30275.10.camel@joe-AO722>
 <20130321174440.GG15926@opensource.wolfsonmicro.com>
 <1363888393.30275.31.camel@joe-AO722>
 <20130321184458.GH15926@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F4A266044
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 20:16:46 +0100 (CET)
In-Reply-To: <20130321184458.GH15926@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-03-21 at 19:44 +0100, Mark Brown wrote:
> On Thu, Mar 21, 2013 at 10:53:13AM -0700, Joe Perches wrote:
> > On Thu, 2013-03-21 at 18:44 +0100, Mark Brown wrote:
> 
> > > That one needs a bit more taste and thought to work out what's
> > > appropraite than can be guaranteed easily with a script, things like
> > > working out drive level prefixes for example.
> 
> > [perfectly useful git applypatch-msg hook script removed]
> 
> No, it really isn't.  Have you tried looking at the output?  It's not
> going to do the right thing for the subject line here for example, never
> mind any other cases.

Define "the right thing" for this instance.

The commit isn't in -next so I have no idea what
you actually applied. (nor do I really care btw)

Did you try it?

It commits:

ASoC: sound: max98080: Remove executable bit

If you're really anal about it and you want
sound: for sound/soc removed,

perl -p -i -e 's/^(?:ASoC:\s*)?(?:sound:\s*)?(.*)$/ASoC: $1/g if 1 .. 1' ${1+"$@"}

This is a "your taste" issue only, and do keep in mind
mountains vs molehills.

cheers, Joe
