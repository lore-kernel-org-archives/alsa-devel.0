From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix prefixing of DAPM controls by
 factoring prefix into snd_soc_cnew()
Date: Wed, 9 Mar 2011 10:19:51 +0200
Message-ID: <20110309101951.18c804f5.jhnikula@gmail.com>
References: <1299605103-13079-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1299607281.3374.13.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 949B3103935
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 09:18:08 +0100 (CET)
Received: by ewy28 with SMTP id 28so69678ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 00:18:08 -0800 (PST)
In-Reply-To: <1299607281.3374.13.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ujfalusi <peter.ujfalusi@nokia.com>, patches@opensource.wolfsonmicro.com, Peter@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 08 Mar 2011 18:01:21 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Tue, 2011-03-08 at 17:25 +0000, Mark Brown wrote:
> > Currently will ignore prefixes when creating DAPM controls. Since currently
> > all control creation goes through snd_soc_cnew() we can fix this by factoring
> > the prefixing into that function.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Liam Girdwood <lrg@ti.com>
> 
Unfortunately this leads to double prefixing to mixer and mux controls
on Nokia RX-51/N900 in today's head. Reason there is that the
snd_soc_dapm_new_control has already added the prefix to widget name
and the dapm_new_mixer/mux takes this prefixed w->name and prefixes it
again.

codec driver or soc_probe_codec
 -> snd_soc_dapm_new_controls
  -> snd_soc_dapm_new_control: prefix added to w->name

soc_post_component_init
 -> snd_soc_dapm_new_widgets
  -> dapm_new_mixer/mux: prefix added again to w->name


-- 
Jarkko
