From: Randell Jesup <randell1@jesup.org>
Subject: Re: Use of _hint() functions and older machines
Date: Mon, 24 Oct 2011 01:19:47 -0400
Message-ID: <4EA4F573.9060704@jesup.org>
References: <4EA0E6E5.1050600@jesup.org> <4EA3EE43.3010904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from r2-chicago.webserversystems.com
	(r2-chicago.webserversystems.com [173.236.101.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 336C42414C
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 07:24:44 +0200 (CEST)
In-Reply-To: <4EA3EE43.3010904@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Randell Jesup <randell1@jesup.org>
List-Id: alsa-devel@alsa-project.org

On 10/23/2011 6:36 AM, Clemens Ladisch wrote:
> On 10/21/2011 05:28 AM, Randell Jesup wrote:
>> On older machines, _hint() aren't available, so even if I make them
>> optional to dlsym-loading, I would need some other method to get the
>> information I assume using older, now-deprecated-or-gone interfaces.
>
> On older machines, that information wasn't available at all.
>
> The recommendation was to use "default" or to let the user enter
> a device name.

Ah.  Ok.  Wow, was it really that painful?  I didn't do a lot of Linux 
media stuff back then, and generally had only built-in-audio (no USB 
headsets, etc) with simple speakers.

> The best way to get a list of devices would have been to enumerate sound
> cards with snd_card_next(), then use device names "default:CARD=x".
> However, this gets only the primary device of each card, there might be
> sound cards without a PCM device, devices not based on an ALSA kernel
> driver aren't listed, and the "default:CARD=x" mechanism doesn't work if
> the user has redefined the "default" device.

Ugh.  So, there's no reasonable way to get a user-understandable list 
before .14?  How useful was 
snd_ctl_card_info_get_name()/snd_ctl_card_info()?  And I guess I'd need 
to enumerate the 'devices' and 'subdevices' on each card as well...

Thanks for the info, BTW

-- 
Randell Jesup
randell-ietf@jesup.org
