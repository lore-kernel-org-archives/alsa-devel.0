From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 7 Jul 2009 12:05:45 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3560F246DA
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:36:08 +0200 (CEST)
In-Reply-To: <20090704105743.GD10490@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Saturday, July 04, 2009 4:28 PM
>To: Koul, Vinod
>Cc: alsa-devel@alsa-project.org; Harsha, Priya
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Fri, Jul 03, 2009 at 12:36:15PM +0530, Vinod Koul wrote:
>
>> +	case SND_FS:
>> +		if (intsts & 0x1) {
>> +			/*send long push*/
>> +			ret_val = snd_intelmad_generate_netlink(1,
>> +						AUDIO_EVENT_LONG_PRESS);
>> +		}
>> +		if (intsts & 0x2) {
>> +			/*send short push*/
>> +			ret_val = snd_intelmad_generate_netlink(1,
>> +						AUDIO_EVENT_SHORT_PRESS);
>> +		}
>> +		if (intsts & 0x4) {
>> +			/*send headphone detect*/
>> +			ret_val = snd_intelmad_generate_netlink(1,
>> +						AUDIO_EVENT_HP_DETECT);
>> +		}
>> +		if (intsts & 0x8) {
>> +			/*send headset detect*/
>> +			ret_val = snd_intelmad_generate_netlink(1,
>> +						AUDIO_EVENT_HS_DETECT);
>> +		}
>> +		break;
>
>ALSA core has an interface for representing jacks to user space which
>should be used here - see include/sound/jack.h.
Thanks for the note. I shall look into it further. Can you suggest any example ALSA driver that uses this functionality so that I can have a reference. Also quick question around this, can I use this jack.h to event the user space?

>
>> +	case SND_MX:
>
>> +	case SND_NC:
>
>Looks like you've got one of these per vendor - does this need to be
>placed into the vendor abstraction?
Yes, I can place them in vendor abstractions. It would make more sense that way. I shall change it when I resubmit the patches. 

Thanks,
Harsha
