From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sat, 31 Aug 2013 22:46:35 +0200
Message-ID: <5222562B.8010001@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-186.synserver.de (smtp-out-186.synserver.de
 [212.40.185.186])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDF72625D4
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 22:44:57 +0200 (CEST)
In-Reply-To: <20130831191956.GH6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/31/2013 09:19 PM, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 06:28:53PM +0100, Mark Brown wrote:
>> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
>>
>>> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
>>> widgets to the I2S streams. In your machine driver setup the link config to
>>> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
>>> framework will then create the necessary routes all by itself. Of course
>>> this won't work on a platform where both the SPDIF and I2S controller are
>>> used at the same time, but neither does your current solution.
>>
>> This is the either/or approach I've been suggesting.
> 
> Ah, here we go again.  This is precisely why I can't work with you.
> Nothing I say seems to stick in your mind.  I've been telling you for the
> last four weeks that it doesn't work - and I've shown you the oopses and
> warnings I get from trying it.  Your response to date: nothing of any
> real use.
> 
> If you're not going to provide any useful responses on bug reports, it is
> totally unreasonable that you even suggest that _that_ is how it should
> be done when I've already proved that it's impossible at present.

Russell, please stop being such a bitch. You seem to be the only one who has
any problems working with Mark, which maybe should make you wonder if the
problem is not on your side. Insulting and screaming at people all the time
won't exactly motivate them to help you with your problems. Please try to be
constructive, it will makes things much easier for everyone.

Thanks,
- Lars
