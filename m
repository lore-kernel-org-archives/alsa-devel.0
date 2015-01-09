From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Fri, 09 Jan 2015 09:25:40 +0000
Message-ID: <54AF9E94.7080601@arm.com>
References: <cover.1420628786.git.moinejf@free.fr>
 <0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>
 <54AE99F5.1010404@ti.com> <20150108174257.557f7ea5@armhf>
 <20150108200421.GC2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 26ADF26153A
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 10:25:44 +0100 (CET)
In-Reply-To: <20150108200421.GC2634@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jean-Francois Moine <moinejf@free.fr>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jyri Sarha <jsarha@ti.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/08/15 20:04, Mark Brown wrote:
> On Thu, Jan 08, 2015 at 05:42:57PM +0100, Jean-Francois Moine wrote:
> 
>> Examples:
> 
>> - for the Cubox:
> 
>> 	audio-inputs = "i2s", "spdif";
> 
>> - for some other board with I2S on the pins 3 and 4 only:
> 
>> 	audio-inputs = "none", "none", "i2s", "i2s";
> 
>> - for a fully wired TDA9983B (no driver yet):
> 
>> 	audio-inputs = "i2s", "i2s", "i2s", "i2s", "spdif";
> 
> I think that mostly works, though I do wonder if we need a way to
> specify the ordering of the pins (if you can make pin 3 be the first two
> I2S channels for example)?  Someone might choose a strange mapping for
> board routing reasons for example.
> 

If it helps, I've collated the pin assignments given in the various TDA datasheets that I can find:

Chip>	9983B	9989		19988		19989	
Mode>	-	S/PDIF	I2S	S/PDIF	I2S	S/PDIF	I2S
Pin
AP0	WS	-	WS	-	WS	-	WS
AP1	I2S#0	S/PDIF	I2S#0	S/PDIF	I2S#0	S/PDIF	I2S#0
AP2	I2S#1	-	-	S/PDIF	I2S#1	S/PDIF	I2S#1
AP3	I2S#2	-	-	-	I2S#2*	MCLK	-
AP4	I2S#3	-	-	-	I2S#3*	-	-
AP5	MCLK	-	-	-	-	-	-
AP6	S/PDIF	-	-	-	-	-	-
AP7	AUX	-	-	-	-	-	-

WS = I2S Word Select
* Depends on package

The 9983B differs from the other devices in that the I2S and S/PDIF functionality is not multiplexed 
onto various pins.

	Andrew
