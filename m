From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Default enabling of mixer controls
Date: Tue, 9 Jun 2009 09:54:56 +0100
Message-ID: <20090609085456.GA10108@rakim.wolfsonmicro.main>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
	<20090608143910.GA6413@rakim.wolfsonmicro.main>
	<5A47E75E594F054BAF48C5E4FC4B92AB030591A9D1@dbde02.ent.ti.com>
	<200906090957.39758.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 939092415C
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 10:54:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906090957.39758.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2009 at 09:57:39AM +0300, Peter Ujfalusi wrote:
> On Tuesday 09 June 2009 06:45:24 ext Aggarwal, Anuj wrote:
> > > Hrm, you'll be missing some internal DAPM state updates.  Currently the
> > > most direct way to do that would be to go through the actual control
> > > interface and there's not a particularly nice way of doing that that
> > > from the kernel that I'm aware of.

> Should the snd_soc_dapm_sync(codec); need to be called after the register 
> updates?

The equivalent thing will happen when the capture starts so I'd not
expect that to help.
