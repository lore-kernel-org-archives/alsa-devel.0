From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Fri, 05 Jul 2013 14:38:49 -0700
Message-ID: <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id C99AE2658D4
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 23:38:52 +0200 (CEST)
In-Reply-To: <s5h1u7dchqh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Tormen <my.nl.abos@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2013-07-05 5:29, Takashi Iwai wrote:

>> This is the debian 3.9.6 kernel + alsa-compile to get "debug=2" for
>> snd.ko module to work as by default the CONFIG_SND_DEBUG is not set in
>> debian kernels.
> 
> OK, looking at two outputs, the difference is that the recent kernel
> allows the 5.1 output configuration with two mic jacks.  But, this
> looks rather strange as a laptop.  Does the machine have really two
> microphone jacks?  The BIOS sets pins 0x18 and 0x19 are mic jacks.

I feel like this was the issue the LAST time it stopped working, too. 
No, the system does not have two mic jacks - at least, there is only one 
visible and accessible to the user on the outside of the case, on my 
model.

> You have three items in "Capture Source", Internal Mic, Mic and Mic 1.
> Which inputs are working actually?  If one of the last two is bogus,
> we can disable it, then we can the unused pin.  For example, a patch
> to disable the pin 0x19 would be like below.

I don't have a working kernel on mine at present, but if Tormen can't 
provide this info soon, I'll track one down and provide it. I expect 
that one of the latter two inputs must be bogus.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
