From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/4] Main rewite of the mpc5200 audio
	DMA code
Date: Mon, 25 May 2009 10:34:41 +0100
Message-ID: <20090525093439.GA18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013847.3073.55951.stgit@terra>
	<fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3578D103844
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:34:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 12:26:27AM -0600, Grant Likely wrote:
> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> > +/* ---------------------------------------------------------------------
> > + * Sysfs attributes for error monitoring
> > + */

> All this sysfs stuff should be dropped from this patch.  It is an
> abuse of sysfs and I never should have written it this way.  Feel free
> to put it in a separate patch so others can use it if they really need
> it, but I'd like it to not be kept in mainline.

If this is going to be kept it should be in debugfs like I said in
response to the v2 posting.
