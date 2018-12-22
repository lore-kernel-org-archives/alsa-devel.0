From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control
	codec
Date: Sat, 22 Dec 2018 11:47:30 -0800
Message-ID: <CABXOdTc36qu=oSz3XS07SqwoQM6Dh_CU0o89JariXMe+EBhyBw@mail.gmail.com>
References: <20181206040540.84632-1-cychiang@chromium.org>
 <20181214122156.GT4497@dell> <20181214122245.GU4497@dell>
 <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
 <20181218084307.GH4497@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-f67.google.com (mail-yw1-f67.google.com
 [209.85.161.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBF526798A
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 20:47:43 +0100 (CET)
Received: by mail-yw1-f67.google.com with SMTP id i73so3503230ywg.3
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 11:47:43 -0800 (PST)
In-Reply-To: <20181218084307.GH4497@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, Scott <scollyer@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, Dylan Reid <dgreid@chromium.org>, Benson Leung <bleung@chromium.org>, Cheng-yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 18, 2018 at 12:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 18 Dec 2018, Cheng-yi Chiang wrote:
>
> > +Benson, Guenter, Scott
> >
> > On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Fri, 14 Dec 2018, Lee Jones wrote:
> > >
> > > > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> > > >
> > > > > Add EC host commands to control codec on EC.
> > > > >
> > > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > > ---
> > > > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> > > > >  Codec driver that uses these commands will be sent separately.
> > > > >  Thanks!
> > > > >
> > > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 94 insertions(+)
> > > >
> > > > Would be good to have this reviewed by some more Chrome people.
> > >
> > > See this for reference:
> > >
> > >   https://lore.kernel.org/patchwork/patch/1024985/
> >
> > Hi Benson and Guenter,
> > Could you please review this patch ?
>
> You haven't sent them the patch.
>
> Please resubmit as a [RESEND] and add them as recipients.
>

I was asked separately from one of our engineers if it would be
acceptable to synchronize cros_ec_commands.h with the version from the
EC source. I think that might make more sense than a piece-by-piece
approach.

Thanks,
Guenter
