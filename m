From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 0/4] ARM: DaVinci: ASoC: Audio
	support	for DM646x
Date: Sun, 7 Jun 2009 20:36:23 +0100
Message-ID: <20090607193622.GA18228@sirena.org.uk>
References: <1244197668-30916-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 32D3424660
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Jun 2009 21:36:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244197668-30916-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 06:27:48AM -0400, Chaithrika U S wrote:
> From: Chaithrika U S <chaithrika@ti.com>
> 
> Add audio support for DM646x

This all looks good from an ASoC point of view - I've applied the ASoC
patches (2-4) to a branch 'davinci' of:

	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

Please submit incremental updates for further merge issues such as that
Troy raised against that branch.  Owing to the nearness of the merge
window and the need to also merge the arch/arm changes I'll not push
these upstream until after the merge window is over.

Thanks!
