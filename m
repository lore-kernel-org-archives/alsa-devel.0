From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: VIA VT1708 bugs
Date: Mon, 21 Mar 2011 14:56:18 +0800
Message-ID: <AANLkTimQGDYWF1-1n1fXruNvAmKY6b1xHNcwmAFe3scG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9D170243AD
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 07:56:19 +0100 (CET)
Received: by fxm6 with SMTP id 6so5003108fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 23:56:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> *Independent* headphone
>>
>> http://www.viaarena.com/forums/showthread.p*hp*?t=41015 <http://www.viaarena.com/forums/showthread.php?t=41015>

>Ok, that makes some sense. It translates to me as
>* With *independent* *HP* turned off - activates auto-mute between
>speaker-out/line-out and headphone out. Note the difference between VIA
>and Realtek/Sigmatel here as line-out are auto-muted as well.

>* With *independent* *HP* turned on - headphone out and speaker-out/line-out
>should take output from different PCM subdevices.

Practically, it is more complex than the above since the desktop
motherboard can have 3 , 5 or 6 audio jacks at rear panel

since those hda codecs only have 8 channels instead of 10

Enable Independent HP on a 6stack model should decrease
spec->mult_out.max_channels from 8 to 6 for subdevice 0

For 5 jacks model , the driver need to retask blue jack as side only
when independent HP switch is off

To support 8 channels for a 3stack model need to retask the front HP as side
