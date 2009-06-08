From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Default enabling of mixer controls
Date: Mon, 8 Jun 2009 13:14:48 +0100
Message-ID: <20090608121447.GD7858@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09BE924367
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:14:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 05:40:56PM +0530, Aggarwal, Anuj wrote:

> Right now, they both come disabled in the default configuration and I
> have to enable them explicitly by issuing the amixer cset command. How
> can I do that automatically?

Register writes in the DAI init function will probably do the job,
however the general advice is to leave this up to user space.
