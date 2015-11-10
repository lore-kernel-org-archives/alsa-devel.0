From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Tue, 10 Nov 2015 16:21:04 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460CF5D@SW-EX-MBX01.diasemi.com>
References: <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
 <20151109140225.GA26072@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
 <20151110141513.GF12392@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CED5@SW-EX-MBX01.diasemi.com>
 <20151110154434.GG12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.176])
 by alsa0.perex.cz (Postfix) with ESMTP id DBDAE26524C
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 17:21:06 +0100 (CET)
In-Reply-To: <20151110154434.GG12392@sirena.org.uk>
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

On November 10, 2015 15:45, Mark Brown wrote:

> > It's to detect the noise level on a mic and raise an event if the captured
> > sound is above a specific threshold level. Apologies if that wasn't clear.
> 
> > In the driver code I'm using KEY_VOICECOMMAND, and simulating a press and
> > release of this key, to indicate to user-space. This seemed like the obvious
> > choice for this feature to me, although I'd happily get your opinion on this.
> 
> That seems like a particularly unfortunate choice given that
> VOICECOMMAND is used in the standard Google headset mapping (see
> ts3a227e for an example, that's a device specifically aimed at providing
> accessory detection in Chromebooks).  There's also been some pushback
> against using the input devices due to the difficulty in enabling apps
> to access input devices - ALSA controls were preferred instead but
> that's less helpful for tinyalsa.  Perhaps that can be added relatively
> easily, or a uevent or something.
> 

I chose VOICECOMMAND as I thought this kind of feature might offer the same kind
of use as the physical button, but if this only for Google headset use then fair
enough. 

> Not sure what the best way forward here is, the other implementations of
> this that I'm aware of do more of the detection in offload and present
> streams of detected audio to userspace via normal capture.
> 

Yes, this is far more simplistic, and any voice processing or capture is not
handled by the codec. It just an indication of above threshold noise level at
the mic. For the implementations you know of, how are those events indicated to
user-space?

> I would at least suggest moving this into a separate patch and doing
> the integration separately.

Are you happy for me to leave the actual controls for this feature in, without
the user-space reporting side? Otherwise it's a pain to strip that out, and then
re-instate later. The event can be masked off until the user-space reporting
is added in a subsequent patch.
