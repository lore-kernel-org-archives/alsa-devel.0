From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] Add ASoC support for DEVKIT8000
Date: Thu, 12 Nov 2009 13:00:33 +0000
Message-ID: <20091112130033.GC11656__14686.8913587697$1258030850$gmane$org@sirena.org.uk>
References: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 12, 2009 at 09:24:43PM +1100, Kim Botherway wrote:
> This patch add support for DEVKIT8000, it is a copy of Beagleboard sound
> driver

You forgot your Signed-off-by here.  Please also remember to CC the
maintainers on patch submissions.

If this genuinely is just a straight copy of the Beagleboard driver then
it would be better to do this by changing the existing driver so that it
can be built and loaded on both boards, together with updating the
Kconfig so users can see which driver to use for DEVKIT8000.
