From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] [alsa-lib] pcm: softvol: Allow up to 90 dB
 of gain
Date: Mon, 23 Apr 2018 11:51:26 +0200
Message-ID: <alpine.DEB.2.11.1804231149520.5586@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1804181632580.5586@lnxricardw1.se.axis.com>
 <s5hlgdipc0c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9092675D0
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 11:51:33 +0200 (CEST)
In-Reply-To: <s5hlgdipc0c.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 20 Apr 2018, Takashi Iwai wrote:

> > When studying the code, it becomes apparent that the limit of the actua=
l =

> > gain function is a gain factor of 32767, which corresponds to 90.3 dB. =
So =

> > ...

> Honestly speaking, I still don't like to change something just because
> the number can reach.  But this is a minor issue and if any damage
> happens, it can be said to be self-responsibility, so I applied as
> is.

Thanks Takashi!

I agree that 90 dB might be excessive, but at any rate I couldn't think =

of a logical motivation for any particular lower value in this case.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
