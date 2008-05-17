From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: v2.6.25.3 BUG (due to usb audio device?)
Date: Sat, 17 May 2008 07:50:08 -0700
Message-ID: <3aa654a40805170750x6e88368k56b3d88035c97a41@mail.gmail.com>
References: <3aa654a40805110953s66a27271y4356cb3d032dcb38@mail.gmail.com>
	<s5hiqxie988.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D543124B19
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 16:50:09 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so797914ywk.2
	for <alsa-devel@alsa-project.org>; Sat, 17 May 2008 07:50:08 -0700 (PDT)
In-Reply-To: <s5hiqxie988.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 4:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 11 May 2008 09:53:01 -0700,
> Avuton Olrich wrote:
>>
>> This locks up KDE due to kmixer somehow trying to stay attached to the
>> audio device after resume from suspend-to-disk. This is the second
>> time of dealing with this (or a similar bug) with the usb audio
>> device:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006867.html
>>
>> I got it working by using the head of the git tree recommended in that
>> thread (unfortunately I don't have the hash it was related to).
>
> If the recent git works, it should be the series of my patches:
>
> 73d38b13ffb105ab633bd91969c8d218b2de38d4
>        [ALSA] Fix the race of card instance unregistration
> f18638dcf0c481eca2430206ebcdc7295aec8623
>        [ALSA] Clean up snd_card_free*()
> 9eb70e68f38bbc5996a2193e7b7dc0b5487a08cb
>        [ALSA] usb-audio - Fix race in reconnection
>
> But the patches are intrusive, and I'm not keen on applying them to
> stable trees...

OK, finally had the time to try the newer master and here's what I get now;

I suspend and resume fine, but the sound card no longer works again
after resume and the only thing I see in the dmesg is:

[  125.873947] usb 3-1: reset full speed USB device using ohci_hcd and address 2
[  126.017265] snd-usb-audio 3-1:1.0: no reset_resume for driver snd-usb-audio?
[  126.017265] snd-usb-audio 3-1:1.1: no reset_resume for driver snd-usb-audio?
[  126.017265] snd-usb-audio 3-1:1.2: no reset_resume for driver snd-usb-audio?


-- 
avuton
--
 "I've got a fever. And the only prescription is more cowbell." --
Christopher Walken
