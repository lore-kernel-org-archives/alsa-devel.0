From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: [PATCH] Add support for gain in softvol plugin
Date: Thu, 03 May 2007 15:24:00 -0700
Message-ID: <463A6100.3070708@embeddedalley.com>
References: <463A33D8.3090907@embeddedalley.com>
	<Pine.LNX.4.61.0705032121110.7861@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by alsa0.perex.cz (Postfix) with SMTP id 059FD243B4
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 00:24:04 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0705032121110.7861@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 3 May 2007, Steve Longerbeam wrote:
>
>   
>> Hi all,
>>
>> What do you think of this patch? I tested this using a stac9205 HDA codec with
>> all sample formats supported by softvol (s32, s16, s24, big and little
>> endian).
>>     
>
> I would not add extra defines to alsa.conf:
>
> +defaults.pcm.dsnoop_softvol.card defaults.pcm.card
> +defaults.pcm.dsnoop_softvol.device defaults.pcm.device
>
> Simply reuse pcm.dsnoop.card / device.
>   
Hi Jaroslav,

How do I do this exactly? Should I add:

@args.CARD {
    type string
    default {
        @func refer
         name defaults.pcm.card
    }
}

to dsnoop_softvol.conf?

> Otherwise - it looks good. Nice softvol extension.
>
>   

thanks,
Steve
