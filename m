From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Regarding alsa-utils commit "alsaucm: add alsa-ucm
 udev rules for PAZ00 (Toshiba AC100/Dynabook AZ)."
Date: Thu, 21 Feb 2019 12:32:40 +0100
Message-ID: <fc8d5145-fa9a-9f4b-8603-48e0f1fd6380@perex.cz>
References: <c915e9cd989b40647458078a702847260a6998da.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 240B0F8079F
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 09:29:23 +0100 (CET)
In-Reply-To: <c915e9cd989b40647458078a702847260a6998da.camel@iki.fi>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tanu Kaskinen <tanuk@iki.fi>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 21. 02. 19 v 11:51 Tanu Kaskinen napsal(a):
> Hi Jaroslav,
> 
> I'm updating alsa-utils in OpenEmbedded, and I noticed that there's a
> new udev rules file, 89-alsa-ucm.rules. It seems to just initialize the
> mixer settings for particular hardware (Toshiba AC100/Dynabook AZ), and
> doing that in alsa-utils seems weird. Why does this hardware use a udev
> rules file for initialization, unlike any other hardware?

I was asked to add those rules to the ALSA initialization, so it seems
that we have users that does not use any other additional layer to
control the hardware and they want to use the standard ALSA applications
on top.

Note that there is not only mixer settings, but also the routing
settings which most of standard mixer applications don't handle
correctly, so it makes sense to do this settings at boot.

Anyway, I am open to any discussion to handle this properly. Nowadays,
it seems that the use-case configurations are mandatory to bring the
universal hardware drivers (mainly ASoC) to an useable state. We have
already alsactl, it may be extended to set the default use case or
restore the last one. We can also write special alsactl configs, but it
makes sense to keep things only at the one place.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
