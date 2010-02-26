From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [patch 2/2] AC97: add full duplex
	support	for atmel AT91 and AVR.
Date: Fri, 26 Feb 2010 10:02:34 +0000
Message-ID: <20100226100233.GA31530@sirena.org.uk>
References: <1267120780-1788-1-git-send-email-sedji.gaouaou@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C96821039FD
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 11:02:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267120780-1788-1-git-send-email-sedji.gaouaou@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 06:59:40PM +0100, Sedji Gaouaou wrote:
> This patch add full duplex support on AT91 and AVR.
> It was a bug: we needed to check first if there are some chips opened so we
> could enable both reception and sending of the data.
> 
> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>

Both patches

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
