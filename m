From: Davyd McColl <davydm@gmail.com>
Subject: Re: Headphone jack and auto-mute of speak output
Date: Fri, 8 Oct 2010 07:50:45 +0200
Message-ID: <AANLkTikgxaA1E4EMpan63-s48MefDsvRPXfYxfYRV3XX@mail.gmail.com>
References: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
	<AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
	<4CADEF5F.7070600@canonical.com>
	<AANLkTimHatLx7PP6BQc=zxOyBarKiFuTpLbeDpWh7kdJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D0C02461E
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 07:51:10 +0200 (CEST)
Received: by qyk2 with SMTP id 2so275048qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 22:51:07 -0700 (PDT)
In-Reply-To: <AANLkTimHatLx7PP6BQc=zxOyBarKiFuTpLbeDpWh7kdJ@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 8 October 2010 01:05, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> 2010/10/8 David Henningsson <david.henningsson@canonical.com>
>
> As you have not provided any output of alsa-info.sh  , it is impossible to
> say this case is a regression or not
>
Apologies. ALSA information can be found here:
http://www.alsa-project.org/db/?f=e0b199a8e8de35452f761359e753f0f668bb9551

In addition, the original bug I submitted can be found here:
https://bugs.launchpad.net/bugs/655351

There is a full hardware info dump as made by apport alongside that.

If the driver cannot find the [Pin Complex] Speaker at Int when you select
> model=auto.
> it assume that it is a desktop instead of a laptop
>
The machine presenting the issue is indeed a desktop, not a laptop.

-d
