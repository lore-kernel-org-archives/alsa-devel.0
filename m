From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: add support for SSI
	asynchronous	mode to the Freescale SSI drivers
Date: Fri, 6 Mar 2009 11:02:54 +0000
Message-ID: <20090306110226.GB6493@sirena.org.uk>
References: <1236295417-12013-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C372A243E3
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 12:05:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236295417-12013-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 05:23:37PM -0600, Timur Tabi wrote:
> Add a new device tree property for the SSI node: "fsl,ssi-asynchronous".  If
> defined, the SSI is programmed into asynchronous mode, otherwise it is
> programmed into synchronous mode.  In asynchronous mode, pin SRCK must be
> connected to the same clock source as STFS, and pin SRFS must be connected to
> the same signal as STFS.  Asynchronous mode allows playback and capture to
> use different sample sizes.  It also technically allows different sample rates,
> but the driver does not support that.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks,
