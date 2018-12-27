From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] aplay: support no period wakeup option in
	argument
Date: Thu, 27 Dec 2018 06:46:57 +0000
Message-ID: <AM0PR0402MB3379A907F2E41F7DC17A1E5AE3B60@AM0PR0402MB3379.eurprd04.prod.outlook.com>
References: <1545823678-15563-1-git-send-email-shengjiu.wang@nxp.com>
 <20181226133517.GA25888@workstation>
 <VI1PR0402MB339296BEB0F8566BBD97D1FAE3B60@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <20181227042835.GA5399@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D49267B06
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 07:46:59 +0100 (CET)
In-Reply-To: <20181227042835.GA5399@workstation>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

> -----Original Message-----
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Sent: Thursday, December 27, 2018 12:29 PM
> 
> On Thu, Dec 27, 2018 at 02:13:28AM +0000, S.j. Wang wrote:
> > > -----Original Message-----
> > > From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > > Sent: Wednesday, December 26, 2018 9:35 PM
> > >
> > > Hi,
> > >
> > > On Wed, Dec 26, 2018 at 11:28:11AM +0000, S.j. Wang wrote:
> > > > In the case that alsa driver can't support period wakeup, we need
> > > > to set the no period wakeup flag
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  aplay/aplay.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/aplay/aplay.c b/aplay/aplay.c index
> > > > efc1eb4cae3a..4f562bfe2884 100644
> > > > --- a/aplay/aplay.c
> > > > +++ b/aplay/aplay.c
> > > > @@ -137,6 +137,7 @@ static int use_strftime = 0;  volatile static
> > > > int recycle_capture_file = 0;  static long term_c_lflag = -1;
> > > > static int dump_hw_params = 0;
> > > > +static int no_period_wakeup = 0;
> > > >
> > > >  static int fd = -1;
> > > >  static off64_t pbrec_count = LLONG_MAX, fdcount; @@ -243,6 +244,7
> > > @@
> > > > _("Usage: %s [OPTION]... [FILE]...\n"
> > > >  "    --use-strftime      apply the strftime facility to the output file
> name\n"
> > > >  "    --dump-hw-params    dump hw_params of the device\n"
> > > >  "    --fatal-errors      treat all errors as fatal\n"
> > > > +"    --no-period-wakeup  set no period wakeup flag if necessary\n"
> > > >    )
> > > >  		, command);
> > > >  	printf(_("Recognized sample formats are:")); @@ -429,6 +431,7 @@
> > > > enum {
> > > >  	OPT_USE_STRFTIME,
> > > >  	OPT_DUMP_HWPARAMS,
> > > >  	OPT_FATAL_ERRORS,
> > > > +	OPT_NO_PERIOD_WAKEUP,
> > > >  };
> > > >
> > > >  /*
> > > > @@ -516,6 +519,7 @@ int main(int argc, char *argv[])
> > > >  		{"interactive", 0, 0, 'i'},
> > > >  		{"dump-hw-params", 0, 0, OPT_DUMP_HWPARAMS},
> > > >  		{"fatal-errors", 0, 0, OPT_FATAL_ERRORS},
> > > > +		{"no-period-wakeup", 0, 0, OPT_NO_PERIOD_WAKEUP},
> > > >  #ifdef CONFIG_SUPPORT_CHMAP
> > > >  		{"chmap", 1, 0, 'm'},
> > > >  #endif
> > > > @@ -799,6 +803,9 @@ int main(int argc, char *argv[])
> > > >  		case OPT_FATAL_ERRORS:
> > > >  			fatal_errors = 1;
> > > >  			break;
> > > > +		case OPT_NO_PERIOD_WAKEUP:
> > > > +			no_period_wakeup = 1;
> > > > +			break;
> > > >  #ifdef CONFIG_SUPPORT_CHMAP
> > > >  		case 'm':
> > > >  			channel_map =
> > > snd_pcm_chmap_parse_string(optarg);
> > > > @@ -1396,6 +1403,12 @@ static void set_params(void)
> > > >  							     &buffer_frames);
> > > >  	}
> > > >  	assert(err >= 0);
> > > > +
> > > > +	if (no_period_wakeup) {
> > > > +		err = snd_pcm_hw_params_set_period_wakeup(handle,
> > > params, 0);
> > > > +		assert(err >= 0);
> > > > +	}
> > > > +
> > > >  	monotonic = snd_pcm_hw_params_is_monotonic(params);
> > > >  	can_pause = snd_pcm_hw_params_can_pause(params);
> > > >  	err = snd_pcm_hw_params(handle, params);
> > > > --
> > > > 1.9.1
> > >
> > > As of v4.21-rc1, runtime of PCM substream can't run no_period_wakeup
> > > mode unless two conditions are satisfied[1]:
> > >  - driver supports SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
> > >  - PCM applications set
> SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP
> > > flag to
> > >    hardware parameter structure.
> > >
> > > Neither alsa-lib nor the most of existent userspace applications set
> > > SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP without explicit call of
> helper
> > > API. In this point, I can get your intention for this patch. If a
> > > driver just supports no_period_wakeup mode, such driver can't work
> well.
> > >
> > > However, such driver is problematic because apparently it can not
> > > run with many existent userspace applications and alsa-lib. Before
> > > applying this patch, we have enough discussion to prevent problems
> > > to introduce such problematic drivers into Linux sound subsystem, in
> my opinion.
> >
> > What is helper API?  I found that you have a similar function in
> > axfer/xfer-libasound.c, Which is disable_period_wakeup().  Do you
> > think I need to porting this function to Aplay?
> 
> I focus on your intention itself instead of change of aplay. Here, I refer your
> commit description:
> 
> "In the case that alsa driver can't support period wakeup, we need to set
> the no period wakeup flag"
> 
> In my understanding, your intention is a kind of driver added yet in
> mainline. The driver doesn't adopt period wakeup. It just support no-
> period-wakeup. Thus the driver works without any periodical
> hardware/software IRQs.
> 
> At present, the feature, no-period-wakeup is an option of PCM substream.
> This means that all of in-kernel drivers _should_ adopt period wakeup at
> first. Then, if possible, it can implement no-period-wakeup with the
> optional flag.
> 
> An addition of driver which support no-period-wakeup only brings
> problems to existing applications. For example, execution of ioctl(2) with
> SNDRV_PCM_IOCTL_[READ|WRITE][I|N] can bring below message:
> 
> "%s write error (DMA or IRQ trouble?)"
> 
> This is output in 'wait_for_avail()' of 'sound/core/pcm_lib.c'[1].
> This is because nothing awaken up a task of the execution. With normal
> drivers, the task is awakened by handlers on any IRQ context.
> 
> ALSA drivers should work with such applications, thus it's not good idea to
> develop for such drivers. In a case that hardware has no feature to generate
> periodical IRQs, kernel timer or hrtimer can be available to achieve 'pseudo'
> period wakeup for such drivers.
> 
> If you wish for drivers which don't achieve period wakeup, it's better to
> have enough discussion to change behaviour of ALSA PCM core at first, then
> work for aplay next.
> 
> Please inform me if I misread in your description.

Thanks for the suggestion to use timer in driver. 

I still have two questions:
1. It seems the no-period-wakeup feature should be dropped for it isn't recommended
   By alsa, right?  I still found some driver in kernel support it, what's the reason?

2. Shall we add this option in aplay for it is feature that alsa support, even it is optional?

Best regards
Wang shengjiu
> 
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftiwai%2Fsound.git%2
> Ftree%2Fsound%2Fcore%2Fpcm_lib.c%23n1901&amp;data=02%7C01%7Cshe
> ngjiu.wang%40nxp.com%7C333a2e780d2d4dcf000a08d66bb3d352%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636814817430239208&amp;s
> data=ur11k%2F1mx7U45pj4PpNZcz8M4TdHIQiHxqLszjyNTkQ%3D&amp;reser
> ved=0
> 
> 
> Thanks
> 
> Takashi Sakamoto
