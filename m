From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 02/13] dt-bindings: Add SLIMbus bindings
Date: Fri, 17 Nov 2017 09:25:56 +0530
Message-ID: <20171117035556.GJ3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-3-srinivas.kandagatla@linaro.org>
 <20171116130914.GU3187@localhost>
 <a32232fc-3995-60f6-878e-76aaed4c52d6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a32232fc-3995-60f6-878e-76aaed4c52d6-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 01:40:13PM +0000, Srinivas Kandagatla wrote:
> Thanks for the review comments.
> 
> On 16/11/17 13:09, Vinod Koul wrote:
> >On Wed, Nov 15, 2017 at 02:10:32PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >>From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >
> >>+
> >>+Child nodes:
> >>+Every SLIMbus controller node can contain zero or more child nodes
> >>+representing slave devices on the bus. Every SLIMbus slave device is
> >>+uniquely determined by the enumeration address containing 4 fields:
> >>+Manufacturer ID, Product code, Device index, and Instance value for
> >>+the device.
> >>+If child node is not present and it is instantiated after device
> >>+discovery (slave device reporting itself present).
> >
> >So you allow the devices to work even if the respective firmware description
> >is absent?
> Yes, As SLIMbus itself itself is discoverable bus.

Okay, in SDW we mandate description be present in respective firmwares so we
dont have this path. In theory this never works for you as driver cant load
without device being created and without driver load device is not powered
up so can't report...

> >>+In some cases it may be necessary to describe non-probeable device
> >>+details such as non-standard ways of powering up a device. In
> >>+such cases, child nodes for those devices will be present as
> >>+slaves of the slimbus-controller, as detailed below.
> >>+
> >>+Required property for SLIMbus child node if it is present:
> >>+- reg		- Should be ('Device index', 'Instance ID') from SLIMbus
> >>+		  Enumeration  Address.
> >>+		  Device Index Uniquely identifies multiple Devices within
> >>+		  a single Component.
> >>+		  Instance ID Is for the cases where multiple Devices of the
> >>+		  same type or Class are attached to the bus.
> >>+
> >>+- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
> >>+	 	  Product Code, shall be in lower case hexadecimal with leading
> >>+		  zeroes suppressed
> >>+
> 
> >>+		codec: wcd9310@1,0{
> >>+			compatible = "slim217,60";
> >>+			reg = <1 0>;
> >>+		};
> >>+	};
> >
> >Pardon my ignorance as I am not very familiar with DT nodes, but where are
> >the Manufacturer ID, Product code, Device index, and Instance values here?
> 
> Manfacturer ID and Product code is part of compatible string
> Device index and Instance value are part of reg.

hmmm, wouldn't it be more helpful to have a field(s) for these which contain
these numbers rather than coded together in a word

compatible makes sense though

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
