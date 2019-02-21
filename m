From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: Regarding alsa-utils commit "alsaucm: add alsa-ucm
 udev rules for PAZ00 (Toshiba AC100/Dynabook AZ)."
Date: Thu, 21 Feb 2019 14:50:49 +0200
Message-ID: <87ec69bdbc838579aac37e50cf3d086f06c24721.camel@iki.fi>
References: <c915e9cd989b40647458078a702847260a6998da.camel@iki.fi>
 <fc8d5145-fa9a-9f4b-8603-48e0f1fd6380@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AECEF8069B
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2019 13:50:57 +0100 (CET)
In-Reply-To: <fc8d5145-fa9a-9f4b-8603-48e0f1fd6380@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-02-21 at 12:32 +0100, Jaroslav Kysela wrote:
> Dne 21. 02. 19 v 11:51 Tanu Kaskinen napsal(a):
> > Hi Jaroslav,
> > 
> > I'm updating alsa-utils in OpenEmbedded, and I noticed that there's a
> > new udev rules file, 89-alsa-ucm.rules. It seems to just initialize the
> > mixer settings for particular hardware (Toshiba AC100/Dynabook AZ), and
> > doing that in alsa-utils seems weird. Why does this hardware use a udev
> > rules file for initialization, unlike any other hardware?
> 
> I was asked to add those rules to the ALSA initialization, so it seems
> that we have users that does not use any other additional layer to
> control the hardware and they want to use the standard ALSA applications
> on top.
> 
> Note that there is not only mixer settings, but also the routing
> settings which most of standard mixer applications don't handle
> correctly, so it makes sense to do this settings at boot.
> 
> Anyway, I am open to any discussion to handle this properly. Nowadays,
> it seems that the use-case configurations are mandatory to bring the
> universal hardware drivers (mainly ASoC) to an useable state. We have
> already alsactl, it may be extended to set the default use case or
> restore the last one. We can also write special alsactl configs, but it
> makes sense to keep things only at the one place.

I think there's no "default verb" concept in UCM, so I guess that's the
main thing that needs to be added.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk
