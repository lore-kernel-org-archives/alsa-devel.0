From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: davinci-i2c,pcm updates
Date: Sun, 5 Jul 2009 12:41:23 +0100
Message-ID: <20090705114122.GA5334@sirena.org.uk>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 832162415F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 13:41:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 04, 2009 at 07:29:50PM -0700, Troy Kisky wrote:
> This patch set is against git://git.alsa-project.org/alsa-kernel.git

Best to use

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6

or
	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

> but the last patch in series won't compile until the sram allocator patch
> is available.

I've not reviewed or checked the code yet but it's likely to collide
with the updates which Chaithrika U S did to add support for some newer
processors.  Those are still sitting unmerged on the davinci branch of
my git since I've not heard anything about the arch/arm changes for the
clocks that they depend on.  The last thing I saw was a query from Kevin
about the use of plain names.

Could you give a pointer to the SRAM allocator patch, please?
