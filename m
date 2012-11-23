From: oeai <oeai@ya.ru>
Subject: Re oe to ta about latest drivers and so on: EMU-1212m
 "no Audiodock - no firmware" patch
Date: Sat, 24 Nov 2012 00:13:09 +0400
Message-ID: <50AFD8D5.50909@ya.ru>
References: <50AD5347.5040003@ya.ru> <s5h8v9tr1zu.wl%tiwai@suse.de>
 <50AE8681.3080409@ya.ru> <s5hy5hsk1gf.wl%tiwai@suse.de>
Reply-To: oeai@ya.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward12.mail.yandex.net (forward12.mail.yandex.net
 [95.108.130.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 6115326260B
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 21:13:12 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23.11.2012 15:23, Takashi Iwai wrote:
> At Fri, 23 Nov 2012 00:09:37 +0400,
> oeai wrote:
>>
> At best, check sound git tree for-next branch.
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

o k i ll try to diff it with my fix and original just in some later time 
- i'm writing music now, srry i want to create more sounds in few days, 
i've already spent 2 days on programming and debugging alot
and btw hows it works? what to do with git? i got own git in netbeans 
but still don't know how to use it more easy (maybe i'll it later)
ok
git clone - just right now, so i'll check it
do i need to get from latest snapshot?
>
> Does the firmware load happen all the time soon after loading the
> driver, or in certain situations?
- yep it was always when i was gettin out of suspend or reboot, with my 
fix it is not happening anymore but you need to ask some1 with audiodock 
to check if "!" is working
> Emu APS code is very much irrelevant with your card.  So, don't add
> it.
found it, ok i'll try to rem it and see what happens, but for me it is 
working right now when it is enabled and as i seen it it notebook i 
thought that it is similar to mine (there was a pcmcia version with 
audiodock-m so i think 1212 is a next gen of ecard)
>
>>> What are other essentially required changes?
>> well i've changed emufx and other file because they were loading some
>> libs and sliders that are not really needed by the emu_model
> OK, but this is a clean up instead of a fix.
> Let's postpone it.  Once after the device gets work stably, we can
> look back.
no it's not a clean up, i've really fixed the code check the .patch diff 
for other files i've set if (not emu_model){exec ac97 and spk71}
> The PCI SSID is set by the card itself, so this must be really a
> conflict with another existing card (emu1010b).  That's bad.
>
> The primary question is whether ca_cardbus_chip = 1 is mandatory.
> What happens if you don't set it?
well i'm not really sure, i don't like to reboot system everyweek, my 
last uptime was 23 days but because of the driver - it's changed and i 
had freezes few times when trying to wakeup the system and exec load 
firmware some other ways.

actually i need to know what is the ca_cardbus is ? and then see the 
code to check when it is loading and which registers needs to be checked.

>
> Did you subscribe to ML?  It's a moderated list, so you have to
> subscribe at first.
>
> Also, alsa-driver 1.0.25 is pretty old.
> Try the latest snapshot tarball instead
>    ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
>
> thanks,
>
> Takashi
yes, i'm subscribed and i was looking for latest drivers few times but 
the problem is that i'm banned as a tor-exit-node, so i've disabled tor, 
but still cannot access few sites - i cannot go to https://alsa.ftp  for 
example, so i've take some that i could, looks like i'll have to check 
all changes again?

================
goingto man diff then crazy


-- 
RA
OE
AI
