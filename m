From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Constraining the number of frames per period
Date: Thu, 21 Oct 2010 16:50:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
References: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1816069276-1287672656=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 428DF103824
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 16:50:57 +0200 (CEST)
In-Reply-To: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1816069276-1287672656=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Oct 2010, Adam Rosenberg wrote:

> I would like to make sure that all programs that use the sound driver
> I wrote are required to use 512 frames per period.=C2=A0 Is there a
> snd_pcm_hw_constraint function that will allow me to do this?

Just use periods_min and period_max =3D 512 in the hw structure. But why=20
this constraint? It's better to use different ways in the driver=20
(timers, etc) to leave reasonable range of the configuration space.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1816069276-1287672656=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1816069276-1287672656=:29422--
