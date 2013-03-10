From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sun, 10 Mar 2013 15:28:54 +1030
Message-ID: <20130310045854.GB22874@marvin.atrad.com.au>
References: <mailman.1440.1362696800.805.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C0962650B9
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 05:58:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <mailman.1440.1362696800.805.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > On Wed, Feb 20, 2013 at 02:14:20PM +0100, Takashi Iwai wrote:
> > > > Sounds good - I will test in the next day or so and report back.  What's the
> > > > most efficient way to get hold of this tree / branch given that I have the
> > > > for-next branch of sound.git?  Can I somehow leverage this, or do I need to
> > > > do a completely separate checkout?  Apologies if this is a basic question -
> > > > I'm still coming to terms with git.
> > > 
> > > sound-unstable git tree always contains the sound git tree master
> > > branch, so everything is there basically. ...
> > 
> > What's the next step in the process?  I've reported the outcome of the tests
> > of sound-unstable as per that report progress is being made.  Is it a case
> > of waiting for things to stabilise, or do you need me to do something to
> > move things along?  If so, what?
> 
> I merged the patches to the main sound git tree for-next branch now.
> 
> Also a few updates are merged there, too: now the hp mic jack mode
> should be able to change the pin control no matter whether which
> capture source is.  Also, the capture source won't change the hp/mic
> pinctl when the jack mode enum is created.  This reduces the
> automation but also reduces the confusion, too.  After all, when jack
> mode is present, user wants to control the pin by himself.
> 
> Let me know if anything else is missing or broken.

I've given this new revision a quick test; sorry for the delay.  With this
revision, when using "model=fujitsu-jwse" things seem to be working pretty
well.  In particular, the updates you mention greatly improve usability; the
lack of automatic interaction between mixer controls makes it much easier to
use and understand.

I think everything is present and accounted for in this latest revision. 
Thanks for your work on this.

The only slightly odd thing I noticed was that whenever the driver is loaded
the "headphone mic jack mode" defaults to "mic bias 80pc", rather than "line
out" or "headphone" which I would have expected.  Obviously this can be
manually or automatically overridden after module load, but in many ways it
would be good if it defaulted to one of the output modes (given that the
jack's primary purpose is for output).

Where does this leave us now?  Is the "fujitsu-jwse" a permanent thing, or
will the respective changes be rolled into something more generic?

Regards
  jonathan
