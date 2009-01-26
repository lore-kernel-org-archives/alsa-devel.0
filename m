From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: 92hd71xxx disable unmute support for
 codecs that don't have input amps.
Date: Mon, 26 Jan 2009 06:51:13 -0500
Message-ID: <497DA3B1.1040002@embeddedalley.com>
References: <497B69C3.2030807@embeddedalley.com> <s5hljsy5tmy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 1DD7A1037EE
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 12:51:30 +0100 (CET)
In-Reply-To: <s5hljsy5tmy.wl%tiwai@suse.de>
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
> At Sat, 24 Jan 2009 14:19:31 -0500,
> Matthew Ranostay wrote:
>> @@ -5031,6 +5032,9 @@ again:
>>  		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
>>  	}
>>  
>> +	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
>> +		snd_hda_sequence_write(codec, unmute_init);
> 
> This sequence should be cached so that it'll be replayed at
> suspend/resume.
> 
Good catch, can't believe I missed that.

> Could you fix and repost?
> 
Yep.


Thanks,

Matt Ranostay
> 
> thanks,
> 
> Takashi
> 
