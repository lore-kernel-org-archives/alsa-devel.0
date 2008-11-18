From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: DaVinci: Fix audio stall when doing
	full duplex
Date: Tue, 18 Nov 2008 11:36:55 +0000
Message-ID: <20081118113654.GD23217@sirena.org.uk>
References: <1226986263-7815-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E9EB12452A
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:36:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226986263-7815-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naresh@ti.com
Cc: alsa-devel@alsa-project.org, Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 11:01:03AM +0530, naresh@ti.com wrote:

> Fix concurrent capture/playback issue.
> The issue is caused by re-initialization of control registers used specifically
> for capture or playback in both capture and playback operations.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Signed-off-by: Steve Chen <schen@mvista.com>
> 	       Naresh Medisetty <naresh@ti.com>

This should be two separate Signed-off-by: lines.
