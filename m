From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT PATCH] ALSA: hda - hdmi: Add ATI/AMD
 multi-channel audio support
Date: Thu, 26 Sep 2013 01:21:36 +0300
Message-ID: <524361F0.80009@iki.fi>
References: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
 <1380082956.1031.11.camel@Wailaba2> <5242EED4.3040001@iki.fi>
 <89F8E4011FD7234ABFE48744E300CBC206B5C9FD@041-DB3MPN1-091.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id D460A265590
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 00:21:44 +0200 (CEST)
In-Reply-To: <89F8E4011FD7234ABFE48744E300CBC206B5C9FD@041-DB3MPN1-091.041d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Cc: Takashi Iwai <tiwai@suse.de>, Olivier Langlois <olivier@trillion01.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, =?UTF-8?B?UGV0ZXIgRg==?= =?UTF-8?B?csO8aGJlcmdlcg==?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

25.09.2013 18:17, LANGLOIS Olivier PIS -EXT kirjoitti:
> Anssi,
> 
>>
>> Great to hear that, thanks. So Revision Id 3+ works :)
>>
>> I forgot to ask for it explicitely, but I guess you checked that channels
>> seemed to mapped correctly (at least for each speaker you actually have)?
> 
> Absolutely. I haven't been explicit about it but I would have mention it if something was wrong in that regard. I have 8 speakers.
> 
> I have used speaker-test to test stereo, 5.1 and 7.1 mapping and the mapping is perfect.
> 
> One small detail that I have noticed is that there seem to be a small delay as I add more and more channels. With 8 channels, there might be up to 1 sec between the time speaker-test prints a channel name and the sound from previous chan stops and I start to hear noise from the new one.

This happens with other hw as well, I think speaker-test simply does not
account for PCM playback latency when displaying the channel names.

> I have concluded that this may come from my receiver that seem to reinitialize itself during each channel switch but I'm not totally sure.
>>
>> Also, could you paste the whole /proc/asound/card0/codec#0, for the
>> record?
> 
> I'll provide that info to you when I'm back home later. For now, from what I remember, as it is the first thing that I have checked after having reloaded the driver with the patch, there is nothing printed there that reflect the new multi channel capability of the codec. but maybe it is me that does not know what to look for.

That is expected, I'm just generally interested in the contents (pin
connections etc).

> Also, if you want me to test functionality only available with my hardware revision, just prepare me small test cases. I'll be happy to run them. No chance that I run on 'advanced' features on my own as my ALSA usage is very simple.

Nothing more special to test on your hw at this time, I think :)
I will get back to you if something comes up.

-- 
Anssi Hannula
