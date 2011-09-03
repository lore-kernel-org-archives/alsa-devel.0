From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/5] compress: add compress parameter
 definations
Date: Sat, 3 Sep 2011 07:28:02 +0100
Message-ID: <20110903062802.GA6556@sirena.org.uk>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
	<1314946206.3526.12.camel@mattotaupa>
	<1314993289.2298.21.camel@plb-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 380CB24353
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 08:28:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314993289.2298.21.camel@plb-Dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Paul Menzel <paulepanter@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 02:54:49PM -0500, Pierre-Louis Bossart wrote:

> > > + * @isFreqRangeContinuous: TRUE if the device supports a continuous range of
> > > + *                         sampling rates between minSampleRate and maxSampleRate;
> > > + *                         otherwise FALSE <FIXME: needed?>

> This also comes from OpenMAX AL. I don't know of any hardware
> implementation where the audio rate can be specified with an arbitrary
> value. Again if we don't see anyone needing this field, it'll be
> removed.

If you switch to ALSA rate specification you'll get this for free
anyway as ALSA supports it.
