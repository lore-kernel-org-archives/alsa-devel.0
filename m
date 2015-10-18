From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Sun, 18 Oct 2015 21:43:29 +0530
Message-ID: <20151018161329.GV27370@localhost>
References: <5620E482.6050507@ti.com> <5620EE2F.8070504@metafoo.de>
 <20151016133717.GI32532@n2100.arm.linux.org.uk>
 <20151018150834.GP27370@localhost>
 <20151018152048.GT32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AD741264EE5
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 18:10:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151018152048.GT32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 18, 2015 at 04:20:48PM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 18, 2015 at 08:38:34PM +0530, Vinod Koul wrote:
> > On Fri, Oct 16, 2015 at 02:37:17PM +0100, Russell King - ARM Linux wrote:
> > > I've sent one proposal which uses a notifier to inform audio and CEC
> > > drivers about state changes in the HDMI video side, and had precisely
> > > zero replies to it - people seemed to prefer discussing stuff rather
> > > than reviewing code and coming up with actual solutions.
> > 
> > Do you mind sending me a pointer to this series, I would like to read this
> > up
> 
> It isn't a series.  It's a prototype patch that I posted in one of the
> previous threads earlier this month:
> 
> Date: Tue, 6 Oct 2015 19:51:57 +0100
> Subject: Re: [alsa-devel] [PATCH RFC V2 0/5] another generic audio hdmi codec
>  proposal
> Message-ID: <20151006185157.GT21513@n2100.arm.linux.org.uk>
> 
> As I've said there, audio is not the only issue here, CEC also needs to
> have access to much the same information that audio needs.
> 
> CEC needs to know two things: when the HDMI sink is disconnected, and
> when the HDMI sink's EDID is available (specifically, CEC needs to know
> the HDMI physical address for itself, which is passed as a number via
> the EDID HDMI vendor block.)

Right but can I ask why you didn't try making video as component and then
CEC, audio and others receive the notification over this. I don't know if
there are any limitations to this since you wrote component bits you are the
best person to comment...

-- 
~Vinod
