From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/9] Register the wm9712 DAIs on
	module	load
Date: Sun, 24 May 2009 12:11:18 +0100
Message-ID: <20090524111118.GC4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231257.17919.4483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E91572434B
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 13:11:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231257.17919.4483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 07:12:57PM -0400, Jon Smirl wrote:
> Register the wm9712 DAIs on module load

> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Why do you wish to do this - ASoC does not require or use DAI registration
for AC97 CODECs?
