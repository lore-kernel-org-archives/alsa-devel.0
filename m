From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: CS4206 and S/PDIF (again)
Date: Thu,  3 Mar 2011 03:18:17 +0530
Message-ID: <1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
References: <1298955969.12314.12.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 980E11037F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 22:48:39 +0100 (CET)
In-Reply-To: <1298955969.12314.12.camel@snowflake>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>
List-Id: alsa-devel@alsa-project.org

I bisected this down to the erratum fix added in commit a769cbcf. From
what I can tell, the erratum only applies to CS4207, so I'm attaching a
patch to make the fix conditional. CC'ing the author of that commit to
verify that this is correct.

Cheers,
Arun
