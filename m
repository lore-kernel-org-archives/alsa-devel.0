From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for test (1.0.18 final)
Date: Mon, 27 Oct 2008 19:18:10 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810271917110.12044@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<4905F6EB.8080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A6F0C24385
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 19:18:11 +0100 (CET)
In-Reply-To: <4905F6EB.8080507@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Oct 2008, Chris Pemberton wrote:

> /home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/../alsa-kernel/core/jack.c:108: 
> error: 'SW_LINEOUT_INSERT' undeclared (first use in this function)

Could you try again latest snapshot? I just included the patch which 
should fix this issue.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
