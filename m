From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Mon, 08 Jul 2013 01:09:55 +0200
Message-ID: <51D9F543.2070605@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 7426F26519F
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 01:09:58 +0200 (CEST)
Received: by mail-wi0-f181.google.com with SMTP id hq4so3412487wib.14
 for <alsa-devel@alsa-project.org>; Sun, 07 Jul 2013 16:09:58 -0700 (PDT)
In-Reply-To: <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/07/13 23:38, Adam Williamson wrote:
> On 2013-07-05 5:29, Takashi Iwai wrote:
>
>>> This is the debian 3.9.6 kernel + alsa-compile to get "debug=2" for
>>> snd.ko module to work as by default the CONFIG_SND_DEBUG is not set in
>>> debian kernels.
>>
>> OK, looking at two outputs, the difference is that the recent kernel
>> allows the 5.1 output configuration with two mic jacks.  But, this
>> looks rather strange as a laptop.  Does the machine have really two
>> microphone jacks?  The BIOS sets pins 0x18 and 0x19 are mic jacks.
>
> I feel like this was the issue the LAST time it stopped working, too.
> No, the system does not have two mic jacks - at least, there is only
> one visible and accessible to the user on the outside of the case, on
> my model.
Actually... there should be three mic channels:
     The built-in (internal) microphone
     +
     One mic jack beside the headphone jack
     +
     One other hidden within the headphone jack:
     (a) the Notebook came with Noise-cancelling headsets, but they are 
small in-ear plugs so there is no place for noise-cancelling logic in 
the plugs
     (b) I think I remember to have read somewhere that this thingy 
actually needs the windows driver installed to be noise-cancelling!
     (c) the PLUG of these headphones have another channel (visible 
through another ring on the jack)

This explains the 2nd mic channel :)

In addition, I will try also to verify this plugging the special 
headphones and watching the alsamixer input meter(s).
But of course them not showing would not prove anything as the linux 
driver might just not be setup correctly.

>> You have three items in "Capture Source", Internal Mic, Mic and Mic 1.
>> Which inputs are working actually?  If one of the last two is bogus,
>> we can disable it, then we can the unused pin.  For example, a patch
>> to disable the pin 0x19 would be like below.
>
> I don't have a working kernel on mine at present, but if Tormen can't
> provide this info soon, I'll track one down and provide it. I expect
> that one of the latter two inputs must be bogus.
It's ok I am on it. I started this and now I will see it through until 
the end (otherwise I would have let you know :).

Do you need this info for the working kernel only ? Or also for 3.9.6 ?
I'll test that tomorrow then.
I also wanted to take a look at the two patches and your explanations 
about them and test them for you.

Should they apply well to 3.9.6 ?

Thanks !

Tormen
