From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 19:24:04 +0100
Message-ID: <1799362.QSDMu6GHtU@flatron>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com> <1783157.vhfWvslFgW@flatron> <20131113181622.GZ878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113181622.GZ878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 of November 2013 18:16:22 Mark Brown wrote:
> On Wed, Nov 13, 2013 at 05:47:07PM +0100, Tomasz Figa wrote:
> > On Wednesday 13 of November 2013 16:43:28 Mark Brown wrote:
> 
> > > The best practice on this one seems to vary somewhat randomly -
> > > sometimes it's a requirement, sometimes it isn't.
> 
> > AFAIR we decided on ARM Mini Summit to mandate this, but maybe my memory
> > is misleading me.
> 
> OK, I hadn't heard that - it's good that folks made their mind up.
> 
> > > Is this a constructive thing from a style point of view?  We're not
> > > allowed to actually do anything useful with the value at runtime so
> > > people may as well choose what they like.
> 
> > This is what ePAPR says and I believe this is reasonable, because looking
> > at device tree sources you don't need to think what kind of hardware
> > a cs42l52 is. The information that it's a cs42l52 is still contained
> > inside compatible string.
> 
> Given that a meaningful name was already specified for the handle it's
> really not going to help anything - it's just going to duplicate that
> most likely.  Given that it can't be actually used for anything it seems
> better to just let people write whatever they feel like in there (even
> if it's just a single letter to keep the parser happy) rather than
> nitpick over their choices.

Well, the label is just for the parser and it does not get into the DTB.
This is where the DTS author can make things up just for their own
convenience (like main_codec, aux_codec or even cs42l52). 

I know this is really more bikeshedding than anything useful, but I'd
rather try to follow the written rules in ePAPR, instead of nothing at
all. At least just to make things more consistent.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
