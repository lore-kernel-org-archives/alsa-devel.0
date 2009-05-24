From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 8/9] Fabric bindings for STAC9766 on	the
	Efika
Date: Sun, 24 May 2009 13:12:17 +0100
Message-ID: <20090524121216.GH4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231311.17919.38581.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 702EB2438D
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 14:12:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231311.17919.38581.stgit@terra>
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

On Sat, May 23, 2009 at 07:13:11PM -0400, Jon Smirl wrote:
> Fabric bindings for STAC9766 AC97 codec on the Efika.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

This is OK, but obviously depends on previous patches so I'll not apply
it just yet.  You might want to run it (and many of your other patches)
through checkpatch, though.  One nit:

> +static __exit void efika_fabric_exit(void)
> +{
> +}

This should either do something or be removed.
