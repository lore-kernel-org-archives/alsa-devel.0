From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/8] ASoC: Fix BUGS in Blackfin AC97 DAI
Date: Tue, 18 Nov 2008 11:54:26 +0000
Message-ID: <20081118115426.GG23217@sirena.org.uk>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
	<1226996302-10234-6-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C470324537
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:54:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226996302-10234-6-git-send-email-cooloney@kernel.org>
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
Cc: tiwai@suse.de, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 04:18:19PM +0800, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>

> sport_handle is a global and not allocated my kmalloc.

There's no reference to sport_handle in the patch...

> A probe function should have a clean return 0 path.

...only this.
