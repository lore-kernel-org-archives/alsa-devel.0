From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 2/3] swarm_cs4297: Rename AC97 registers to
 use sound/ac97_codec.h definitions
Date: Tue, 19 Jun 2012 09:41:30 -0300
Message-ID: <CALF0-+WxqMmoPMGjMZBBiKq2NR5qPESo6mA0B4MPhdyc_KUNsw@mail.gmail.com>
References: <1339444731-15678-1-git-send-email-elezegarcia@gmail.com>
	<1339444731-15678-2-git-send-email-elezegarcia@gmail.com>
	<s5h8vfkn2bb.wl%tiwai@suse.de>
	<CALF0-+Ukw2+whn5zpA4R6PjN0BoLm5aUhQKUNQt0rpWM1vNXFA@mail.gmail.com>
	<s5ha9zz97zw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D4003244EB
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 14:41:31 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so7663066obb.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 05:41:30 -0700 (PDT)
In-Reply-To: <s5ha9zz97zw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2012 at 2:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 18 Jun 2012 14:50:53 -0300,
> Ezequiel Garcia wrote:
>>
>> Hi Takashi,
>>
>> On Mon, Jun 18, 2012 at 11:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Mon, 11 Jun 2012 16:58:50 -0300,
>> > Ezequiel Garcia wrote:
>> >>
>> >> This patch removes the last usage of linux/ac97_codec.h
>> >> by renaming ac97 registers to use sound/ac97_codec.h definitions.
>> >> This will enable us to remove linux/ac97_codec.h.
>> >>
>> >> Not even compilation tested.
>> >>
>> >> Cc: Ralf Baechle <ralf@linux-mips.org>
>> >> Cc: Jaroslav Kysela <perex@perex.cz>
>> >> Cc: Takashi Iwai <tiwai@suse.de>
>> >> Cc: Clemens Ladisch <clemens@ladisch.de>
>> >> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
>> >> ---
>> >> Hi all,
>> >>
>> >> This patch is important so we can remove linux/ac97_codec.h usage.
>> >> Since this driver is mips related, I can't test it until I install
>> >> a mips toolchain.
>> >> If someone can compile this for me, or even test it with real
>> >> hardware I think it would be better.
>> >> If not then I can install a mips toolchain and compile it myself,
>> >> but I won't be able to test it on real hardware.
>> >>
>> >> This patch should be treated with carefully and be applied only
>> >> if someone manages to test it.
>> >
>> > A slight concern by this change is that the driver includes
>> > sound/ac97_codec.h although it's based on OSS framework.
>> > sound/ac97_codec.h is the header for ALSA ac97 structs, and this can't
>> > be mixed up with OSS.
>> >
>> > If the intention is only about AC97 register definition, we may split
>> > ac97_codec.h into ac97_regs.h and ac97_codecs.h where the former
>> > contains only the register definitions (thus framework-neutral) and
>> > the latter includes the former.
>> >
>> >
>>
>> Yes, splitting sounds good to me. It could be useful for other ac97
>> drivers (e.g. em28xx).

On a second thought, I'm not sure splitting the header is the best way
to proceed. Since swarm just uses some AC97 register definition
maybe we could just duplicate those (less than ten) macros in swarm
c file.

It's a less intrusive aproach and it allows us to remove the unused
linux/ac97_codec.h.

Regards,
Ezequiel.
