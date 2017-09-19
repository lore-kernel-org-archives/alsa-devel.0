From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RESEND PATCH v2 3/3] ASoC: rockchip: Init dapm
	routes dynamically
Date: Tue, 19 Sep 2017 20:44:35 +0800
Message-ID: <59C11133.5090400@rock-chips.com>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
 <20170918111801.12881-3-jeffy.chen@rock-chips.com>
 <20170919122803.kybaln43yho3deih@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 18609266F0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 14:44:57 +0200 (CEST)
In-Reply-To: <20170919122803.kybaln43yho3deih@sirena.co.uk>
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
Cc: alsa-devel@alsa-project.org, dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 09/19/2017 08:28 PM, Mark Brown wrote:
> On Mon, Sep 18, 2017 at 07:18:01PM +0800, Jeffy Chen wrote:
>> Currently we are using a fixed list of dapm routes.
>>
>> Init dapm routes dynamically when parsing dailinks, since we are
>> supporting optional codecs.
>
> This doesn't apply against current code, please check and resend.
>

i rebased these patches to for-next 20170919, but nothing changed...


but i found my other pending patch 
(https://patchwork.kernel.org/patch/9958055) might conflict to this, 
i'll send a new series to put all my patches together and solve the 
conflict...

sorry for the trouble..
