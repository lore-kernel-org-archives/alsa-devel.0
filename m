From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2] drm/i915: set proper N/CTS in modeset
Date: Tue, 13 Oct 2015 17:30:54 +0300
Message-ID: <20151013143054.GQ26517@intel.com>
References: <1443144972-81982-1-git-send-email-libin.yang@intel.com>
 <561D0A61.3090802@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C695@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 49173265AB9
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:31:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <96A12704CE18D347B625EE2D4A099D1974C695@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Vetter <daniel@ffwll.ch>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 02:21:31PM +0000, Yang, Libin wrote:
> + gfx driver team.
> =

> Hi David,
> =

> > -----Original Message-----
> > From: David Henningsson [mailto:david.henningsson@canonical.com]
> > Sent: Tuesday, October 13, 2015 9:43 PM
> > To: alsa-devel@alsa-project.org; Yang, Libin
> > Subject: Re: [alsa-devel] [PATCH v2] drm/i915: set proper N/CTS in
> > modeset
> > =

> > =

> > =

> > On 2015-09-25 03:36, libin.yang@intel.com wrote:
> > > @@ -24,8 +24,18 @@
> > >   #ifndef _I915_COMPONENT_H_
> > >   #define _I915_COMPONENT_H_
> > >
> > > +/* MAX_PORT is the number of port
> > > + * It must be sync with I915_MAX_PORTS defined i915_drv.h
> > > + * 5 should be enough as only HSW, BDW, SKL need such fix.
> > > + */
> > > +#define MAX_PORTS 5
> > > +
> > >   struct i915_audio_component {
> > >   	struct device *dev;
> > > +	/**
> > > +	 * @aud_sample_rate: the array of audio sample rate per port
> > > +	 */
> > > +	int aud_sample_rate[MAX_PORTS];
> > =

> > Just a quick question as I was trying to understand the code:
> > =

> > aud_sample_rate seems only set and get on the i915 side, never on the
> > hda side.
> > =

> > In short, why is this variable here, and not in e g, as a single integer
> > in the intel_digital_port struct?
> > =

> > That way we also avoid the possibility of MAX_PORTS becoming out of
> > sync
> > with the i915 side.
> =

> Put it in struct i915_audio_component just because it is audio related and
> easy for management.
> =

> It seems to put it in intel_digital_port will be easier.

IIRC that's more or less how I pseudo-coded it in one of my replies in
one of the threads discussing this... =


Yeah here
http://lists.freedesktop.org/archives/intel-gfx/2015-August/074267.html

-- =

Ville Syrj=E4l=E4
Intel OTC
