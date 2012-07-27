From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Fri, 27 Jul 2012 11:20:56 -0700
Message-ID: <1343413256.6396.50.camel@adam>
References: <1331939409.22414.29.camel@adam> <s5hty1nh7i6.wl%tiwai@suse.de>
 <1343253173.6396.8.camel@adam> <s5htxwv6plt.wl%tiwai@suse.de>
 <1343366802.6396.48.camel@adam> <s5hpq7hr5xa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id BD001265E59
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 20:20:58 +0200 (CEST)
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

The patch fails utterly to apply against 3.5 - 6 out of 6 hunks failed.
What's it against? 3.4? Fedora went to 3.5 yesterday...I guess I can
re-diff.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
