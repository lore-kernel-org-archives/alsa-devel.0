From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] Calculate BCLK using TDM slots and
 remove channels rule
Date: Tue, 21 Apr 2015 09:30:37 +0300
Message-ID: <5535EE8D.4030302@ti.com>
References: <cover.1429537509.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EBB58260467
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 08:30:42 +0200 (CEST)
In-Reply-To: <cover.1429537509.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, misael.lopez@ti.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On 04/20/2015 04:58 PM, Jyri Sarha wrote:
> The first patch is a bugfix. I did not have the HW see the problem
> myself, but reading from the code the problem is evident. This should
> also fix Dan Carpenter's concern about stack usage in
> davinci_mcasp_hw_rule_channels(), as the whole function is removed.
> =

> The second patch is just an optimization of the sample-rate rule. In
> effect I put in use Takashi Iwai's suggestion for fixing the stack
> usage issue in the channels rule.

Both:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Jyri Sarha (2):
>   ASoC: davinci-mcasp: Calculate BCLK using TDM slots and remove
>     channels rule
>   ASoC: davinci-macsp: Optimize implicit BLCK sample-rate rule
> =

>  sound/soc/davinci/davinci-mcasp.c | 104 ++++++++++----------------------=
------
>  1 file changed, 27 insertions(+), 77 deletions(-)
> =



-- =

P=E9ter
