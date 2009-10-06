From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH 1/3] ascenario: Fix typedef for
 snd_scenario_t
Date: Tue, 6 Oct 2009 19:08:47 +0200
Message-ID: <20091006170847.GG3181@dodger.lab.datenfreihafen.org>
References: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
	<1254844471-12987-2-git-send-email-stefan@datenfreihafen.org>
	<s5hws381pc0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id A98DD24457
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 19:08:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hws381pc0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stefan Schmidt <stefan@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

Hello.

On Tue, 2009-10-06 at 18:04, Takashi Iwai wrote:
> At Tue,  6 Oct 2009 17:54:29 +0200,
> Stefan Schmidt wrote:
> > 
> > From: Stefan Schmidt <stefan@slimlogic.co.uk>
> > 
> > Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
> > ---
> >  include/ascenario.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/ascenario.h b/include/ascenario.h
> > index 003eabe..0c5acb9 100644
> > --- a/include/ascenario.h
> > +++ b/include/ascenario.h
> > @@ -128,7 +128,7 @@ extern "C" {
> >  #define SND_SCN_INT_QOS				1
> >  
> >  /** Scenario container */
> > -typedef snd_scenario_t snd_scenario_t;
> > +typedef struct _snd_scenario_t snd_scenario_t;
> 
> I would define like
> 
>   typedef struct snd_scenario snd_scenario_t;

Fine with me. I just followed what I have seen in control.h here. Will send an
updated set tomorrow which will have this fixed.

regards
Stefan Schmidt
