From: Nikolay Dimitrov <picmaster@mail.bg>
Subject: Re: [PATCH V2] ASoC: sgtl5000: add delay before first
 I2C access
Date: Fri, 30 Jan 2015 23:50:20 +0200
Message-ID: <54CBFC9C.5060906@mail.bg>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
 <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
 <CAOMZO5BwM1CEAtFnqxS9xwSy2OamHCuEw=YBT8vf5FNa_4GA7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mail.bg (mx2.mail.bg [193.201.172.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C62EE260580
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 22:50:27 +0100 (CET)
In-Reply-To: <CAOMZO5BwM1CEAtFnqxS9xwSy2OamHCuEw=YBT8vf5FNa_4GA7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On 01/30/2015 11:31 PM, Fabio Estevam wrote:
> Hi Eric,
>
> On Fri, Jan 30, 2015 at 7:07 PM, Eric Nelson
> <eric.nelson@boundarydevices.com> wrote:
>> To quote from section 1.3.1 of the data sheet:
>>          The SGTL5000 has an internal reset that is deasserted
>>          8 SYS_MCLK cycles after all power rails have been brought
>>          up. After this time, communication can start
>>
>>          ...
>>          1.0uS represents 8 SYS_MCLK cycles at the minimum 8.0 MHz SYS_MCLK.
>
> Small detail: Should be us instead of uS.

FYI - If you're observing issues with communicating with SGTL5000 I2C,
please make sure also that the chip has a valid clock signal on
SYS_MCLK, otherwise it won't respond on I2C transactions (I2C will work
with any SYS_MCLK in the range 8-27MHz).

Kind regards,
Nikolay
