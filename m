From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Date: Thu, 4 Apr 2019 13:35:14 +0000
Message-ID: <88cdfc1b-f6b0-9965-fba4-add436109ca1@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
 <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
 <20190404054704.GN5748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190404054704.GN5748@sirena.org.uk>
Content-Language: en-US
Content-ID: <FBD788ABDA9F454B8AA9ECEC08B7DA17@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "apatard@mandriva.com" <apatard@mandriva.com>, "perex@perex.cz" <perex@perex.cz>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

There are no routes in cs42l51_routes table using "Mic Bias" widget.

I use this widget in a route defined in audio graph card DT node.
I checked other DTs which are using CS42L51 codec (armada-370-db.dts
kirkwood-openrd-client.dts, kirkwood-openrd-ultimate.dts),but I did not 
find reference to "Mic Bias" widget.
So, my understanding is that the patch should not break the legacy.
If you think this assumption is not correct please let me know.

Regards
Olivier


On 4/4/19 7:47 AM, Mark Brown wrote:
> On Wed, Apr 03, 2019 at 03:23:35PM +0200, Olivier Moysan wrote:
>> Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
>> instead of deprecated SND_SOC_DAPM_MICBIAS.
> 
> There are existing users in mainline, have they all been updated to be
> compatible with this, or verified that they don't need updates?
> 
