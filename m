From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Do not write to invalid registers
	on	the wm9712.
Date: Tue, 22 Dec 2009 23:46:29 +0000
Message-ID: <20091222234628.GB2643@sirena.org.uk>
References: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2009 at 12:28:58PM -0500, Eric Millbrandt wrote:
> This patch fixes a bug where "virtual" registers were being written to the
> ac97 bus.  This was causing unrelated registers to become corrupted (headphone 0x04,
> touchscreen 0x78, etc).
> 
> This patch duplicates protection that was included in the wm9713 driver.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

This looks like a reasonable fix but it doesn't apply against current
kernels.  Could you please regenerate it against

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Please do also remember to CC the maintainers of the relevant kernel
subsystems on submitted patches - scripts/get_maintainer.pl is helpful
here.  Things only sent to mailing lists sometimes get lost due to the
volume.
