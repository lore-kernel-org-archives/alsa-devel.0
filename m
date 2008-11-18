From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/8] ASoC: Blackfin: fix bug - AD1980/1 SOC
	Audio driver fails to build in case MMAP support is turned off
Date: Tue, 18 Nov 2008 11:53:29 +0000
Message-ID: <20081118115328.GF23217@sirena.org.uk>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
	<1226996302-10234-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D548D24537
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:53:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226996302-10234-5-git-send-email-cooloney@kernel.org>
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
Cc: tiwai@suse.de, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 04:18:18PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> clean up redudent code and correct building problem in non-mmap mode

This doesn't apply against 2.6.28 - does the same issue apply there?  If
so then a patch for 2.6.28 fixing *only* the build issue would probably
be a good idea.

Alos, please try to ensure that the short log for your patch is less
than 80 characters (it should normally be much less).
