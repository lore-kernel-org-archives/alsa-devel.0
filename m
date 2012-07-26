From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RESEND] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Thu, 26 Jul 2012 10:52:29 +0300
Message-ID: <5010F73D.6020904@ti.com>
References: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
 <20120725131507.GM3099@opensource.wolfsonmicro.com> <500FF709.9060205@ti.com>
 <20120725214837.GQ3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
 [74.125.149.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FAB1264EF5
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 09:51:53 +0200 (CEST)
Received: by yenl13 with SMTP id l13so1694391yen.34
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 00:51:54 -0700 (PDT)
In-Reply-To: <20120725214837.GQ3099@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 07/26/2012 12:48 AM, Mark Brown wrote:
> Please just send the build fix with a followup adding the DT bindings
> and then we can get the DT bindings in for 3.7.

We do not have build breakage as of now since the DT bindings are not in.
The build breakage happened on my local tree when I have rebased it on
mainline yesterday. Stephen can not update the DT part of the omap-abe-twl6=
040
when he did the snd_soc_dai_link cleanup, obviously.
The patch has been updated to compile cleanly on top of current mainline. I
could have prefixed it as v4 but the change compared to the previous was sm=
all.

> It's unfortunate that
> Liam's been so busy and things like this got dropped on the floor but
> I'm not enthusiastic adding something like this after the pull request
> went to Linus.

Yes, I understand your hesitation. On the other hand the patches to enable
audio via DT for the dts files has been merged and present in mainline alre=
ady
(omap4-sdp/panda/pandaES).

> Though obviously it's not even been compiled in mainline :/

Sure it has not been compiled in mainline. It was/is compiled on top of
mainline during my daily work.

> In general you need to really start paying attention to this stuff
> and start chasing around -rc5 or so.

I know, I should have...

-- =

P=E9ter
