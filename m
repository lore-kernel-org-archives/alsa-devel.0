From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] hda-analyzer: Avoid AttributeError when
 codec has no nodes
Date: Thu, 4 Feb 2010 20:22:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002042021030.15192@eeebox2.perex-int.cz>
References: <1265304654-14439-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-948320088-1265311320=:15192"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CA3F103846
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 20:22:01 +0100 (CET)
In-Reply-To: <1265304654-14439-1-git-send-email-ozan@pardus.org.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ozan_=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-948320088-1265311320=:15192
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 4 Feb 2010, Ozan =C3=87a=C4=9Flayan wrote:

> When traversing card/codec/nodes during treewidget creation, it's quite
> possible that codec.nodes raises an AttributeError if the current codec
> doesn't seem to have a nodes dictionary.
>
> Simply initialize it to an empty dictionary in the beginning of
> analyze().

Thank you for your patch. I had already this change in my local tree.
I pushed it to git.alsa-project.org now.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-948320088-1265311320=:15192
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-948320088-1265311320=:15192--
