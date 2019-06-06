From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: RE: [alsa-devel] [PATCH v2] ASoC: sun4i-i2s: Change SR and WSS
 computation
Date: Thu, 6 Jun 2019 11:49:58 +0000
Message-ID: <3BD9CEE4EBD5E74B98FE2D277EB60E0B3900D3A0@IRSMSX104.ger.corp.intel.com>
References: <20190605100801.2488-1-maxime.ripard@bootlin.com>
 <3BD9CEE4EBD5E74B98FE2D277EB60E0B38FF8117@IRSMSX104.ger.corp.intel.com>
 <20190606110647.iojplb27mdo276xk@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190606110647.iojplb27mdo276xk@flea>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>On Wed, Jun 05, 2019 at 04:36:28PM +0000, Rojewski, Cezary wrote:
>> >+static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
>> >+{
>> >+	if (width < 16 || width > 24)
>> >+		return -EINVAL;
>> >+
>> >+	if (width % 4)
>> >+		return -EINVAL;
>> >+
>> >+	return (width - 16) / 4;
>> >+}
>> >+
>> >+static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
>> >+{
>> >+	if (width < 16 || width > 32)
>> >+		return -EINVAL;
>> >+
>> >+	if (width % 4)
>> >+		return -EINVAL;
>> >+
>> >+	return (width - 16) / 4;
>> >+}
>> >+
>> >+static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
>> >+{
>> >+	if (width % 4)
>> >+		return -EINVAL;
>> >+
>>
>> In the two above you start with boundary check before mod yet in
>> this one the order is reversed.  Keeping the same order should prove
>> more cohesive.
>
>Indeed, I'll fix this.
>
>>
>> >+	if (width < 8 || width > 32)
>> >+		return -EINVAL;
>> >+
>> >+	return (width - 8) / 4 + 1;
>> >+}
>> >+
>>
>> Other, probably less welcome suggestion is introduction of unified
>> function which ones listed here would simply invoke. All of these
>> "computations" differ in fact only in: min and max boundary. The +1
>> for _sr_wss is negligible, you can append it on return.
>
>It's not just about the min and max boundaries. It's also the offset
>at which to start with (16 vs 8), and the offset to apply to the
>result (0 vs 1).
>
>That's 4 parameters out of 5 that are different. For something that
>trivial, I don't think it's worth it to put it in common.
>
>Maxime

This is what was going through my mind:

static inline s8 my_unified(int width, u8 min, u8 max)
{
	if (width < min || width > max)
		return -EINVAL;

	if (width % 4)
		return -EINVAL;

	return (width - min) / 4;
}

static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
{
	return my_unified(width, 16, 24);
}

static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
{
	return my_unified(width, 16, 32);
}

static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
{
	return my_unified(width, 8, 32) + 1;
}

However, if indeed 'start' offset is variable and may differ from min boundary, then my approach would fail.
Otherwise, treat it as suggestion, personally I find it easier to update only the unified function (development phase), especially if you're planning for adding more of these (the min/ max variants) in the future.

One more thing, the i2s ptr is unused - consider flagging it or simply removing from declaration?

Czarek
