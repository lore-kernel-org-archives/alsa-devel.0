From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Mixer control for signed gain value
Date: Tue, 28 Jun 2011 09:32:39 -0700
Message-ID: <20110628163238.GD21232@opensource.wolfsonmicro.com>
References: <4E02DDF3.2070509@codeaurora.org>
	<20110623103757.GC21932@opensource.wolfsonmicro.com>
	<4E09FF8B.4090103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 327C210388E
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:32:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E09FF8B.4090103@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 28, 2011 at 09:21:31AM -0700, Patrick Lai wrote:

> Yes, CODEC in question takes byte-long signed gain value and would like
> to reuse snd_soc_xxx_volsw_xx mixer callback functions in soc-core.c.
> The only functions I see handle signed value are
> snd_soc_info_volsw_s8, snd_soc_get_volsw_s8, snd_soc_get_volsw_s8
> Unless I am mistaken, these functions deal with two signed byte-long
> values which get concatenated into 16-bit value. Perhaps, original

No, they shouldn't do that - they should handle stereo pairs in a single
register.  Looks like they just need a little massaging to cope with
mono controls.

> So, my question is whether I should reuse volsw_s8 mixer control
> functions and have mixer application ignore integer.value[1] to suit my
> purpose or redefine new set of mixer control functions i.e
> snd_soc_set_volsw_single_s8. Otherwise, is there existing alternative
> to handle set/put byte-long signed value?

Make the current controls handle mono.
