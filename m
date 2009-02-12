From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 0/4] Intel HDMI audio fixes
Date: Thu, 12 Feb 2009 12:41:11 +0800
Message-ID: <20090212044111.GA14061@localhost>
References: <20090211072227.760779741@intel.com>
	<20090211223241.GA31322@csy.ca> <s5hfxik8ukn.wl%tiwai@suse.de>
	<20090211225448.GA32203@csy.ca> <s5hab8s8tm6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 13F6D1037EE
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 05:41:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hab8s8tm6.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 12, 2009 at 01:02:41AM +0200, Takashi Iwai wrote:
> At Wed, 11 Feb 2009 14:54:48 -0800,
> Shane W wrote:
> > 
> > On Wed, Feb 11, 2009 at 11:42:00PM +0100, Takashi Iwai wrote:
> > > At Wed, 11 Feb 2009 14:32:41 -0800,
> > > Shane W wrote:
> > > > missing.  The order in the wav is:
> > > > front left
> > > > centre
> > > > front right
> > > > rear left
> > > > rear right
> > > > sub buz
> > > 
> > > The order assumed here doesn't match with ALSA mapping.
> > > In ALSA,
> > >   front left
> > >   front right
> > >   rear left
> > >   rear right
> > >   center
> > >   LFE
> > 
> > Sorry I meant the spoken order, I've no idea what the
> > channel mapping of a 6 channel wav is.
> > 
> > > Better to test with speaker-test program whether the mapping is
> > > correct.
> > 
> > Ah didn't know about this program.  Ok results with:
> > speaker-test -D hw:0,3 -s n
> > where n ranged from 0 to 6
> > 
> > -s 1 speaker-test says front left actual is front left
> > likewise with -s 2 for front right
> > -s 3 speaker-test says should be rear left actual is lfe
> > that is the sound came from lfe
> > -s 4 speaker-test says rear right actual is centre
> > -s 5 speaker-test says centre actual was rear left
> > and -s 6 speaker-test says lfe actual is rear right
> 
> Thanks.  Also make sure that you pass -c 6 option.

If I understand it right, the ALSA channel sequence is defined in
speaker-test as:

        static const char        *channel_name[MAX_CHANNELS] = {
          /*  0 */ N_("Front Left"),
          /*  1 */ N_("Front Right"),
          /*  2 */ N_("Rear Left"),
          /*  3 */ N_("Rear Right"),
          /*  4 */ N_("Center"),       /* wav file is "Front Center.wav" */
          /*  5 */ N_("LFE"),          /* wav file is "Rear Center.wav" */
          /*  6 */ N_("Side Left"),
          /*  7 */ N_("Side Right"),

Whereas the HDMI channel mapping selected for 6-channel playback is

        { .ca_index = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,  FL } },

Here the two mappings disagree on channels other than Front Left/Right.

In theory the channel mapping should be adjusted via AC_VERB_SET_HDMI_CHAN_SLOT.
However I found that verb takes no effect for G35/G45. So I'm afraid
there's no trivial ways we can adjust the channel mapping.

Thanks,
Fengguang
