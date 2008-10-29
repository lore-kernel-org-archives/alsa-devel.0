From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Warn when control names are	truncated
Date: Wed, 29 Oct 2008 14:55:49 +0000
Message-ID: <20081029145549.GA22417@rakim.wolfsonmicro.main>
References: <1225291230-17812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5habcnmpb1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0810291548310.12044@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B76024447
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 15:55:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0810291548310.12044@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2008 at 03:51:40PM +0100, Jaroslav Kysela wrote:

> Maybe better is to just use end char comparsion to save few CPU ticks:

> if (kctl.id.name[sizeof(kctl.id.name)-2] != '\0' &&
>     ncontrol->name[sizeof(kctl.id.name)-1] != '\0')
> 	print_warning_here;

It will be but given that this only happens when controls are created
I'd be surprised if performance were a practical issue.
