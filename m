From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix deemphasis control in
	wm8904/55/60 codecs
Date: Thu, 9 Dec 2010 10:56:29 +0000
Message-ID: <20101209105626.GA4548@rakim.wolfsonmicro.main>
References: <1291840577-23908-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E64C103C55
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 11:56:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291840577-23908-1-git-send-email-mad_soft@inbox.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 11:36:17PM +0300, Dmitry Artamonow wrote:
> Deemphasis control's .get callback should update control's value instead
> of returning it - return value of callback function is used for indicating
> error or success of operation.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Applied, thanks.
