From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: alsa-lib and floating point support
Date: Wed, 20 Sep 2017 16:45:46 +0200
Message-ID: <alpine.DEB.2.11.1709201642470.14549@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1709201244490.14549@lnxricardw1.se.axis.com>
 <s5hzi9pd31m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A0D92668BF
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 16:45:53 +0200 (CEST)
In-Reply-To: <s5hzi9pd31m.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mersad Jelacic <mersad@axis.com>
List-Id: alsa-devel@alsa-project.org


On Wed, 20 Sep 2017, Takashi Iwai wrote:

> > I'm trying to understand why it is critical to have hardware floating =

> > point support in this case. The pow() function is very resource hungry, =

> > true, but the function is only called when the plugin is loaded, and no=
t =

> > for instance on every sample while the stream is running, so on the who=
le =

> > I would expect the impact to be minimal. Is there some other rationale =

> > that I'm missing?
> =

> The softfloat option is to avoid calculation in float as much as
> possible, i.e. alsa-lib will be built without any usage of math
> library.

"as much as possible" sounds like the softvol case would be a reasonable =

exception, on the other hand, if the goal is to completely avoid using the =

softfloat library I can see the point. Is the reason to avoid dependency =

issues, or to minimize the total resulting code size, especially on =

systems with limited memory?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
