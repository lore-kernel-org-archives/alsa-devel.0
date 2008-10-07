From: "Arun KS" <getarunks@gmail.com>
Subject: Re: Fwd: AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 17:49:59 +0530
Message-ID: <dfeb90390810070519k1305a1fep4ba4db3ea85fa975@mail.gmail.com>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	<20081007115450.GD19835@sirena.org.uk>
	<dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	<e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
	<e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D8A1224559
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 14:20:13 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so1819506tid.8
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 05:19:59 -0700 (PDT)
In-Reply-To: <e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 7, 2008 at 5:36 PM, Jesslyn Abdul Salam
<jesslyn.abdulsalam@gmail.com> wrote:
> ---------- Forwarded message ----------
> From: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
> Date: Tue, Oct 7, 2008 at 5:36 PM
> Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
> To: Arun KS <arunks@mistralsolutions.com>
>
>
> Yes, it is there. but it shows as "tlv320aic23b" instead of "tlv320aic" Will
> that be the reason ????
Yes. Change it to tlv320aic23. Hope it is in the board file.

arch/arm/mach-omap1/board-osk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..e506aef 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -258,8 +258,10 @@ static struct i2c_board_info __initdata
osk_i2c_board_info[] = {
 		.platform_data	= &tps_board,

 	},
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1B),
+	},
 	/* TODO when driver support is ready:
-	 *  - aic23 audio chip at 0x1a
 	 *  - on Mistral, 24c04 eeprom at 0x50
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
-- 1.5.3.4



>
>
> On Tue, Oct 7, 2008 at 5:32 PM, Arun KS <arunks@mistralsolutions.com> wrote:
>
>> On Tue, Oct 7, 2008 at 5:24 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>> > On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:
>> >
>> >> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for the
>> past
>> >> few days. I got the driver patch from the linux-omap/alsa-devel mailing
>> >> lists. The driver got compiled along just fine. But when the kernel
>> boots,
>> >> no sound cards have been listed.
>> >
>> > CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
>> > support.
>> >
>> >> Advanced Linux Sound Architecture Driver Version 1.0.17.
>> >
>> >> ASoC version
>> >> 0.13.2
>> >> AIC23 Audio Codec
>> >> 0.1
>> >> MCLK = 12000000 [12000000], usecount =
>> >> 0
>> >> ALSA device
>> >> list:
>> >>     No soundcards
>> >> found.
>> >
>> >> Any one have tested this before ?
>>
>> Can you check i2c?
>>
>> # cat /sys/bus/i2c/devices/1-001b/name
>> tlv320aic23
>>
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
