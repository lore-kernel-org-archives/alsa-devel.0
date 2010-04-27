From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Tue, 27 Apr 2010 03:58:48 +0100
Message-ID: <20100427025848.GB24020@trinity.fluff.org>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
	<20100310142314.GD6850@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 752D6247B4
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 04:58:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100310142314.GD6850@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 02:23:15PM +0000, Mark Brown wrote:
> On Wed, Mar 10, 2010 at 04:48:55PM +0900, Jassi Brar wrote:
> 
> >  I have prepared some patches that debug and modify the behaviour of
> > extant S3C I2S support towards managing I2Sv4 controllers as well.
> 
> OK, I think that's everything.  I've not applied anything after the
> header move yet due to the need for an ack from Ben.  Any patches I
> didn't specifically comment on are OK.  Overall it's all good, most of
> the issues are minor.

I'd like to see a bit of header reformatting to make them readable
if they're not already merged.

the header moves are ok by me, much prefer to see them git mv'd than
copy and rm'd.
 
> In future could you please use --no-chain-reply-to when sending patches
> to avoid massively deep threads in threaded mail readers (the git
> default is changing in 1.7.0 for this very reason).  It's also best to
> send the cover letter first and tell git send-email that everything
> should be sent in reply to that - this way people are likely to see the
> cover letter before the patches.

agreed on this one.
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
