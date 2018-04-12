From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel][PATCH v3 0/5] sndif: add explicit back
 and front synchronization
Date: Thu, 12 Apr 2018 10:31:17 -0400
Message-ID: <20180412143117.GH25481@char.us.oracle.com>
References: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
 <s5hr2oeebui.wl-tiwai@suse.de>
 <2868f1f8-3988-7f25-9b88-8b686866b9ce@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8734E266BBC
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 16:33:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2868f1f8-3988-7f25-9b88-8b686866b9ce@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 21, 2018 at 09:15:36AM +0200, Oleksandr Andrushchenko wrote:
> On 03/20/2018 10:22 PM, Takashi Iwai wrote:
> > On Mon, 19 Mar 2018 08:22:19 +0100,
> > Oleksandr Andrushchenko wrote:
> > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > 
> > > Hello, all!
> > > 
> > > In order to provide explicit synchronization between backend and
> > > frontend the following changes are introduced in the protocol:
> > >   - bump protocol version to 2
> > >   - add new ring buffer for sending asynchronous events from
> > >     backend to frontend to report number of bytes played by the
> > >     frontend (XENSND_EVT_CUR_POS)
> > >   - introduce trigger events for playback control: start/stop/pause/resume
> > >   - add "req-" prefix to event-channel and ring-ref to unify naming
> > >     of the Xen event channels for requests and events
> > >   - add XENSND_OP_HW_PARAM_QUERY request to read/update
> > >     stream configuration space: request passes desired intervals/formats for
> > >     the stream parameters and the response returns allowed intervals and
> > >     formats mask that can be used.
> > > 
> > > Changes since v2:
> > > 1. Konrad's r-b tag for version patch
> > > 2. MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
> > > 3. Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all
> > >     parameters at once, allowing to check all the configuration
> > >     space.
> > > 4. Minor documentation cleanup (added missed "reserved" fields)
> > > 
> > > Changes since v1:
> > > 
> > > 1. Changed protocol version definition from string to integer,
> > > so it can easily be used in comparisons.
> > > Konrad, I have removed your r-b tag for the reason of this change.
> > > 
> > > 2. In order to provide explicit stream parameter negotiation between
> > > backend and frontend the following changes are introduced in the protocol:
> > > add XENSND_OP_HW_PARAM_QUERY request to read/update
> > > configuration space for the parameter given: request passes
> > > desired parameter interval (mask) and the response to this request
> > > returns min/max interval (mask) for the parameter to be used.
> > > 
> > > Parameters supported by this request/response:
> > >   - format mask
> > >   - sample rate interval
> > >   - number of channels interval
> > >   - buffer size, interval, frames
> > >   - period size, interval, frames
> > I can't judge exactly about the protocol without the actual FE/BE
> > implementations, but the change looks good to me, especially if you've
> > already tested something.
> Thank you, I have tested the changes and need them to start upstreaming
> the frontend driver used to test the protocol.
> Do you mind if I put your Acked-by (or you prefer Reviewed-by?) tag to these
> patches:
> 
> [PATCH v3 4/5] sndif: Add explicit back and front synchronization
> [PATCH v3 5/5] sndif: Add explicit back and front parameter negotiation
> 
> Please note, that the changes first to be merged into Xen and then I'll
> prepare
> the same, but for the kernel
> > 
> > If other people have no concern, let's go ahead with FE/BE stuff.
> Konrad, are you ok with the changes?

Yes. Thank you for your persistence.

Can you also add:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> > 
> > thanks,
> > 
> > Takashi
> Thank you,
> Oleksandr
