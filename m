From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix codec_dai->ops NULL pointer bug
	for	AC97 codec dai in soc-core
Date: Fri, 16 Oct 2009 10:48:43 +0100
Message-ID: <20091016094843.GL884@sirena.org.uk>
References: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
	<20091016090840.GI884@sirena.org.uk>
	<3c17e3570910160214q18e99bd0y932b800a0c4f9fca@mail.gmail.com>
	<20091016093244.GK884@sirena.org.uk>
	<3c17e3570910160235n28f396b1m665e9e4540a75123@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EB5182453F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 11:48:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910160235n28f396b1m665e9e4540a75123@mail.gmail.com>
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

On Fri, Oct 16, 2009 at 05:35:12PM +0800, Barry Song wrote:

> At the beginning, I wanted to do like this. But I saw all other codec
> DAIs register themselves, then got a null ops. Just ac97 is forgot.
> Then I patched AC97 codec DAIs.
> Then you prefer to patch all ops access?

Hrm, so they do.  In that case could you revise your patch to not check
for AC97 but just check for null DAI ops instead since this isn't an
AC97 specific issue?
