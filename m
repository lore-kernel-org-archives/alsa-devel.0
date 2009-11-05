From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA/ASoC crash in pm_qos_remove_requirement()?
Date: Thu, 5 Nov 2009 13:57:00 +0100
Message-ID: <20091105125700.GT14091@buzzloop.caiaq.de>
References: <20091105121032.GR14091@buzzloop.caiaq.de>
	<20091105124902.GA31745@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 83C8E103942
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 13:57:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091105124902.GA31745@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Michael Hirsch <m.hirsch@raumfeld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 12:49:03PM +0000, Mark Brown wrote:
> On Thu, Nov 05, 2009 at 01:10:32PM +0100, Daniel Mack wrote:
> > Has anyone seen a similar crash to the one below recently?
> > It happened to us on PXA300 embedded platforms.
> 
> > Any pointers appreciated.
> 
> Smells like memory corruption, there's no call to pm_qos stuff anywhere
> near there.

Jep, I just saw that, too. Damn it.
