From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Resubmit: [PATCH] sound/soc/codecs: Add
	support	for the wm8727 DAC.
Date: Mon, 2 Nov 2009 15:28:22 +0000
Message-ID: <20091102152822.GC6840@sirena.org.uk>
References: <91f916b90911020714w78751086oce7d556d3fcdd3dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A2C61038CB
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 16:28:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <91f916b90911020714w78751086oce7d556d3fcdd3dd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neiljay@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 03:14:17PM +0000, Neil Jones wrote:
> Add support for the Wolfson Micro wm8727 DAC, this is a simple
> non-configurable DAC.

Looks good, I've applied it thanks.  I had to manually apply the Kconfig
and Makefile changes since there were conflicts there with current ALSA
- when submitting patches you should always try to ensure that your
patches are against the code advertised in MAINTAINERS as being current.
