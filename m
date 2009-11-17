From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Null suspend/resume functions
Date: Tue, 17 Nov 2009 23:14:04 +0100
Message-ID: <200911172314.04396.rjw@sisk.pl>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com> <aec7e5c30911170446n71031671i48aca11f5276405d@mail.gmail.com> <20091117125901.GF823@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756007AbZKQWMd@vger.kernel.org>
In-Reply-To: <20091117125901.GF823@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 November 2009, Mark Brown wrote:
> On Tue, Nov 17, 2009 at 09:46:35PM +0900, Magnus Damm wrote:
> 
> > On SuperH we have Runtime PM enabled on a few platforms together with
> > a few updated drivers. The latest driver to become more power aware is
> > this FSI driver.
> 
> I understand exactly what the runtime PM stuff and the driver are doing
> here, the issue is the mandatory suspend and resume functions.
> 
> > At this point the SuperH specific platform bus code requires the
> > callbacks ->runtime_suspend() and ->runtime_resume() to be present. It
> > may be a good idea to allow them to be NULL in the future or maybe
> > having some shared functions, but before starting to break out stuff
> > I'd like to see how other Runtime PM implementations deal with this.
> > So unless people object I prefer to keep it as-is for now.
> 
> What is the reason for requiring that the driver provide stub functions?
> For me the issue is that if it's mandatory for the driver to provide the
> functions then having stub functions in there makes the driver look like
> it is abusing the API by not implementing mandatory functionality.

In fact, it's not mandatory for bus types, not for drivers.  IMO bus types
really have to know how to suspend a device and how to resume it,
otherwise the core framework won't be useful anyway.  What the bus type does
about drivers not implementing ->runtime_suspend() or ->runtime_resume(), it's
up to the bus type.  That's even documented IIRC.

Thanks,
Rafael
