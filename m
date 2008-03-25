From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 25 Mar 2008 03:22:59 +0100
Message-ID: <47E86203.5090805@keyaccess.nl>
References: <20080318032427.298BCDBA2@gherkin.frus.com>
	<546A47FE-F98E-49E2-A250-41F65C2D482B@orcon.net.nz>
	<47E6338E.8030001@orcon.net.nz> <47E7EFDF.2070706@keyaccess.nl>
	<47E83F94.8010409@orcon.net.nz> <47E8475E.4080705@keyaccess.nl>
	<47E853F2.7020608@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 16DFE24606
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 03:21:50 +0100 (CET)
In-Reply-To: <47E853F2.7020608@orcon.net.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

On 25-03-08 02:22, Michael Cree wrote:

>> should do it. Here's a file Bob passed me as a problematic one. 8-bit, 
>> 11025, mono:
>>
>> http://members.home.nl/rene.herman/asskickd.wav
> 
> Right, got that.  On the PWS600au it shows the same problems that Bob 
> describes!  When I play it with aplay (through the es1887) I get the 
> last "pal" repeated at the end.  When I play it with sox (also through 
> the es1887) I get the words "current event" repeated at the end.
> 
> Playing through the CM8738 also repeats the words "current event" at the 
> end when playing with sox.  But using aplay through the CM8738 only 
> results in silence and aplay hangs.  A ctrl-c successfully breaks it.

Lovely, so different problem between you and Bob. When you (either of you) 
have some time for it again, could you try:

$ sox asskickd.wav -w -t alsa hw
$ sox asskickd.wav -w -r 44100 -t alsa hw
$ sox asskickd.wav -w -r 44100 -c 2 -t alsa hw

and report if things start working? First transforms into 16-bit, second 
16-bit and 44100 rate, third 16-bit, 44100 rate, stereo.

> I suspect you are right - the symptoms I have observed (complete system 
> crashes) are separate from what Bob observes.  One question I have is 
> what is different about Bob's set up that enables the sound to work with 
> mmap?

Not a clue. Takashi -- is it possible that Bob wasn't using mmap to being 
with if he didn't do anything specific to not do so?

And perhaps you guys have firmware settable options that touch that area of 
coherent DMA? Maybe even a specific chipset bug on his machine? No idea how 
different/similar your machines are...

> On the XP1000 (which has an unmodified kernel 2.6.24.3) I managed to 
> play the sound file once with aplay through the es1887 (and it repeated 
> "pal" at the end).  Then I tried using sox and complete silence 
> resulted.   No,  it's just playing back at the wrong rate - everything 
> is sounding slow and extremely flat - the silence is just the artefact 
> of a little bit of silence at the start of the file being played at far 
> too a slow sample rate.  Even other client programs are affected - mocp 
> is playing back music at a horrendously slow sample rate. Yuk. Hopefully 
> a rmmod es1887 might fix that - but I can't test it to I send this 
> message and shut down X.
> 
> Anyway I really must start marking that pile of assignments I told the 
> students that I would have done by tomorrow.  Further testing will have 
> to wait to later this week.

No rush. Thanks for the current amount of testing already.

Rene.
