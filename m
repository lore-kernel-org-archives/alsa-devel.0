From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Fri, 20 Mar 2015 23:45:40 +0900
Message-ID: <550C3294.7020003@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp> <550C0CFC.4060404@gareus.org>
 <550C1FC6.4050700@sakamocchi.jp> <s5hmw376bck.wl-tiwai@suse.de>
 <550C25DD.3080507@sakamocchi.jp> <s5hfv8z69jz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 06EA72655B6
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 15:45:45 +0100 (CET)
In-Reply-To: <s5hfv8z69jz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, clemens@ladisch.de, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mar 20 2015 23:13, Takashi Iwai wrote:
> At Fri, 20 Mar 2015 22:51:25 +0900,
> Takashi Sakamoto wrote:
>>
>> On Mar 20 2015 22:35, Takashi Iwai wrote:
>>>> I don't think it possible to argue the other ALSA developers for going
>>>> to include such vendor-specific or model-specific huge codes to
>>>> alsa-lib... (Except for intel HDA)
>>>
>>> Why not implementing as a plugin?
>>
>> As long as I know, we cannot write any configuration to load it for 'hw'
>> node. On the other hand, when adding any nodes like 'bebob' or 'dice',
>> they always stay in alsa-lib configuration space even if there're no
>> actual devices connected.
>>
>> If my understanding is wrong, please inform it to me.
> 
> You seem mixing up how to use the plugin setup and how to write the
> plugin...  The usage with a plugin might be more complex indeed, but
> it's more or less same no matter whether you implement in alsa-lib
> itself or implement as an external plugin.

Sorry, but I consider about one-step future.

I think it possible to discuss constructively about such plugins for
alsa-plugins, while its usage is not so easy for usual users of FireWire
audio devices. I can imagine to receive much requests about
improvements, then consider about including it to alsa-lib itself. But
this idea may be hard to achieve because of the reasons I describe.

I felt a bit unhappiness about your question and had a logic jump,
sorry. I'm not so tough developer...


Regards

Takashi Sakamoto
