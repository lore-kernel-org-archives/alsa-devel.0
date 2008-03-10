From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 16:08:41 +0100
Message-ID: <47D54EF9.1080901@keyaccess.nl>
References: <20080308035828.E9403DBA2@gherkin.frus.com> <20080309153425.GA1391@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20080309153425.GA1391@jurassic.park.msu.ru>
Sender: linux-alpha-owner@vger.kernel.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bob Tracy <rct@frus.com>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09-03-08 16:34, Ivan Kokshaysky wrote:

> On Fri, Mar 07, 2008 at 09:58:28PM -0600, Bob Tracy wrote:
>> (1) Using the sox-based "play" command to play a short ".wav" file
>>     results in the file being played approx. 1.5 times, i.e., it plays
>>     all the way through, then restarts from the beginning and quits
>>     somewhere in the middle of the second playback.  At least the
>>     sound doesn't seem distorted...
>>
>> (2) Using "mpg123" results in silence at first, then after about 30
>>     seconds, a tight loop of random repeating sound (doesn't sound like
>>     part of the mp3 file, but it's probably derived from it :-)) until
>>     the process is forcibly killed.
> 
> Sounds like a DMA screwup. However, I'm pretty sure that it's not a
> generic ALSA problem with ISA DMA, as my good old GUS MAX still works
> perfectly on lx164 (machine that is very similar to your miata) as
> I checked yesterday with patched 2.6.25-rc4. :-)
> 
>> I have to hit <ctrl>C twice to interrupt playback.
>>
>> /proc/asound/cards looks normal:
>>
>>  0 [ES1888         ]: ES1888 - ESS AudioDrive ES1888
>>                       ESS AudioDrive ES1888 at 0x220, irq 5, dma1 1, dma2 5
> 
> I wonder if it still works on x86 - perhaps you ought to ask ALSA folks.
> I'll search my machine room next week - I recall that there were a dozen
> of old ISA soundcards, maybe there is some es18xx stuff, but chances
> are slim...

Missed the original mssage, adding alsa-devel. I have a few dozen es18xx's 
cards but no Alpha's. Am compiling a 2.6.25-rc4 onto an x86 test box now.

Rene.
