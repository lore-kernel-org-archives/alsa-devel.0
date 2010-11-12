From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 2/3] ASoC: Move widgets from DAPM context
 to snd_soc_card
Date: Fri, 12 Nov 2010 15:57:56 +0200
Message-ID: <20101112155756.bd8a95be.jhnikula@gmail.com>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<1289553806-28625-3-git-send-email-jhnikula@gmail.com>
	<20101112131840.GB17283@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A22E103949
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 14:58:12 +0100 (CET)
Received: by eyg24 with SMTP id 24so1748313eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 05:58:12 -0800 (PST)
In-Reply-To: <20101112131840.GB17283@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2010 13:18:41 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Nov 12, 2010 at 11:23:25AM +0200, Jarkko Nikula wrote:
> 
> > Cross-device paths are registered by listing the widgets from device A in
> > a map for device B. An example below shows a path that connects MONO out of
> > A into Line In of B:
> 
> > static const struct snd_soc_dapm_route mapA[] = {
> > 	{"MONO", NULL, "DAC"},
> > };
> 
> > static const struct snd_soc_dapm_route mapB[] = {
> > 	{"Line In", NULL, "MONO"},
> > };
> 
> This is going to fall over if we have widgets in two devices with the
> same name (and especially if we have two devices of the same kind in the
> system).  Adding source device names to the paths would probably cover
> it with the same format but it should be considered and noted here.
> 
That's the reason why the code favors a widget from current DAPM
context in snd_soc_dapm_add_route so that no current machine would
(hopefully) break because of this patch.

Of course any new code implementing cross-device paths between codecs
with conflicting widget names would need the name prefixing stuff also.

> >  struct snd_soc_dapm_context {
> > -	struct list_head widgets;
> > +	int n_widgets; /* number of widgets in this context */
> 
> I'm not sure why we need to count the number of widgets here; 
> 
True, this should go the next patch actually.

> > index 835087d..77be6b3 100644
> > --- a/include/sound/soc.h
> > +++ b/include/sound/soc.h
> > @@ -618,6 +618,7 @@ struct snd_soc_card {
> >  	struct list_head platform_dev_list;
> >  	struct list_head dai_dev_list;
> >  
> > +	struct list_head widgets;
> >  	struct list_head paths;
> >  
> 
> If we keep moving stuff into the card it's questionable what the context
> is buying us...

DAPM context represent the parent device (codecs currently and other
devices in someday) and its state so I don't see we'll be removing it in
near future even now the widgets and paths are moved to card.


-- 
Jarkko
