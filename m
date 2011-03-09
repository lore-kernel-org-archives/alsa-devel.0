From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use the correct DAPM context when
 cleaning up final widget set
Date: Wed, 09 Mar 2011 11:55:30 +0000
Message-ID: <1299671730.3360.86.camel@odin>
References: <1299612689-770-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B441B1039A1
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:55:35 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 26so347300wyj.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:55:35 -0800 (PST)
In-Reply-To: <1299612689-770-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-08 at 19:31 +0000, Mark Brown wrote:
> Now we've got multi-component we need to make sure that the DAPM context
> (and hence register I/O context) we use to apply the pending updates at
> the end of a DAPM sequence is the one we were processing rather than the
> one that was used to initate the state change.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
