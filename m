From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help implementing an external PCM/control
	plugin pair
Date: Tue, 20 Feb 2018 12:06:39 +0200
Message-ID: <b07ebbaa-021d-6ce5-0d35-8f8b152514e1@gmail.com>
References: <0daf8a5e-c1dd-224e-52e7-7467d93aa045@gmail.com>
 <4deee929-ae8c-c330-d9d1-865c558a3b75@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
 [209.85.128.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 576DB267096
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 11:06:43 +0100 (CET)
Received: by mail-wr0-f175.google.com with SMTP id v65so12602472wrc.11
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 02:06:43 -0800 (PST)
In-Reply-To: <4deee929-ae8c-c330-d9d1-865c558a3b75@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I managed to implement the control aspect of the plugin using user 
control elements and it seems to work fine, including dB ranges and 
event metadata.  Thanks again for your pointers.  A couple further points:

1. I used an async ctl handler (snd_async_add_ctl_handler) to get 
notified about changes to the controls and it seems to work as intended. 
  Are there any caveats I'm missing?  Is there perhaps a more 
appropriate approach?

2. Is there some way to create a virtual ctl/mixer device, that'll 
inherit the card's controls and to which I can inject my own elements, 
without affecting the mixer of the card?  There are two reasons why this 
would be desirable.  From a practical aspect, it would make uninstalling 
the plugin easier, as right now, once the controls are added to the 
card's mixer and stored by alsactl, it is non-trivial to remove them 
again.  Apart from that, it would make the interface a bit more 
consistent, as it would allow the plugin to present a separate virtual 
card of sorts, with its own PCM and mixer, instead of hijacking the 
card's mixer and injecting controls which are irrelevant, when the card 
is used on its own.

D.
