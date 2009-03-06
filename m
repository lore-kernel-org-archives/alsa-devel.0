From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/5] ASoC: Blackfin: drop pointless
	casts	due to dma updates
Date: Fri, 6 Mar 2009 11:10:03 +0000
Message-ID: <20090306110949.GC6493@sirena.org.uk>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F33E243FE
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 12:20:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236326010-683-5-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2009 at 03:53:29PM +0800, Bryan Wu wrote:
> From: Mike Frysinger <vapier.adi@gmail.com>
> 
> Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  sound/blackfin/bf53x_sport.c |   55 ++++++++++++++++++-----------------------
>  1 files changed, 24 insertions(+), 31 deletions(-)

Mainline doesn't have a sound/blackfin directory at all as far as I can
tell so this patch doesn't apply?  The only mainline support I can see
for blackfin audio is sound/soc/blackfin which only has a generic
bf5xx-sport file.  A similar cleanup was done there a while ago.
