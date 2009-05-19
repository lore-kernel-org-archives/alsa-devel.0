From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc: Correct print specifiers for	unsigneds
Date: Tue, 19 May 2009 10:23:21 +0100
Message-ID: <20090519092320.GC27195@sirena.org.uk>
References: <4A11B87D.50505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D8FBA2469E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 11:23:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A11B87D.50505@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 18, 2009 at 09:35:25PM +0200, Roel Kluin wrote:
> Unsigned variables should use `%u' rather than `%d'.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

> This also comtains some changes that I already sent here
> http://lkml.org/lkml/2009/5/11/497
> Sorry for that, Is there some way to split these changes?

The usual approach is to either maintain a patch queue so new patches
are generated against a version with the previous patch applied or to
start each new patch against the base tree.

In this case I've already applied your first patch and I'm not sure
which tree you're generating the patch against - I can't seem to apply
the patch cleanly with either git or patch, I get conflicts in wm8400
and wm8753.  ALSA patches should be generated against:

     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Could you please regenerate against the topic/asoc branch of that tree?

Also, please do try to CC maintainers on patches.  I'm fairly sure I've
reminded you about this before.
