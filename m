From: Jon <jon@seniorblanco.com>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6: C-Media
 CMI8738 (model 55)
Date: Thu, 21 Aug 2014 15:07:35 -0700
Message-ID: <53F66DA7.4010807@seniorblanco.com>
References: <53EA40EB.2060201@seniorblanco.com>
 <53EB80C3.7020909@ladisch.de>	<53EB9C3B.2070602@seniorblanco.com>
 <53F53B4C.20905@seniorblanco.com> <53F5CA80.8020300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thetis.seniorblanco.com
 (108-227-52-43.lightspeed.irvnca.sbcglobal.net [108.227.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DFD4D2658E8
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 00:08:26 +0200 (CEST)
In-Reply-To: <53F5CA80.8020300@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/21/2014 03:31 AM, Clemens Ladisch wrote:
> Jon wrote:
>> i/o error and resulting 44-byte file of silence.
>
> This indicates that the chip does not see any S/PDIF signal.
>
> Can't you connect some S/PDIF output to an input for testing?

Well, I have tried connecting its own output to its input (both via 
optical and coax) but that doesn't change anything.  Unfortunately I 
have no other devices with S/PDIF inputs to test with, though the 
optical cable lights up when I toggle "S/PDIF Output" to on, and if I 
attempt to play to the iec958 alsa device then "S/PDIF Out To DAC" and 
"S/PDIF Out" both also automatically enable themselves in alsamixer and 
I get no errors, so I suspect the digital *output* is probably working 
fine.  I have other devices with S/PDIF outputs that I have tested 
connecting to this device's input, however, again, no change.

>
>> I'm wondering if this problem could be really just as simple as
>> someone having guessed wrong about the correct value there having not
>> had this particular model on hand to test with?
>
> C-Media chips were very common once upon a time, and S/PDIF input always
> worked just fine for everybody else.  There are no GPIOs, so the only
> possible hardware implementation is to connect the S/PDIF input directly
> to the chip's input pin(s).

A quick search for this in google: cmipci input/output error

...shows several other various mail and forum archive listings of people 
having the same exact problem as me with model 55 of this card in alsa, 
going at least as far back as 2003.

https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg06771.html

Going from this one right here I just now discovered that if I directly 
connect the card's digital output to its own input, start speaker-test 
in one terminal, then quickly open alsamixer in a another terminal 
*after* I start recording with arecord in a third terminal and then 
manually toggle the "IEC958 In Record" (which at that point has turned 
itself on automatically) to off, and if I am quick enough to beat the 
i/o error, arecord then records an arbitrary amount of silence instead 
of erroring out. (I let it go until the file reached 11MB just to test) 
If I don't do this however, arecord still gives me the i/o error and exits.

Preemptively turning the "IEC958 In Record" to ON before starting the 
arecord attempt also still gives me an i/o error.

Might this new observation be of any significance?

Thanks,
Jon
