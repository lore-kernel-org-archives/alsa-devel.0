From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] cs4270: add support for slave
	mode	configurations
Date: Wed, 25 Feb 2009 15:48:44 +0000
Message-ID: <20090225154843.GD31637@sirena.org.uk>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<20090225153444.GC31637@sirena.org.uk>
	<20090225154541.GF11203@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFBAE103810
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 16:48:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225154541.GF11203@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 04:45:41PM +0100, Daniel Mack wrote:

> MODE_SLAVE is unset by the CS4270_MODE_SPEED_MASK mask:

Oh, fail.  Applied the patch.
