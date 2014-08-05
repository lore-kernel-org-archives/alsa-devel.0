From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Tue, 5 Aug 2014 09:42:19 -0500
Message-ID: <alpine.DEB.2.02.1408050941520.7394@heelrod>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com>
 <53E05458.6080605@gmail.com> <alpine.DEB.2.02.1408050928220.7394@heelrod>
 <53E0EB20.7040800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E0EB20.7040800-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> > > should match open parenthesis's...
> > > 
> > >   devm_kzalloc(&i2c_client->dev,
> > > 	      sizeof(struct cs35l32_platform_data),
> > > 	      GFP_KERNEL);
> > > 
> > checkpatch?
> > 
> checkpatch should generate warning for this...
> 
> 
It didn't
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
