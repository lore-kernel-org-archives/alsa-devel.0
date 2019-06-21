From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 16:53:09 +0200
Message-ID: <20190621145309.GA6313@kroah.com>
References: <20190621113357.8264-1-broonie@kernel.org>
 <20190621113357.8264-2-broonie@kernel.org>
 <20190621132222.GB10459@kroah.com>
 <20190621143053.GH5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621143053.GH5316@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 21, 2019 at 03:30:53PM +0100, Mark Brown wrote:
> On Fri, Jun 21, 2019 at 03:22:22PM +0200, Greg KH wrote:
> > On Fri, Jun 21, 2019 at 12:33:57PM +0100, Mark Brown wrote:
> 
> > >  	struct dentry *d;
> > >  
> > > -	if (!parent)
> > > +	if (!parent || IS_ERR(parent))
> > >  		return;
> 
> > How can parent be NULL?
> 
> It was more effort than it was worth to check to see if it could
> actually be NULL through default initialization or something and fix it
> than just not delete the check so I just left it there.  I'll probably
> go back and clean it up more thorougly at some point.
> 
> > I am trying to make it so that debugfs doesn't return anything for when
> > a file is created.  Now if that will ever be possible or not, I don't
> > know, but I am pretty close in one of the branches in my driver-core
> > tree...
> 
> You mentioned this in a mail last week, I then replied pointing out that
> this is not helpful as it reduces the robustness and quality of our
> debugging tools and you then did not respond.

Sorry, had lots of other stuff to work on, it's in my queue to respond
to still...

> This is a view I still hold and in any case debugfs as it stands (and
> was in the kernel versions since this was broken) is still capable of
> reporting errors so we should fix that.

Sort story is, I am trying to change it so that it can not report errors :)

And even then, no kernel code should be doing anything different if
debugfs calls fail or not, that is why I am I making these changes.  No
"real" code should ever be affected, and right now, it is, if something
goes wrong with debugfs.

So removing those checks is the goal here.  Your driver code should not
care if debugfs is working at all or not.

thanks,

greg k-h
