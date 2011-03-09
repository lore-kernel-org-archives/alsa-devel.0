From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix prefixing of DAPM controls by
 factoring prefix into snd_soc_cnew()
Date: Wed, 9 Mar 2011 13:35:56 +0200
Message-ID: <20110309133556.68c380dd.jhnikula@gmail.com>
References: <1299605103-13079-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1299607281.3374.13.camel@odin>
	<20110309101951.18c804f5.jhnikula@gmail.com>
	<20110309110314.GF6923@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 37C31245D8
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:34:11 +0100 (CET)
Received: by ewy28 with SMTP id 28so106086ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:34:11 -0800 (PST)
In-Reply-To: <20110309110314.GF6923@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Mar 2011 11:03:14 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Mar 09, 2011 at 10:19:51AM +0200, Jarkko Nikula wrote:
> 
> > Unfortunately this leads to double prefixing to mixer and mux controls
> > on Nokia RX-51/N900 in today's head. Reason there is that the
> > snd_soc_dapm_new_control has already added the prefix to widget name
> > and the dapm_new_mixer/mux takes this prefixed w->name and prefixes it
> > again.
> 
> The system I'm using isn't affected as there's no unnamed mixers in it.
> I rather suspect this means that the old code is broken for named
> mixers.  Working on a fix just now.

Yeah, just realized the prefixing indeed was broken originally for named
mixers in sound/soc/soc-dapm.c: dapm_new_mixer as only w->name carried
the prefix and which is not included for snd_soc_dapm_mixer_named_ctl
case. My bad...

switch (w->id) {
default:
	snprintf(path->long_name, name_len, "%s %s",
		 w->name, w->kcontrols[i].name);
	break;
case snd_soc_dapm_mixer_named_ctl:
	snprintf(path->long_name, name_len, "%s",
		 w->kcontrols[i].name);
	break;
}


-- 
Jarkko
