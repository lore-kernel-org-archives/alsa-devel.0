From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] - arecord - remove "front" and related
 devices from the output of list-pcm option of arecord
Date: Thu, 1 Jul 2010 07:47:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007010745470.15497@eeebox2.perex-int.cz>
References: <AANLkTinyBpf_qh6DGvj_V4UGY-JZUomNX6N32_WJpOjo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-886098899-1277963222=:15497"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D212103828
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 07:47:03 +0200 (CEST)
In-Reply-To: <AANLkTinyBpf_qh6DGvj_V4UGY-JZUomNX6N32_WJpOjo@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-886098899-1277963222=:15497
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Jul 2010, Raymond Yau wrote:

> Replace "front" device by "hw" device=C2=A0 and remove "rear", "center_lf=
e" ,
> "side" , "surroundxx" from the output of "arecord -L" since "front" devic=
e
> cannot be used for capturing and the front device is for playback only=C2=
=A0 .

NAK. Fix alsa-lib/configuration to return proper "IOID".

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-886098899-1277963222=:15497
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-886098899-1277963222=:15497--
