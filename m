From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: Use a define for the number of
 jack switch types
Date: Wed, 22 Feb 2012 15:02:10 +0000
Message-ID: <20120222150210.GB14463@sirena.org.uk>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B54D8104060
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:02:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 07, 2012 at 07:48:47PM +0000, Mark Brown wrote:
> This is intended to facilitate the merge of the two jack detection
> mechanisms.

So, discussion on these seems to have ground to a halt and I don't see
any clear way forward.  It seems like there's a desire to rework the ABI
for the control based jacks which is blocking any other work here, I
don't think there were any other substantial issues?

My main concern is to get everything back to using a single in-kernel
API so that all the drivers present the same userspace interfaces, I'd
rather do the refactoring to get everything back together and then worry
about refactoring the userspace interface later as that's causing real
hassle for me (mostly because it's also causing hassle for users).

It'd be nice to get at least the first patch applied, if only so I don't
have to carry it around.
