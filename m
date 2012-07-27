From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Fri, 27 Jul 2012 15:55:41 -0700
Message-ID: <1343429741.6396.74.camel@adam>
References: <1331939409.22414.29.camel@adam> <s5hty1nh7i6.wl%tiwai@suse.de>
 <1343253173.6396.8.camel@adam> <s5htxwv6plt.wl%tiwai@suse.de>
 <1343366802.6396.48.camel@adam> <s5hpq7hr5xa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C343265F58
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2012 00:55:42 +0200 (CEST)
In-Reply-To: <s5hpq7hr5xa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-07-27 at 09:58 +0200, Takashi Iwai wrote:
> At Thu, 26 Jul 2012 22:26:42 -0700,
> Adam Williamson wrote:
> > 
> > On Thu, 2012-07-26 at 07:47 +0200, Takashi Iwai wrote:
> > 
> > > > I don't know if tiwai's later suggestion to try the sound.git tree is
> > > > still relevant, since I expect all of the stuff there that was 'new'
> > > > back in March has been merged into later kernels since, and it's still
> > > > broken. But if so, send me the word and I'll try it.
> > > > 
> > > > Thanks! I promise to reply more promptly for the next few weeks at
> > > > least.
> > > 
> > > OK, then try the following two patches.
> > > The first one is to make the speaker-pin as the primary output like
> > > the earlier kernel (3.1.x), and the second one is to add the COEF
> > > setup for ALC889.  Check each of them alone gives any difference.
> > 
> > First patch on its own - alc-no-primary-hp-out.diff - fixes the bug.
> > Output through the speakers works. I also tested that it doesn't do
> > anything bad to the speaker/headphone output: plugging in headphones
> > routes the output through that socket automatically, no need to change
> > any PA setting, and unplugging the headphones sends it back through the
> > internal speakers again. The internal mic works fine in all cases. So
> > with just the first patch, everything works correctly as far as I can
> > test (I don't have an external mic to check).
> 
> OK, then it becomes interesting.
> It seems that the hardware has some hard-coded pin assignment and
> doesn't allow to use the different route.
> 
> Could you verify that the following patch works?  Drop the previous
> patches when you apply this.

OK, a re-diffed version of that patch against 3.5 works. (For the
record, it looks like it's against a newer version of the file than is
included in 3.5, and also it seems to have spaces in place of tabs - not
sure if that's a problem on your end or on mine). So that looks good to
me, assuming none of the stuff on the Launchpad bug is a roadblock.
Thanks! One small nit: it's just the 'Vaio Z', not 'Vaio TT Z'. 'Vaio
TT' is a separate (rather older) system; there's no such thing as a 'TT
Z', to my knowledge. You might want to say 'some Vaio Zs', or something
like that, since there have been several generations of the Z, some of
which this won't apply to...
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
