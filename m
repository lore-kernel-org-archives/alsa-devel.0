From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: remove duplicated code on pxa-ssp.c
Date: Thu, 11 Jun 2009 21:03:12 +0100
Message-ID: <20090611200311.GA20245@sirena.org.uk>
References: <1244658204.25905.10.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56DE5103851
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 22:03:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244658204.25905.10.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2009 at 03:23:24PM -0300, Daniel Ribeiro wrote:
> * We don't need to write the registers twice, remove the first write.
> * DAIFMT_INV switch is duplicated inside DAIFMT_FORMAT switch, move it
>   out.
> 
> (This patch is for Mark's for-2.6.32 branch, I have not checked if the
> code is duplicated on current 2.6.30)
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

Applied, thanks.
