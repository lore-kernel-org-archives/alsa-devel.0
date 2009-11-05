From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA/ASoC crash in pm_qos_remove_requirement()?
Date: Thu, 5 Nov 2009 12:49:03 +0000
Message-ID: <20091105124902.GA31745@sirena.org.uk>
References: <20091105121032.GR14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AD3B10393B
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 13:49:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091105121032.GR14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Michael Hirsch <m.hirsch@raumfeld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 01:10:32PM +0100, Daniel Mack wrote:
> Has anyone seen a similar crash to the one below recently?
> It happened to us on PXA300 embedded platforms.

> Any pointers appreciated.

Smells like memory corruption, there's no call to pm_qos stuff anywhere
near there.
