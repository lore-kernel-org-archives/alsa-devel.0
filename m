From: <ilkka.koskinen@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove CPVSS supply
Date: Wed, 19 May 2010 09:09:46 +0200
Message-ID: <F80267346F10C541946CBE8909F1C39E26E7BF8C6E@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
	<F80267346F10C541946CBE8909F1C39E26E7BF8C34@NOK-EUMSG-02.mgdnok.nokia.com>
	<20100519095345.a0fdcd52.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B9BD824549
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 09:09:51 +0200 (CEST)
In-Reply-To: <20100519095345.a0fdcd52.jhnikula@gmail.com>
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
To: jhnikula@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

 

>From: ext Jarkko Nikula [mailto:jhnikula@gmail.com] 
>Sent: 19 May, 2010 09:54
>On Wed, 19 May 2010 08:51:13 +0200
><ilkka.koskinen@nokia.com> wrote:
>
>> 
>> Hi,
>> 
>> On Tue, 18 May 2010, Jarkko Nikila wrote:
>> >I believe there is no need for the CPVSS supply as this pin is for
>> >decoupling capacitor for the internal charge pump.
>> 
>> Yes, you're right. I have a vague feeling that I put it there due to
>> some previous comments...
>> 
>> Anyway, I believe tpa6140's HPVdd is similar case and, thus, not
>> needed either. Would you like to make a patch for that or shall I do
>> it?
>> 
>I can do it and repost as it makes the patch even more simpler :-)

Great, I thought so too :)

And if you like, feel free to add Reviewed-by tag...

Cheers, Ilkka
