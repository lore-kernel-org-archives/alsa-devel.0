From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Wed, 01 Apr 2015 19:56:50 +0300
Message-ID: <1427907410.2646.46.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB0326537B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 18:57:05 +0200 (CEST)
In-Reply-To: <1427891224.2711.31.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Han Lu <han.lu@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-04-01 at 13:27 +0100, Liam Girdwood wrote:
> On Tue, 2015-03-31 at 19:49 +0300, Tanu Kaskinen wrote:
> > So is your preference that UCM configuration authors are forced to
> > define simplex devices to deal with headset jacks, rather than using
> > duplex devices and defining "PlaybackJackControl" and
> > "CaptureJackControl" separately? (I don't personally mind either way.)
> 
> I don't really mind either, but what's easier for audio servers like
> pulseaudio that will be the main UCM clients ? I guess that pulseaudio,
> CRAS, and other audio servers probably deal with simplex PCM streams
> internally so mapping to simplex jacks/devices might be better ?

Yes, the native device representation in PulseAudio uses the simplex
model. However, the code for handling duplex UCM devices already exists,
so it shouldn't take a big effort to support duplex devices with
separate "PlaybackJackControl" and "CaptureJackControl" values.

-- 
Tanu
