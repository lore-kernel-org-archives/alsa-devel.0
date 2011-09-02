From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 2/5] compress: add compress parameter
 definations
Date: Fri, 02 Sep 2011 14:54:49 -0500
Message-ID: <1314993289.2298.21.camel@plb-Dell>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
	<1314946206.3526.12.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CB10245ED
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 21:55:04 +0200 (CEST)
In-Reply-To: <1314946206.3526.12.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you Paul for your feedback. We will fix all the typos/formatting
issues. You flagged two important points, see my answers below.

> > +/** struct SndAudioCodecDescriptor - description of codec capabilities
> > + * @maxChannels: maximum number of audio channels
> > + * @minBitsPerSample: Minimum bits per sample of PCM data <FIXME: needed?>
> > + * @maxBitsPerSample: Maximum bits per sample of PCM data <FIXME: needed?>
> 
> More elaborate explanation for the FIXME (in the commit message)?

These fields were defined by OpenMAX AL and make sense for a software
implementation of encoders/decoders. In our case the DSP may be a 24-bit
CPU, or a 32-bit one, or a 16-bit one with double precision. I believe
it's useless to specify the internal PCM format to be used by the DSP,
this should be defined by the firmware implementers. 
We decided to leave these fields for now, and see if anyone had a good
reason to keep them. If no one speaks up they will be removed.

> > + * @isFreqRangeContinuous: TRUE if the device supports a continuous range of
> > + *                         sampling rates between minSampleRate and maxSampleRate;
> > + *                         otherwise FALSE <FIXME: needed?>

This also comes from OpenMAX AL. I don't know of any hardware
implementation where the audio rate can be specified with an arbitrary
value. Again if we don't see anyone needing this field, it'll be
removed.
