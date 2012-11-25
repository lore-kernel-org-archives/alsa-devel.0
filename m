From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: EMU-1212m "no Audiodock - no firmware" patch
Date: Sun, 25 Nov 2012 19:05:37 +0000
Message-ID: <CAAMvbhHyG-W-vtu+wpq3JY-Uh-1uuK+5WC6+LJNEG3oy7z=J+A@mail.gmail.com>
References: <50AD5347.5040003@ya.ru> <s5h8v9tr1zu.wl%tiwai@suse.de>
 <50AE8681.3080409@ya.ru> <s5hy5hsk1gf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D25260317
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 20:05:38 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d4so5604700eek.38
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 11:05:38 -0800 (PST)
In-Reply-To: <s5hy5hsk1gf.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, oeai@ya.ru
List-Id: alsa-devel@alsa-project.org

Can I help at all?
I don't have much time spare, but I do have datasheets for some EMU cards.
The PCMCIA/Cardbus versions need a special startup sequence before you
can write or read any other registers.
Failing to follow the startup sequence causes a PCI fault on the bus
when you write to other registers on the card.
I have not read the code recently, but I think that is what
"ca_cardbus_chip = 1".
For any new cards, you can try removing it, and if you get a PCI fault
or hang on start up, put it back in.


On 23 November 2012 11:23, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 23 Nov 2012 00:09:37 +0400,
> oeai wrote:
>>
>> On 22.11.2012 21:17, Takashi Iwai wrote:
>> > Right now I fixed a few bugs regarding the firmware loading.
>> > It should have been improved by that.  Take a look at my recent posts
>> >    [PATCH 7/8] ALSA: emu10k1: cache emu1010 firmware
>> > and
>> >    [PATCH 8/8] ALSA: emu10k1: don't update firmware during suspend/resume
>> thanks, i'll try to find it and check, aren't they included yet?
>> i just don't know actually how to find some specific threads here actually
>
> At best, check sound git tree for-next branch.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>
>> >> so in the patch i've changed few more strings for debugging
>> > Hmm.  It's because you have no dock?
>> > What happens if you don't change this?
>> well the firmware is trying to load it endlessly and my cpu loads at
>> 100% but it loads only 1 core so that was not so much worse for me
>
> Does the firmware load happen all the time soon after loading the
> driver, or in certain situations?
>
>> >> and here i've changed that the emu_model was firstly enabled and then ecard - since i don't know what's the ecard is, i thought that it is a second module of my emu card.
>> > This should be harmless.  ecard is set only to Emu APS card, and
>> > exclusive with EMU 1x1x & co.
>> - well this card i think that i got and it depends on loading the first
>> part of E-MU as i think kinda a second part, so that's why i decided to
>> load it a little later.
>> i can find you a picture of the card it is providing IN OUT analog
>
> Emu APS code is very much irrelevant with your card.  So, don't add
> it.
>
>> > What are other essentially required changes?
>> well i've changed emufx and other file because they were loading some
>> libs and sliders that are not really needed by the emu_model
>
> OK, but this is a clean up instead of a fix.
> Let's postpone it.  Once after the device gets work stably, we can
> look back.
>
>> > Do both Emu1010b and Emu1212 have the same PCI SSID?  That sucks.
>> > I see you set ca_cardbus_chip=1 in the card entry.  Is it mandatory?
>> i think that the cardbus is related to that ecard and yes it looks like
>> they are the same when i
>>
>> lspci -s 07:05.0 -nn
>> 07:05.0 Multimedia audio controller [0401]: Creative Labs SB0400 Audigy2
>> Value [1102:0008]
>> i don't know how to set the subsystem
>
> The PCI SSID is set by the card itself, so this must be really a
> conflict with another existing card (emu1010b).  That's bad.
>
> The primary question is whether ca_cardbus_chip = 1 is mandatory.
> What happens if you don't set it?
>
>> > Last but not least, please use "diff -up" for creating a patch in the
>> > unified diff format.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> >
>> i've attached diff -u of all changes that i've made and in second reply
>> i've put the dar.bz2 file with all changed files (not sure if it is on
>> the deck)
>> so i'll send it to you too.
>>
>> i've tried to reply on my own thread today but i don't see the answer,
>> so i ll dulicate a message for you
>
> Did you subscribe to ML?  It's a moderated list, so you have to
> subscribe at first.
>
> Also, alsa-driver 1.0.25 is pretty old.
> Try the latest snapshot tarball instead
>   ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
