From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Add hw_param callback for
 S/PDIF DIT link
Date: Wed, 10 Mar 2010 12:00:22 +0000
Message-ID: <20100310120022.GL24422@rakim.wolfsonmicro.main>
References: <1268212713-12041-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49A392443D
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:00:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268212713-12041-1-git-send-email-chaithrika@ti.com>
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
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 02:48:33PM +0530, Chaithrika U S wrote:
> On TI DM6467 EVM, S/PDIF DIT codec fails to open as it is unable to install
> hardware params. This dummy codec has no set_fmt and set_sysclk implementations
> and calls from the application to these functions cause errors. This patch adds
> a new hardware params callback function for S/PDIF transciever codec.

Applied, thanks.
