From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/19] ALSA: ymu831: add B-DSP driver
Date: Thu, 17 Jan 2013 15:07:42 +0900
Message-ID: <20130117060741.GB20199@opensource.wolfsonmicro.com>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172832.7339f01ca4557727fdc3883f@linux-mips.org>
 <20130116132245.GB16235@sirena.org.uk>
 <20130117145912.10c5650712b73552ad9c4068@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130117145912.10c5650712b73552ad9c4068@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2013 at 02:59:12PM +0900, Yoichi Yuasa wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Why the subdirectory?

> ymu831 driver has 27 files.
> It is the reason that I made the subdirectory.
> Is it better to put them on sound/soc/codes ?

It would be better to rewrite the driver to be a standard Linux driver
using the standard Linux frameworks - looking at the code this seems
very likely to substantially reduce the amount of code involved.
