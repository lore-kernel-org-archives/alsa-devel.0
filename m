From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Tue, 13 May 2014 15:27:47 +0300
Message-ID: <53720FC3.7000608@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org> <529004F8.7070801@iki.fi>
 <20131123154009.6c8c6e97@symphony.aura-online.co.uk>
 <5290CD7C.7020907@iki.fi>
 <20131124145737.22056256@symphony.aura-online.co.uk>
 <52934E97.9060701@iki.fi> <20131125143228.55c94550@red>
 <52936537.8020506@iki.fi> <20140513130126.1755fa16@red.yakaraplc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 471192654D9
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 15:04:09 +0200 (CEST)
In-Reply-To: <20140513130126.1755fa16@red.yakaraplc.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

13.05.2014 15:01, James Le Cuirot kirjoitti:
>>>>>>>>>
>>>>>>>>> Hi Anssi. Many thanks for your work on this. I am very keen to
>>>>>>>>> test this new code but have so far been unsuccessful. I have a
>>>>>>>>> Radeon 4670 (Sapphire branded) connected to a Yamaha RX-V773.
>>>>>>>>> I am running the sound/for-next kernel (82755ab) with your
>>>>>>>>> "missing PCM SAD" patch applied.
>>>>>>>>>
[...]
> Guess it wasn't so "soon" after all. This dropped down my priority
> list and then my receiver blew up. I ended up getting the newer
> equivalent model, the RX-V775. Despite that, the problem persists,
> even on a current sound "master" kernel.
> 
> There has been a little change though. I now get an ELD. This shows
> what I would expect based on my receiver.
> 
> https://gist.github.com/chewi/7628058
> 
> I note that speaker-test doesn't allow me to specify -c6 anymore, only
> -c8. Maybe that's because of the ELD. I do have a kernel log but not to
> hand right now. It only seems to show what appears to be normal output
> anyway.
> 
> I was keen to try fglrx but realised I can't because this card is only
> supported by the legacy driver and that only works with kernels up to
> around 3.7.
> 
> I did try my wife's Ivy Bridge laptop and that worked straight away
> with no difficulties using the same HDMI cable so it seems that the
> receiver isn't to blame.
> 
> I wanted to rule my Gentoo system out so I booted with Ubuntu 14.04 on
> a USB stick and got exactly the same results.
> 
> I've tried everything else I can think of like not having my stereo
> monitor connected at the same time. I would dig in to the code but as
> you have previously commented, everything *looks* fine, so I don't know
> where to begin. I may just have to get a newer card but that wasn't an
> investment I was planning to make just yet. :( Any further suggestions
> are appreciated.

Unfortunately I've been told that HD 4xxx cards and older do not support
multichannel playback, which I didn't know at the time (and I had
forgotten your case, hence I didn't get back to you - sorry about that).

It is a bug that the driver allows the user to try to playback more than
2 channels on such cards as well, which I have in my TODO list to fix.
Thanks for the reminder, though I guess it doesn't help much with your
situation.

-- 
Anssi Hannula
