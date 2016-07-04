From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/7] of_graph: prepare for ALSA graph support
Date: Mon, 4 Jul 2016 11:07:36 -0500
Message-ID: <20160704160736.GA25708@rob-hp-laptop>
References: <87k2h8g7rr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87k2h8g7rr.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2016 at 12:33:15AM +0000, Kuninori Morimoto wrote:
> 
> Hi Rob
> 
> These are v2 of of_graph patch-set
> 
> Now OF graph is mainly used by V4L2 SoC, and ALSA SoC is using
> different style for SoC <-> Codec binding.
> But, for example, HDMI case, V4L2 <-> ALSA need to collaborate,
> and then ALSA SoC needs to adjust to OF graph.
> 
> OTOH, V4L2's "OF graph" position is same as ALSA SoC "sound card" position.
> And ALSA SoC side want to keep existing supported feature on new
> OF graph style. I'm posting this on ALSA SoC ML now.
> 
> Now, current of_graph is indicating port/endpoint,
> but there is no way to understand that it is for video port ? or sound port ?
> or other device port ?

I need to see how you want to use this. I'm not completely convinced 
this is necessary as the port number should be meaningful. For example, 
port 0 is video and port 1 is audio. This information is specific to the 
local parent node which could be problematic if you have generic code 
parsing the local node. However, if you know which local port is audio, 
then you know the remote endpoint's port is also the audio port. 

> For example, HDMI has video port, and sound port.
> Because of this reason, ALSA SoC side can't handle OF graph correctly.
> Thus, this patch-set tries to add new "type" on OF graph.
> 
> And this patch-set includes small feature which are useful for ALSA SoC
> side OF graph support.

In general, all these helpers look okay if you have a user for them.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
