From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Mon, 9 Nov 2015 12:28:39 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 74439260431
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 13:28:43 +0100 (CET)
In-Reply-To: <20151108103429.GC6746@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On November 8, 2015 10:34, Mark Brown wrote:

> > > Hang on, is this just recording a DC value with the ADC and then looking
> > > at that?
> 
> > The RMS of the Mic signal is taken and compared to the trigger level set. If
> > it's above that level then an IRQ is raised.
> 
> What I'm trying to figure out here is if this depends on the audio
> routing at runtime or if it's got dedicated configuration?

This feature is available for any/all mics connected. Which mics are enabled
is a runtime configuration of routing, so to me it makes sense also that we can
configure which channel triggers an event, based on our scenario at that time.
