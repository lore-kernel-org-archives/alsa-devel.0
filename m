From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp
	software reset
Date: Thu, 23 Aug 2018 17:08:07 -0700
Message-ID: <20180824000807.GF53155@dtor-ws>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
 <20180823095107.GA5207@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 7481126773B
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2018 02:08:12 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id k8-v6so3434514pgq.5
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 17:08:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180823095107.GA5207@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 23, 2018 at 10:51:07AM +0100, Mark Brown wrote:
> On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
> > On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
> > > +       mdelay(10);
> 
> > Is it really necessary for the CPU to spin for 10msec here?
> > usleep_range() would be better solution.
> 
> Or msleep() for that matter, it's not going ot be the end of the world
> if we delay a bit too long.

Frankly, I'd rather we did not introduce extra delays. I do not know if
we use this part, but on ChromeOS we are interested in shaving as much
from the boot time as possible and 10 msecs here and 10 msecs there do
add up.

Thanks.

-- 
Dmitry
