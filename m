From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: User-space control elements in ext PCM plugin
Date: Wed, 7 Apr 2010 13:58:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004071357040.3925@eeebox2.perex-int.cz>
References: <20100407100104.41190@gmx.net> <hphqhb$839$1@dough.gmane.org>
	<20100407115433.60020@gmx.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-696568158-1270641520=:3925"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 865251038EC
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 13:58:42 +0200 (CEST)
In-Reply-To: <20100407115433.60020@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marcus Weigelt <noize007@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-696568158-1270641520=:3925
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Apr 2010, Marcus Weigelt wrote:

> That=C2=B4s where I got the idea of creating the user-space control eleme=
nts=20
> directly inside of the PCM plugin, or did I get it wrong?

The build-in softvol plugin uses this mechanism. But I'm not sure, if this=
=20
way is supported in the external PCM plugins interface.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-696568158-1270641520=:3925
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-696568158-1270641520=:3925--
