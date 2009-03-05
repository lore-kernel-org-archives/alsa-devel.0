From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix long name of control
	for	dapm_switch
Date: Thu, 5 Mar 2009 17:26:26 +0000
Message-ID: <20090305172624.GH2416@sirena.org.uk>
References: <4e1455be0903031747s65097766saea220037d1335ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A36C9244F5
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 18:35:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4e1455be0903031747s65097766saea220037d1335ff@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 10:47:09AM +0900, Joonyoung Shim wrote:
> The length of long control name doesn't include the length of widget
> name at present when widget->id is snd_soc_dapm_switch, so the long
> control name of dapm_switch is shortened.
> To avoid this problem, the long control name only for dapm_mixer_named_ctl
> must have simply the kcontrol name.

This is a good catch - thanks!

Unfortunately your patch doesn't apply against the current topic/asoc
branch of Takashi's repository, I've implemented a slightly different
version of it.

> -                       name_len = strlen(w->kcontrols[i].name) + 1;
> -                       if (w->id == snd_soc_dapm_mixer)
> -                               name_len += 1 + strlen(w->name);
> +                       if (w->id == snd_soc_dapm_mixer_named_ctl)
> +                               name_len = strlen(w->kcontrols[i].name) + 1;
> +                       else
> +                               name_len = 2 + strlen(w->name)
> +                                       + strlen(w->kcontrols[i].name);

Here I just changed the test to != named_ctl.

> 
> -                       switch (w->id) {
> -                       case snd_soc_dapm_mixer:
> -                       default:

Your chanegs here appear to only flip to an if/else from a switch
statement?  Please mention things like this in your commit logs (or
split them into separate patches) - it makes your changes easier to
review.
