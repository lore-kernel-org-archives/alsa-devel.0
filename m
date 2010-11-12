From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 2/3] ASoC: Move widgets from DAPM context
 to snd_soc_card
Date: Fri, 12 Nov 2010 16:25:54 +0200
Message-ID: <20101112162554.3f5240df.jhnikula@gmail.com>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<1289553806-28625-3-git-send-email-jhnikula@gmail.com>
	<20101112131840.GB17283@rakim.wolfsonmicro.main>
	<20101112155756.bd8a95be.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B576E103943
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 15:26:09 +0100 (CET)
Received: by ewy26 with SMTP id 26so1761798ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 06:26:09 -0800 (PST)
In-Reply-To: <20101112155756.bd8a95be.jhnikula@gmail.com>
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

On Fri, 12 Nov 2010 15:57:56 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Fri, 12 Nov 2010 13:18:41 +0000
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > >  struct snd_soc_dapm_context {
> > > -	struct list_head widgets;
> > > +	int n_widgets; /* number of widgets in this context */
> > 
> > I'm not sure why we need to count the number of widgets here; 
> > 
> True, this should go the next patch actually.
> 
Not true, it is actually need here. We cannot detect widgetless codecs
by testing list_empty(&card->widgets) after moving widgets from dapm
to card so we must keep count of widgets for each DAPM context (device).

-	if (list_empty(&dapm->widgets)) {
+	if (!dapm->n_widgets) {


-- 
Jarkko
