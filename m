From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: panda: Correct cpu version check for 4430
Date: Tue, 28 Feb 2012 09:33:51 +0200
Message-ID: <4F4C835F.9020900@ti.com>
References: <1329470861-29795-1-git-send-email-peter.ujfalusi@ti.com> <20120222230446.GU18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120222230446.GU18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/23/2012 01:04 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:56]:
>> The cpu_is_omap4430() macro always return with 0. Use the correct
>> cpu_is_omap443x() to check for Panda revision.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>
>> Hi,
>>
>> Since the depending patches are going via Liam's tree it would be be=
st if we
>> can queue this via audio as well.
>> Without this patch the audio on Panda 4430 is not working correctly.
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Liam can you pick this patch since it is needed for Panda to correctly
identify the 4430/4460 version of the board.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
