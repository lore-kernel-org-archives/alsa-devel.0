From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH][ASoC]Add ability to remove rate
 constraints from generic ASoC AC'97 CODEC driver
Date: Tue, 07 Apr 2015 17:09:02 +0200
Message-ID: <5523F30E.3020204@maciej.szmigiero.name>
References: <54FF7E13.4060801@maciej.szmigiero.name>
 <20150322182744.GB6643@sirena.org.uk>
 <551821A1.5030902@maciej.szmigiero.name>
 <20150330041935.GA1568@sirena.org.uk> <552062C8.80103@maciej.szmigiero.name>
 <20150406164150.GM6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C6C2605A9
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 17:09:17 +0200 (CEST)
In-Reply-To: <20150406164150.GM6023@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

W dniu 06.04.2015 18:41, Mark Brown pisze:
> On Sun, Apr 05, 2015 at 12:16:40AM +0200, Maciej S. Szmigiero wrote:
>> W dniu 30.03.2015 06:19, Mark Brown pisze:
>>> On Sun, Mar 29, 2015 at 06:00:33PM +0200, Maciej S. Szmigiero wrote:
> 
>>> Alternatively if you're just trying to open up the constraints why not
>>> just open them up by default and make sure that the AC'97 generic code
>>> is constraining things appropriately if it's not doing so already?
> 
>> By 'open them up by default' do you mean removing them altogether 
>> from ASOC AC'97 generic CODEC to let the AC'97 bus driver constrain
>> rates on its own or do you mean retaining ability to constraint in
>> ASOC AC'97 driver, just have it switched off by default?
> 
> I mean make the default setting be the maximum possible set of rates and
> then allow the CODEC code to constrain based on what it finds on the
> link.
> 
> Please also note that ASoC is spelt ASoC.
> 
>> (that is, what the current patch did, just change the default setting).
> 
> No, it added a device tree property for controlling things.

I meant this patch (about which the Subject line is), which controlled rate
constraints based on passed platform data, not the first one which
added DT support to the generic ASoC AC'97 CODEC driver.

>> If the rate constraints are removed (or disabled) from the ASOC AC'97
>> generic CODEC driver then it can be used as-is in the (at least) fsl_ssi
>> driver by registering AC'97 platform device there using index taken from
>> DT property (cell-index) already defined as required in
>> Documentation/devicetree/bindings/sound/fsl,ssi.txt.
> 
>> Now the question is what is more binding: the documentation which
>> defines this property as required or DT files which don't define it at all?
> 
> The driver really ought to continue to support existing DTs, it can
> complain about them and assume the default value if the property really
> is required for some reason though.

Thanks for explanation.

In this case this property would be only de facto required in DT of board that
I am adding sound to (and in future boards that are also using this
controller - CODEC arrangement), so there won't be any compatibility problems
with existing board DT files.

Best regards,
Maciej Szmigiero
