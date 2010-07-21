From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Memory leak in namehint.c
Date: Wed, 21 Jul 2010 09:28:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007210928400.9258@eeebox2.perex-int.cz>
References: <4C45F868.7060807@tds.net> <4C46256D.7070201@tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AFF7C244A8
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 09:28:52 +0200 (CEST)
In-Reply-To: <4C46256D.7070201@tds.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jul 2010, John Lindgren wrote:

> Please disregard the previous patch as it has the potential for a double
> free() if snd_card_get_name() fails.  Here is a corrected patch.

Applied. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
