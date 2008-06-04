From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revised AT32 ASoC Patch
Date: Wed, 4 Jun 2008 17:32:34 +0100
Message-ID: <20080604163233.GC2166@sirena.org.uk>
References: <200806031103.10785.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE6F01037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 18:32:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806031103.10785.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 03, 2008 at 11:03:10AM -0500, Geoffrey Wossum wrote:
> Attached is a revised version of my patch to add AT32 to ASoC.  This cleans up 
> most of the style issues associated with the previous patch.  Also fixes an 
> issue with the playpaq_wm8510.c code depending on a non-released patch to the 
> AT32 portmux support.  

Umm... On further examination, it looks like the sound/soc/at32 Makefile
has been omitted - I've used the existing one.
