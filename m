From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove display_register()
	callback
Date: Wed, 02 Feb 2011 14:54:33 +0000
Message-ID: <1296658473.4393.2.camel@dplaptop.localdomain>
References: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110202102335.GM12743@opensource.wolfsonmicro.com>
	<AANLkTing5zryWWt4HZHGUd15-6mrxpnRwA8EEiE8DGem@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27726103837
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 15:56:37 +0100 (CET)
In-Reply-To: <AANLkTing5zryWWt4HZHGUd15-6mrxpnRwA8EEiE8DGem@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-02 at 09:50 -0500, jonsmirl@gmail.com wrote:
> On Wed, Feb 2, 2011 at 5:23 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Feb 02, 2011 at 10:20:54AM +0000, Dimitris Papastamos wrote:
> >> Remove the display_register() callback as there are no users of it
> >> in the upstream kernel and makes it difficult to unify the format
> >> of the codec_reg file.
> >
> >> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> >
> > This was rather strongly requested for some devices with extremely large
> > registers (128 bits at least IIRC) which may eventually make it to
> > mainline.  It seems better to just have some sort of fallback for those
> > devices, if it causes output problems people can always fix those.
> >
> 
> TI Codec devices have two problems:
> 1) large registers - up to 128 bits
> 2) sparse register maps - big gaps between valid register addresses.

Yes, I've dropped the patch.

Thanks,
Dimitris
