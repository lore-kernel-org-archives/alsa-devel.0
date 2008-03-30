From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sun, 30 Mar 2008 22:13:08 +1300
Message-ID: <47EF59A4.4070300@orcon.net.nz>
References: <20080318032427.298BCDBA2@gherkin.frus.com> <546A47FE-F98E-49E2-A250-41F65C2D482B@orcon.net.nz> <47E6338E.8030001@orcon.net.nz> <47E7EFDF.2070706@keyaccess.nl> <47E83F94.8010409@orcon.net.nz> <47E8475E.4080705@keyaccess.nl> <47E853F2.7020608@orcon.net.nz> <47E86203.5090805@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <47E86203.5090805@keyaccess.nl>
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bob Tracy <rct@frus.com>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 25-03-08 02:22, Michael Cree wrote:
> 
>>> should do it. Here's a file Bob passed me as a problematic one. 
>>> 8-bit, 11025, mono:
>>>
>>> http://members.home.nl/rene.herman/asskickd.wav
>>
>> Right, got that.  On the PWS600au it shows the same problems that Bob 
>> describes!  When I play it with aplay (through the es1887) I get the 
>> last "pal" repeated at the end.  When I play it with sox (also through 
>> the es1887) I get the words "current event" repeated at the end.
>> 
> Lovely, so different problem between you and Bob. When you (either of 
> you) have some time for it again, could you try:
> 
> $ sox asskickd.wav -w -t alsa hw

Exactly the same as without the -w option.  (BTW, I would've never have 
guessed the -w option; my man file has -2 for conversion to 16 bit.)

> $ sox asskickd.wav -w -r 44100 -t alsa hw

The words "current event" are no longer repeated at the end of playing. 
  There is a click at the end of playing - hard to know whether it 
started to repeat something or whether it is truly at the end of the 
sound file.

> $ sox asskickd.wav -w -r 44100 -c 2 -t alsa hw

Repeats the "al" bit of the last word "pal" at the end of playing.

>> I suspect you are right - the symptoms I have observed (complete 
>> system crashes) are separate from what Bob observes.  One question I 
>> have is what is different about Bob's set up that enables the sound to 
>> work with mmap?
> 
> Not a clue. Takashi -- is it possible that Bob wasn't using mmap to 
> being with if he didn't do anything specific to not do so?
> 
> And perhaps you guys have firmware settable options that touch that area 
> of coherent DMA? Maybe even a specific chipset bug on his machine? No 
> idea how different/similar your machines are...

I have another PWS600au - a little older than the one I was testing on. 
  It is slightly different in that its scsi controller is a separate 
board in a PCI slot, rather than on the motherboard.  Also has an 
ESS1888 rather than an ESS1887.  Just installed the same OS and kernel 
on it.

Tried playing sound.  What a mess. Crashes with mmap on.  Installed the 
patch turning off mmap.   Just produces buzzes and fart noises whatever 
sound file I try to play; both with aplay and sox.

Michael.

