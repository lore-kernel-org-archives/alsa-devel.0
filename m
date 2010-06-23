From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [PATCH] Add volume resolution quirk for some
 logitech webcams
Date: Wed, 23 Jun 2010 14:08:32 +0200
Message-ID: <1277294912.22499.0.camel@zwerg>
References: <1277285687-10897-1-git-send-email-bug-track@fisher-privat.net>
	<20100623114603.GA2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E53D52446E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 14:08:43 +0200 (CEST)
In-Reply-To: <20100623114603.GA2698@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, den 23.06.2010, 13:46 +0200 schrieb Daniel Mack:
> On Wed, Jun 23, 2010 at 11:34:47AM +0200, Alexey Fisher wrote:
> > Some programs like Skype trying to set capture volume automatically.
> > Normally it will tray carefully, step by step lover or higher the volume.
> > In real word it work not really well, because devises and vendors lie
> > about real audio settings. For example most Logitech webcams
> > have 6400 or 3500 steps for capture volume. They do not tell that
> > actual resolution is 384. So we have only 7 or 18 real steps.
> > In this patch I set real resolution only for tested devices.
> > 
> > Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
> > ---
> >  sound/usb/mixer.c |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 6939d0f..fd9f377 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -1107,6 +1107,18 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
> >  		}
> >  		break;
> >  
> > +	case USB_ID(0x046d, 0x0809):
> > +	case USB_ID(0x046d, 0x0991):
> > +	/* most audio usb divise lighe about volume resolution.
> > +	 * most of them have res = 384. Proboly there is some magick behind
> > +	 * this number. */
> 
> While the change itself is acceptable, there are too many typos in this
> comment ;) Can you please fix them up, please?

shame on me.
