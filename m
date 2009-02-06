From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/3] ASoC: Blackfin: cleanup sport	handling
	in ASoC Blackfin AC97 code
Date: Fri, 6 Feb 2009 11:57:35 +0000
Message-ID: <20090206115733.GE8723@sirena.org.uk>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
	<1233915156-17985-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 506F42433E
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 13:09:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233915156-17985-2-git-send-email-cooloney@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2009 at 06:12:34PM +0800, Bryan Wu wrote:
> From: Mike Frysinger <vapier.adi@gmail.com>
> 
> - make sport number handling more dynamic as not all
>   Blackfins have a linear sport map starting at 0
> - indexes can be macroed away too
> 
> Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Applied, thanks.
