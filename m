From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 21:13:38 +0100
Message-ID: <3836312.jpzaMFU2re@flatron>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com> <1799362.QSDMu6GHtU@flatron> <20131113194915.GF878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113194915.GF878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 of November 2013 19:49:15 Mark Brown wrote:
> On Wed, Nov 13, 2013 at 07:24:04PM +0100, Tomasz Figa wrote:
> 
> > Well, the label is just for the parser and it does not get into the DTB.
> > This is where the DTS author can make things up just for their own
> > convenience (like main_codec, aux_codec or even cs42l52). 
> 
> If only we could have comments :)

Comments in DTB? That would be at least interesting. ;)

> 
> > I know this is really more bikeshedding than anything useful, but I'd
> > rather try to follow the written rules in ePAPR, instead of nothing at
> > all. At least just to make things more consistent.
> 
> My feeling here is that we should be looking more critically at ePAPR -
> if we're picking people up for having what's essentially a comment
> that's too specific we're probably doing something wrong especially
> since the corrected example would look something like:
> 
> 	codec: codec@12 {
> 
> which is a bit redundant.

Still, this is not a comment, because it's also available in the
resulting binary representation.

Well, maybe I'm a bit too strict. I wouldn't probably notice this if
I didn't have other comments, so let's say that was just a nitpick of
mine, fixing of which doesn't cost anything, since another version will
have to be spinned anyway.

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
