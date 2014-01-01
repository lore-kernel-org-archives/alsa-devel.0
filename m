From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compound card
 with DT support
Date: Wed, 01 Jan 2014 21:11:23 +0100
Message-ID: <52C4766B.8080000@metafoo.de>
References: <20131231113138.102044cf@armhf> <52C466E1.3030302@metafoo.de> <20140101210814.31e3f3a9@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140101210814.31e3f3a9@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/01/2014 09:08 PM, Jean-Francois Moine wrote:
> On Wed, 01 Jan 2014 20:05:05 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> As Mark also said, this binding definitely leaks way too much internals of
>> the current ASoC implementation. In my opinion the way forward for ASoC is
>> to stop to distinguish between different types of components. This is on one
>> hand CODECS and CPU-DAIs and on the other hand also front-end and beck-end
>> DAIs. The first steps in this direction have already been take by the start
>> of the component-fication, but its still a long way to go. Exposing those
>> concepts via the devicetree will only make it harder to get rid of them
>> later. The bindings for a compound card should essentially describe which
>> components are involved and how the fabric between and around them looks
>> like. If the type of the component is needed in the ASoC implementation it
>> should be possible to auto-discover it. Also I think we want to align the
>> devicetree bindings with what the media people have been doing[1].
> 
> (you forgot the [1] reference)

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/media/video-interfaces.txt
