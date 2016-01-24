From: Rick Thomas <rbthomas@pobox.com>
Subject: Re: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
Date: Sun, 24 Jan 2016 12:56:09 -0800
Message-ID: <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
 <20160124173701.GU3880@lunn.ch>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160124173701.GU3880@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Martin Michlmayr <tbm@cyrius.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


On Jan 24, 2016, at 9:37 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Jan 24, 2016 at 12:36:39AM +0200, Aaro Koskinen wrote:
>> Fix audio on kirkwood-openrd-client:
>> 
>> 1) The audio-controller was left disabled.
>> 
>> 2) The probe fails because cs42l51 is missing #sound-dai-cells.
>> 
>> 	/sound/simple-audio-card,codec: could not get #sound-dai-cells for /ocp@f1000000/i2c@11000/cs42l51@4a
>> 	asoc-simple-card sound: parse error -22
>> 	asoc-simple-card: probe of sound failed with error -22
>> 
>> 3) The mapping is incorrect:
>> 
>> 	asoc-simple-card sound: cs42l51-hifi <-> spdif mapping ok
>> 
>>   should be:
>> 
>> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
>> 
>> Reported-by: Rick Thomas <rbthomas@pobox.com>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> It would be good to have a Tested-by: from Rick.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> 	     Andrew


If someone will make a .deb I can download, I'll be happy to install it and test it.  Please be explicit in describing what and how you want tested.


Rick
