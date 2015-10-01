From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] regulator: arizona: add support for WM8998 and
 WM1814
Date: Thu, 1 Oct 2015 08:51:02 +0100
Message-ID: <20151001075102.GL5432@ck-lbox>
References: <1443445269-11746-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1443445269-11746-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150930181601.GS15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150930181601.GS15635@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2015 at 07:16:01PM +0100, Mark Brown wrote:
> On Mon, Sep 28, 2015 at 02:01:07PM +0100, Richard Fitzgerald wrote:
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> 
> So if I've acked this rather than applying it presumably there are MFD
> dependencies somewhere we're waiting for?  If there aren't why did this
> not go in with the MFD?
> 
> Please don't resend me my own ack on code that it looks like I'm
> expected to apply, it's confusing :(

Afraid Richard is on holiday at the moment, apologies for any
confusion. The MFD changes went in ages ago, but the other
changes in the series weren't applied, I am can't remember
exactly why. So all the supporting MFD stuff is already in
your trees and you can safely apply these ones.

Thanks,
Charles
