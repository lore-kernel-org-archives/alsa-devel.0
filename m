From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Open source UAC2 sound card for UAC2 driver testing
Date: Wed, 9 Jun 2010 16:17:49 +0200
Message-ID: <20100609141749.GS2695@buzzloop.caiaq.de>
References: <loom.20100609T154158-159@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 09AA5103951
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 16:17:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20100609T154158-159@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <lee188@singnet.com.sg>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 09, 2010 at 02:00:24PM +0000, Alex Lee wrote:
> We are developing an open source high speed USB sound card.  Please see:
> 
> http://code.google.com/p/sdr-widget/
> 
> for details.
> 
> With the alpha-1 hardware, we are doing development and testing of the UAC2
> firmware against the latest alsa driver here.  We have already demonstrated
> 96khz 24bit stereo capture with UAC2 and we will proceed to 192khz soon.
> 
> Alpha-1 has an ENOB of at least 20 and we hope alpha-2 will have an ENOB of 22
> or better.  Alpha-2 kits are available for order now.  (Note that these are
> prototype kits for experimenters only.)
> 
> With both the UAC2 driver and the sound card firmware being open source, we hope
> to expedite full UAC2 spec compliance.  We are already working closely with
> Daniel Mack on the testing.

Alex also found two minor bugs in the UAC2 part of the driver which I
already fixed in my tree. I'm planning to release a set of patches later
this week.

Daniel
