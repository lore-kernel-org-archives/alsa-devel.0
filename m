From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add STAC92HD83XXX_PWR_REF quirk
Date: Thu, 22 Jan 2009 08:23:03 -0500
Message-ID: <49787337.3030406@embeddedalley.com>
References: <4977A42F.5030903@embeddedalley.com> <s5h7i4nx2mf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 6B326243FE
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 14:23:31 +0100 (CET)
In-Reply-To: <s5h7i4nx2mf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 21 Jan 2009 17:39:43 -0500,
> Matthew Ranostay wrote:
>> @@ -334,7 +335,7 @@ static hda_nid_t stac92hd83xxx_slave_dig_outs[2] = {
>>  };
>>  
>>  static unsigned int stac92hd83xxx_pwr_mapping[4] = {
>> -	0x03, 0x0c, 0x20, 0x80,
>> +	0x03, 0x0c, 0x20, 0x40,
>>  };
> 
> What is this change?
> 
>
>From my patch before I made a mistake, somehow I thought port 0xe was 0xf in that
change. Sorry for the inconvenience.

Thanks,

Matt
 
> thanks,
> 
> Takashi
> 
