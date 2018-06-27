From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH tinycompress] cplay: Stop playback stream
 at the end
Date: Wed, 27 Jun 2018 17:21:31 +0530
Message-ID: <20180627115130.GI22377@vkoul-mobl>
References: <1530085691-27736-1-git-send-email-daniel.baluta@nxp.com>
 <20180627102424.GH22377@vkoul-mobl>
 <1530098114.2102.36.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F741267973
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:51:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1530098114.2102.36.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 27-06-18, 11:15, Daniel Baluta wrote:
> On Mi, 2018-06-27 at 15:54 +0530, Vinod wrote:
> > On 27-06-18, 10:48, Daniel Baluta wrote:
> > > =

> > > Each compress_start should have a corresponding compress_stop
> > > at the end.
> > > =

> > > Also, this gives user a change to cleanup resources that might
> > > have been allocated in compress_start.
> > I think the assumptions are not quite correct here, resources should
> > be
> > allocated in .open and cleanup in .free for driver callback.
> > =

> > > =

> > > =

> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > > I'm implementing codec library dynamic loading at runtime and I'm
> > > exploring
> > > using:
> > > 	* SNDRV_COMPRESS_START -> to load the library
> > > 	* SNDRV_COMPRESS_STOP=A0=A0-> to unload the library
> > > =

> > > This might not be the best idea becasue for example loading
> > > the library might introduce some delays, anyhow i still think
> > > this that compress_stop is correct thing to add at the end of
> > > playback.
> > I think you should tie the library load to much earlier in path. Not
> > in
> > start.
> > =

> > Also, we invoke drain and hence there is no need of stop
> =

> Got your point here.=A0
> =

> Perhaps,
> =

> =A0- use .hw_params to load the codec library.
> =A0- add .hw_free (as Liam suggested in a separate email) to unload the =
=A0 =A0 =A0codec library.

Sure, sounds better design to me

> =

> Thanks we can drop this patch then.

Okay

-- =

~Vinod
