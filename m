From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec
	DAI	suspend/resume
Date: Wed, 11 Nov 2009 14:42:52 +0000
Message-ID: <20091111144252.GB20417@opensource.wolfsonmicro.com>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
	<20091111112431.GA18005@opensource.wolfsonmicro.com>
	<3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
	<20091111142050.GB32595@sirena.org.uk>
	<3c17e3570911110634k60ecc02fwf52c168e9f5ad7a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6523B10385D
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 15:42:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911110634k60ecc02fwf52c168e9f5ad7a2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 10:34:00PM +0800, Barry Song wrote:

> The only difference should be whether clock/sync is fired from codec
> before or after TDM interfaces are resumed to be ready for the
> different resume order of CPU and Codec DAI, as I guess. That's
> difficult to explain why.

It'd really like to understand what's going wrong with the controller
here - it should just sync up off the frame sync signal.
