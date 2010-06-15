From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RFC 2/3] input: wm97xx: set GPIOs with AC97
	GPIO busops if implemented
Date: Tue, 15 Jun 2010 18:17:18 +0200
Message-ID: <AANLkTil-WxjFdE5oGEJklu_cA2o-23TCLjqD8sz-iMLm__19040.2602930137$1276618653$gmane$org@mail.gmail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
	<1276617347-3522-3-git-send-email-manuel.lauss@googlemail.com>
	<20100615160802.GL14510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100615160802.GL14510@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 6:08 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jun 15, 2010 at 05:55:46PM +0200, Manuel Lauss wrote:
>> If the AC97 controller implements the ->setgpio callback, use it.
>> Some codecs (i.e. WM9712) only accept GPIO data through AC97 slot 12.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>
> It seems like it'd be easier to just do this as a generic AC'97 thing
> rather than adding it to the WM97xx driver - that way any CODEC that has
> GPIO support can use it, we don't have to add custom per-CODEC GPIO APIs.
> If you're using the WM97xx-specific code you're already doing something
> custom so it's not much loss to use a generic thing.

Oh, now I get it.  Hmm, what about setting pin direction?  That
certainly is per-codec, no?

Manuel
