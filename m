From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: simple-audio-card vs. platform question
Date: Tue, 27 Jan 2015 13:01:58 +0100
Message-ID: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A804260710
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:02:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id BC1A22E346
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:01:59 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id S6ZUx1tZSTZq for <alsa-devel@alsa-project.org>;
 Tue, 27 Jan 2015 13:01:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 2AA0F2E0D8
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:01:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id ED1DB120C
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:01:58 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id DE1C295B
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:01:58 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id DB2A43E23E
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:01:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I'm trying to set up a simple device tree framework so I can do some =

development on an I2S driver. I'm trying to use simple-audio-card, but I =

keep running into the problem that once soc_bind_dai_link() gets called,
dai_link->platform is set to NULL (because it is not initialized by =

simple-card.c when there is a DT node), while dai_link->platform_of_node =

has been set to dai_link->cpu_of_node in asoc_simple_card_parse_of().

This results in the following code in soc-core:soc_bind_dai_link() to set =

platform to NULL, =


        /* if there's no platform we match on the empty platform */
        platform_name =3D dai_link->platform_name;
        if (!platform_name && !dai_link->platform_of_node)
                platform_name =3D "snd-soc-dummy";

        /* find one from the set of registered platforms */
        list_for_each_entry(platform, &platform_list, list) {
                if (dai_link->platform_of_node) {
                        if (platform->dev->of_node !=3D
                            dai_link->platform_of_node)
                                continue;
                } else {
                        if (strcmp(platform->component.name, platform_name))
                                continue;
                }

                rtd->platform =3D platform;
        }
        if (!rtd->platform) {
                dev_err(card->dev, "ASoC: platform %s not registered\n",
                        dai_link->platform_name);
                return -EPROBE_DEFER;
        }

with -EPROBE_DEFER as a result.

I can't figure out either how to set up a platform (=3DDMA) driver in this =

environment. Perhaps the case of having a CPU DAI, DMA driver and codec =

DAI is not supported by simple-audio-card?

On other hand, the way it looks there is no way the resulting setup can =

get through soc_bind_dai_link() unless there is a platform and associated =

driver.

This indicates to me that I'm doing something seriously wrong in my setup, =

but having looked at various DT configurations in arch/arm/boot/dts in =

this case, as well as the documentation in =

Documentation/devicetree/bindings/sound/simple-card.txt I can't figure how
to set it up any other way.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
