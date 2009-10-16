From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix codec_dai->ops NULL pointer bug
	for	AC97 codec dai in soc-core
Date: Fri, 16 Oct 2009 10:32:44 +0100
Message-ID: <20091016093244.GK884@sirena.org.uk>
References: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
	<20091016090840.GI884@sirena.org.uk>
	<3c17e3570910160214q18e99bd0y932b800a0c4f9fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C7042452E
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 11:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910160214q18e99bd0y932b800a0c4f9fca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 16, 2009 at 05:14:31PM +0800, Barry Song wrote:
> On Fri, Oct 16, 2009 at 5:08 PM, Mark Brown

> > This is the wrong fix - null DAI ops are supposed to be supported for
> > all devices since not all DAIs will be configurable.

> But the problem is ac97 DAIs will have no path to get the null ops.
> Then many functions will panic. It's very easy to repeat the problem
> in your site, only by deleting ops field in any AC97 codec DAI.

Sure, I see the problem.  The issue is that this could affect any CODEC,
not just AC97 ones, so an AC97-specific fix isn't what's needed.  Given
the idiom of the rest of the code the best thing would be to make all
the remaining callers check for ops before dereferencing it.
