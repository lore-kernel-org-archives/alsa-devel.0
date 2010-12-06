From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Replace use of strncpy()
	with strlcpy()
Date: Mon, 6 Dec 2010 19:16:17 +0000
Message-ID: <20101206191617.GI1924@rakim.wolfsonmicro.main>
References: <1291650137-7484-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5747B1038FE
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 20:16:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291650137-7484-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 03:42:17PM +0000, Dimitris Papastamos wrote:
> By using strncpy() if the source string does not have a null byte in the
> first n bytes, then the destination string is not null-terminated.
> This can be fixed in a two-step process by manually null-terminating the
> array after the use of strncpy() or by using strlcpy().

Applied, thanks.
