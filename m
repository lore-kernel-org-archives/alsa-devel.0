From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Tue, 03 May 2016 21:22:05 +0200
Message-ID: <87y47roski.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160503115159.GP6292@sirena.org.uk> (Mark Brown's message of
 "Tue, 3 May 2016 12:51:59 +0100")
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:
>> Split out from the ac97_codec.h the ac97 generic registers, which can be
>> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
>> scan an ac97 AC-Link.
>
> I don't entirely see the value in this one but equally it does no harm.
Oh that's to have the defines AC97_VENDOR_ID1 and AC97_VENDOR_ID2, but without
including ac97_codec.h in sound/ac97/bus.c.

Cheers.

-- 
Robert
