From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: MAX9877: fix write operation for register
Date: Thu, 23 Jul 2009 11:09:12 +0100
Message-ID: <20090723100911.GC25013@sirena.org.uk>
References: <4A68204D.7040201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CBEC91039AA
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 12:09:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A68204D.7040201@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 05:33:17PM +0900, Joonyoung Shim wrote:
> The MAX9877 needs an address of start register when we write values to
> registers through i2c_master_send(), but the code for this was missed in
> max9877_write_regs().

> If the value of control is 0 in the max9877_set_out_mode(), the value is
> not increased to 1, but actually the value to write to the register
> should be 1.
> And the register bits for out_mode and osc_mode should be cleared before
> writing.

Applied, thanks.
