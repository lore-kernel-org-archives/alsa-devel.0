From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [RFC/RFT PATCH] ALSA: hda - hdmi: Add ATI/AMD
 multi-channel audio support
Date: Wed, 25 Sep 2013 15:17:22 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206B5C9FD@041-DB3MPN1-091.041d.mgd.msft.net>
References: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
 <1380082956.1031.11.camel@Wailaba2> <5242EED4.3040001@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp3.itc.alstom.com (as-smtp3.itc.alstom.com
 [159.245.16.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EF7D265517
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 17:17:39 +0200 (CEST)
In-Reply-To: <5242EED4.3040001@iki.fi>
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
To: Anssi Hannula <anssi.hannula@iki.fi>, Olivier Langlois <olivier@trillion01.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, =?utf-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Anssi,

>
> Great to hear that, thanks. So Revision Id 3+ works :)
>
> I forgot to ask for it explicitely, but I guess you checked that channels
> seemed to mapped correctly (at least for each speaker you actually have)?

Absolutely. I haven't been explicit about it but I would have mention it if something was wrong in that regard. I have 8 speakers.

I have used speaker-test to test stereo, 5.1 and 7.1 mapping and the mapping is perfect.

One small detail that I have noticed is that there seem to be a small delay as I add more and more channels. With 8 channels, there might be up to 1 sec between the time speaker-test prints a channel name and the sound from previous chan stops and I start to hear noise from the new one.

I have concluded that this may come from my receiver that seem to reinitialize itself during each channel switch but I'm not totally sure.
>
> Also, could you paste the whole /proc/asound/card0/codec#0, for the
> record?

I'll provide that info to you when I'm back home later. For now, from what I remember, as it is the first thing that I have checked after having reloaded the driver with the patch, there is nothing printed there that reflect the new multi channel capability of the codec. but maybe it is me that does not know what to look for.

Also, if you want me to test functionality only available with my hardware revision, just prepare me small test cases. I'll be happy to run them. No chance that I run on 'advanced' features on my own as my ALSA usage is very simple.

Greetings,
Olivier


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
