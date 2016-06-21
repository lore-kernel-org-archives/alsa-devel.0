From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add function to search for named child of device
Date: Tue, 21 Jun 2016 17:11:41 +0200
Message-ID: <1688032.bsOGLjkyBG@vostro.rjw.lan>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com> <28758107.YROb1rVtm6@vostro.rjw.lan> <2E89032DDAA8B9408CB92943514A0337D46442AB@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D46442AB-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J.Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Sathyanarayana
List-Id: alsa-devel@alsa-project.org

On Tuesday, June 21, 2016 11:50:01 AM Opensource [Adam Thomson] wrote:
> 21 June 2016 12:42, Rafael J. Wysocki wrote:
> 
> > > > +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> > > > +					const char *name)
> > > > +{
> > > > +	return is_acpi_data_node(fwnode) ?
> > > > +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
> > > > +}
> > >
> > > Looks fine to me.
> > >
> > > One question - is it expected that matching ACPI data nodes is always
> > > case insensitive?
> > 
> > That would not be a correct expectation in theory, although I don't think it
> > really matters in practice.
> 
> From my reading of the Hierarchical Data Extension and ACPI Spec, I thought
> that was the case (section 19.3.1 ASL Names - ASL names are not case-sensitive
> and will be converted to upper case).

Section 19.3.1 is applicable to object names and not to the data returned
by those objects.  The link names in the Hierarchical Data Extension are
data returned by _DSD (or other objects related to it).  They are general ACPI
strings and those are case-sensitive.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
