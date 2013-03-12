From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Wed, 13 Mar 2013 08:55:43 +1030
Message-ID: <20130312222543.GA8909@marvin.atrad.com.au>
References: <mailman.1440.1362696800.805.alsa-devel@alsa-project.org>
 <20130310045854.GB22874@marvin.atrad.com.au>
 <s5hfw02l3mx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 154E2265EAF
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 23:25:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfw02l3mx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: superquad.vortex2@gmail.com, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 11, 2013 at 09:52:38AM +0100, Takashi Iwai wrote:
> At Sun, 10 Mar 2013 15:28:54 +1030,
> Jonathan Woithe wrote:
> > The only slightly odd thing I noticed was that whenever the driver is loaded
> > the "headphone mic jack mode" defaults to "mic bias 80pc", rather than "line
> > out" or "headphone" which I would have expected.  Obviously this can be
> > manually or automatically overridden after module load, but in many ways it
> > would be good if it defaulted to one of the output modes (given that the
> > jack's primary purpose is for output).
> 
> Indeed, it's an overlooked bug.  I merged the fix patch below.

That looks like it'll do the trick.  I'll check it explicitly when I get a
chance over the next few days.

> > Where does this leave us now?  Is the "fujitsu-jwse" a permanent thing, or
> > will the respective changes be rolled into something more generic?
> 
> I'm inclined to keep as is.

Ok, suits me.

Do you think that a more descriptive model (eg: fujitsu-fullmixer or
something) is warranted?

BTW, I will attempt to determine precisely what it is about the default
initialisation sequence that causes the internal speaker to be permanently
muted.  For now though the workarounds in "fujitsu-jwse" work well.

Regards
  jonathan
