From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: alc5632: Added support of two
 undocumented registers
Date: Thu, 17 Nov 2011 13:42:14 +0000
Message-ID: <20111117134214.GA16740@sirena.org.uk>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
	<1321438023-29660-6-git-send-email-leon@leon.nu>
	<20111116103739.GC3072@opensource.wolfsonmicro.com>
	<CALq1K=L3=e2BD8E7nugLEsmrNjS+B209bC0h7qm=Tx6QDZXF-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 589121037FC
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 14:42:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=L3=e2BD8E7nugLEsmrNjS+B209bC0h7qm=Tx6QDZXF-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 09:43:15PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 16, 2011 at 12:37, Mark Brown

> > As these are volatile registers you don't need to provide defaults and
> > doing so might cause confusion.

> Is it applicable for all volatile registers?

Yes.

> Do I provide the patch which remove all volatile registers from the regmap DB?

Please.
