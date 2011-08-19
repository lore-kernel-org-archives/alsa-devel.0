From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ucm: change msleep to usleep
Date: Fri, 19 Aug 2011 16:13:06 +0800
Message-ID: <20110819081306.GD3943@guanqun-laptop.sh.intel.com>
References: <20110819072217.4790.29949.stgit@localhost6.localdomain6>
	<s5hpqk1luh6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B911103905
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 10:13:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpqk1luh6.wl%tiwai@suse.de>
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
Cc: ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Fri, Aug 19, 2011 at 03:40:37PM +0800, Takashi Iwai wrote:
> At Fri, 19 Aug 2011 15:22:17 +0800,
> Lu Guanqun wrote:
> > 
> > In file src/ucm/parser.c:
> > 	if (strcmp(cmd, "usleep") == 0) {
> > string `usleep' is compared, however, in the comment and example conf file,
> > `msleep' is used, it's better to unify them all.
> 
> Don't we scale the value appropriately (although it's just a demo)?

No.

This is where the value gets set in src/ucm/parser.c:

	if (strcmp(cmd, "usleep") == 0) {
		curr->type = SEQUENCE_ELEMENT_TYPE_SLEEP;
		err = snd_config_get_integer(n, &curr->data.sleep);
		if (err < 0) {
			uc_error("error: usleep requires integer!");
			return err;
		}
		continue;
	}       

This is where it gets used in src/ucm/main.c:

	case SEQUENCE_ELEMENT_TYPE_SLEEP:
		usleep(s->data.sleep);
		break;

I don't see it gets scaled somewhere...

I agree it's a demo, but as the documentation for UCM is very limited,
the wrong variable will get users into confusion.

> 
> 
> Takashi
> 
> > 
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> > ---
> >  src/ucm/parser.c              |    8 ++++----
> >  test/ucm/TestHDA/TestHDA.conf |    2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/src/ucm/parser.c b/src/ucm/parser.c
> > index 23b67bc..a56f1e6 100644
> > --- a/src/ucm/parser.c
> > +++ b/src/ucm/parser.c
> > @@ -792,7 +792,7 @@ static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
> >   *	EnableSequence [
> >   *		cset "name='Master Playback Switch',index=2 0,0"
> >   *		cset "name='Master Playback Volume',index=2 25,25"
> > - *		msleep 50
> > + *		usleep 50
> >   *		cset "name='Master Playback Switch',index=2 1,1"
> >   *		cset "name='Master Playback Volume',index=2 50,50"
> >   *	]
> > @@ -800,14 +800,14 @@ static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
> >   *	DisableSequence [
> >   *		cset "name='Master Playback Switch',index=2 0,0"
> >   *		cset "name='Master Playback Volume',index=2 25,25"
> > - *		msleep 50
> > + *		usleep 50
> >   *		cset "name='Master Playback Switch',index=2 1,1"
> >   *		cset "name='Master Playback Volume',index=2 50,50"
> >   *	]
> >   *
> >   *      # Optional transition verb
> >   *      TransitionSequence."ToCaseName" [
> > - *		msleep 1
> > + *		usleep 1
> >   *      ]
> >   *
> >   *	# Optional TQ and ALSA PCMs
> > @@ -1106,7 +1106,7 @@ static int parse_controls(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg)
> >   *	cset "name='Master Mono Playback Volume',index=1 0"
> >   *	cset "name='PCM Switch',index=2 1,1"
> >   *      exec "some binary here"
> > - *      msleep 50
> > + *      usleep 50
> >   *	........
> >   * ]
> >   *
> > diff --git a/test/ucm/TestHDA/TestHDA.conf b/test/ucm/TestHDA/TestHDA.conf
> > index 41dd74c..0a75e21 100644
> > --- a/test/ucm/TestHDA/TestHDA.conf
> > +++ b/test/ucm/TestHDA/TestHDA.conf
> > @@ -7,7 +7,7 @@ SectionUseCase."Case1" {
> >  
> >  SectionDefaults [
> >  	exec "my prg"
> > -	msleep 1
> > +	usleep 1
> >  	cdev "hw:0"
> >  	cset "name='PCM Playback Volume' 50%"
> >  ]
> > 

-- 
guanqun
