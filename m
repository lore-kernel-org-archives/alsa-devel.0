From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sound: max98090: Remove executable bit
Date: Thu, 21 Mar 2013 10:16:15 -0700
Message-ID: <1363886175.30275.10.camel@joe-AO722>
References: <1363730323.16270.11.camel@joe-AO722>
	 <20130320095758.GD28775@opensource.wolfsonmicro.com>
	 <1363792936.16270.30.camel@joe-AO722>
	 <20130320163627.GS28775@opensource.wolfsonmicro.com>
	 <1363820072.16270.43.camel@joe-AO722>
	 <20130321162503.GC14768@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130321162503.GC14768@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-03-21 at 17:25 +0100, Mark Brown wrote:
> > I suggest you use a git pre-commit hook to your
> > tree and use sed/perl to add a specific prefix
> > if it doesn't exist.
> > http://codeinthehole.com/writing/tips-for-using-a-git-pre-commit-hook/
> 
> I don't think you're quite understanding the issues with automation
> here.  Or indeed the desired end result.

What issue is that?

Maybe this would work for you...

$ cat .git/hooks/applypatch-msg
#!/bin/sh

. git-sh-setup

perl -p -i -e 's/^(?:ASoC:\s*)?(.*)$/ASoC: $1/g if 1 .. 1' {$1+"$@"}

test -x "$GIT_DIR/hooks/commit-msg" &&
	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
:
$
