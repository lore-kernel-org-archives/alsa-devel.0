From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Add support for gain in softvol plugin
Date: Thu, 3 May 2007 21:22:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705032121110.7861@tm8103.perex-int.cz>
References: <463A33D8.3090907@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5260824396
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 21:22:37 +0200 (CEST)
In-Reply-To: <463A33D8.3090907@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Longerbeam <stevel@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 3 May 2007, Steve Longerbeam wrote:

> Hi all,
> 
> What do you think of this patch? I tested this using a stac9205 HDA codec with
> all sample formats supported by softvol (s32, s16, s24, big and little
> endian).

I would not add extra defines to alsa.conf:

+defaults.pcm.dsnoop_softvol.card defaults.pcm.card
+defaults.pcm.dsnoop_softvol.device defaults.pcm.device

Simply reuse pcm.dsnoop.card / device.

Otherwise - it looks good. Nice softvol extension.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
