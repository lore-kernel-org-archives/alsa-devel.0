From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for
 Pistachio audio card
Date: Wed, 27 Jan 2016 15:18:20 +0000
Message-ID: <56A8DFBC.6070007@imgtec.com>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A7F8226044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 16:18:21 +0100 (CET)
In-Reply-To: <20160127145756.GR6042@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

On 27/01/16 14:57, Mark Brown wrote:
> On Tue, Jan 26, 2016 at 02:34:26PM +0000, Damien Horsley wrote:
> 
>> +  - clock-names : Includes the following entries:
>> +        "audio_pll"  The audio PLL
>> +        "i2s_mclk"   The i2s reference clock
>> +                     Also connected to i2s_out_0_mclk output
>> +        "dac_mclk"   Dac reference clock. Connected to i2s_dac_clk output
> 
> Why are these (especially the dac_mclk and i2s_mclk) properties of the
> card and not of the drivers for the respective devices?
> 

Due to the shared nature of these clocks. Individual components cannot
be responsible for controlling these as this could break configurations
for other components that are sharing the clocks. Only the card driver
has visibility of all of the components and their requirements.

audio_pll is used by spdif out, parallel out, i2s out, and i2s in if
there are codecs on the i2s in path that make use of i2s_mclk and
dac_mclk (derived from audio_pll)

i2s_mclk and dac_mclk can be used by both the i2s in and i2s out paths
on some boards

>> +  - img,mute-gpio : phandle of the mute gpio
>> +
>> +  - img,hp-det-gpio : phandle of the headphone detect gpio
> 
> The DT maintainers would prefer those to be named -gpios.
> 

Ok
