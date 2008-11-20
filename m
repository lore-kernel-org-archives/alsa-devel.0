From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ALSA: ASoC: ssm2602,
	wm8903: Fix priv substreams refs
Date: Thu, 20 Nov 2008 14:48:48 +0000
Message-ID: <20081120144842.GH4539@sirena.org.uk>
References: <4925769F.1010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 50C2E243CE
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 16:04:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4925769F.1010108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 03:39:27PM +0100, Karl Beldan wrote:

> - This is a fix for less evil:
>   The logic is flawed (e.g. the slave might startup before the
>   master's rate and sample_bits are set).

If you're going to document this for WM8903 then it also needs to be
documented for the other drivers that implement this (there's some
more).  There isn't any way to fix this with the existing ALSA APIs.

Anyway, I'll queue this up.
