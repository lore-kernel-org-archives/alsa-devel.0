From: Jyri Sarha <oku@iki.fi>
Subject: Re: [PATCH RFC 2/8] ASoC: davinci-evm: Add device tree
	binding
Date: Wed, 11 Sep 2013 21:02:06 +0300
Message-ID: <26fb2b5213b7ea9c8bd9e2ef023614a3@kapsi.fi>
References: <cover.1378738436.git.jsarha@ti.com>
 <2f2fa45507656c464b413a9761c7dd2059f4590e.1378738436.git.jsarha@ti.com>
 <20130909152146.GK29403@sirena.org.uk>
 <7fd2aed6239e4bbb791a4f232c74881a@kapsi.fi>
 <20130911113533.GQ29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 30F46261ACB
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 20:02:13 +0200 (CEST)
In-Reply-To: <20130911113533.GQ29403@sirena.org.uk>
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
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 2013-09-11 14:35, Mark Brown wrote:
> On Wed, Sep 11, 2013 at 01:38:47PM +0300, Jyri Sarha wrote:
> 
> After checking the code, are you sure about this? Non of the other
> codecs have pins in their devicetree binding document?
> 
> Yes, I am sure and yes there are other CODECs with pins listed, check
> again.

I wonder if I somehow misunderstood your first comment. I just
noticed that davinci-evm-audio.txt is missing all the output pins and
some connectors that are found in the code and also in the example
node. I will add those.

I can of course also add the list of pins to Documentation/devicetree/
bindings/sound/tlv320aic3x.txt, if that was what you meant. It would
make sense to have the pins there. However, I really can not find the
list of pins from any of the Wolfson codec binding documents
(Documentation/devicetree/bindings/sound/wm*.txt) for exmaple. Are you
perhaps refering to some other document or is the convention changing
for v3.12?

When comparing the codec bindings I found that the regulators are
missing from tlv320aic3x.txt. I'll add those too.

Best regards,
Jyri
