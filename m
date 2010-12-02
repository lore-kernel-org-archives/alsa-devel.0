From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Thu, 2 Dec 2010 11:59:55 +0800
Message-ID: <AANLkTimFdmXHazD2WEmbzFWmy84bgyAyAzcmAAFDQ6t9@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
	<AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
	<AANLkTi=Z1mzT70LSySZoY5W-j70p=AB=HJ5ezTYP=FLG@mail.gmail.com>
	<AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9681F10381E
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 04:59:59 +0100 (CET)
Received: by eyg24 with SMTP id 24so4024445eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 19:59:55 -0800 (PST)
In-Reply-To: <AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/1 Colin Kincaid Williams <discord@uw.edu>

> I selected node 0x0c in  hdaanalyzer and see audio mixer [OxOb] in the
> Connection list, but I cannot select the radio button.
>


Refer to your screen shot  , the mute switches of node 0x0b seem to be
val[2] and val[3] of  the input amplifier
