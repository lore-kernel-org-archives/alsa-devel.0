From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] CHROMIUM: ASoC: Remove 'const' modifiers
	which cause	warnings during compilation.
Date: Tue, 10 May 2011 22:03:20 +0100
Message-ID: <20110510210319.GA17589@sirena.org.uk>
References: <1305054860-16054-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A336D246CF
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 23:03:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305054860-16054-1-git-send-email-thutt@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2011 at 12:14:20PM -0700, Taylor Hutt wrote:
> This change removes a warning produced when 'const * const' values
> are assigned to a 'const **'.
>
> These code being modified originally came from these two commits:
> 
>     http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=82a5a936f6dea13849d93a2899a9b7294a8db336
>     http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=dad31ec133adb20c8fd10bfd9379da3f08b8721e
> 
> Change-Id: I964ff6d24aafe78c2db7002abfd03b9069db9687
> Signed-off-by: Taylor Hutt <thutt@chromium.org>

This is already fixed in -next.

Please follow the patch submission procedure in SubmittingPatches, in
particular:

- Send patches to the relevant maintainers and mailing lists.
- Don't include "CHROMIUM" or other local things like gerritt artifacts
  in your changelog.

If you don't send patches to the maintainers there's a reasonable chance
they'll never see them, and the changelog stuff is just irrelevant and
makes it harder to apply the patch as the maintainer has to manually
remove them.
