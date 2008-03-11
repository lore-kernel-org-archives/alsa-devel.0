From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 09:00:13 +1300
Message-ID: <ED0F0070-B876-4D8B-8F88-879E01AB4326@orcon.net.nz>
References: <20080311180831.8CE90DBA3@gherkin.frus.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20080311180831.8CE90DBA3@gherkin.frus.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Bob Tracy <rct@frus.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

On 12/03/2008, at 7:08 AM, Bob Tracy wrote:

> Rene Herman wrote:
>> This is behaviour consistent with the IRQ being dead ...
>>
>> I suppose it used to work and I suppose the behaviour
>> you are describing above is 100% repeatable?
>
> I can't tell you exactly *when* it used to work, or even *if* it did
> with 2.6 kernels.  I'll try to explain...
>
> Sometime back in the 2.6.14 to 2.6.16 timeframe there was an issue  
> with
> the ALSA driver not recognizing interrupts (causing looping)

Yes, the ESS1888 driver failed to work on Alpha about the 2.6.14 to  
2.6.16 kernel.   It came right with alsa release 1.0.13 (IIRC) and I  
have been running the ESS1888 driver on an Alpha XP1000 without  
problems for about a year.  I have been using mocp and mplayer on a  
fairly regular basis.  My Mplayer version uses the OSS interface by  
default.  Not sure, off-hand, what mocp is using.

For the last three months I have been playing with other sound cards  
(the quality of sound from the ESS1888 leaves a lot to be desired,  
imho) and haven't used the ESS1888 recently, so if a regression has  
been introduced after kernel 2.6.22 then it is likely I wouldn't see it.

Sorry, but I am not in a good position to do testing of the ESS1888 at  
the moment.  A week or so ago my system and home partitions shat  
themselves and I had to reinstall from 3 month old backups.  It has  
just happened again - two nights ago.  Don't know what is causing it -  
whether it is hardware fault (I can't find any disc block errors), the  
2.6.24.2 (and 2.6.24.3) kernels I had recently upgraded to, or the  
recent update from Debian testing, or the switch from the internal  
SCSI card and disc to an installed SATA card and disc that I did three  
months ago (though that one has worked for the first two and a half  
months without flaw).  Maybe I should start a new thread with a report  
of that just in case it is a kernel problem???

Michael.

