From: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Subject: Re: Firewire Audio Card Support
Date: Thu, 18 Nov 2004 19:36:55 +0000
Message-ID: <419CF9D7.6050101@esat.kuleuven.ac.be>
References: <31148074.1100630541337.JavaMail.root@scooter.psp.pas.earthlink.net> <419C9D47.4090606@x-i.net> <200411181515.52218.olaf@solutionworks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411181515.52218.olaf@solutionworks.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Christ <olaf@solutionworks.de>
Cc: linux-audio-user@music.columbia.edu, linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Regarding firewire audio support:
We are currently working on a generic driver for DM1000 based firewire 
audio cards by BridgeCo. I don't know if the motu device is based upon 
this chipset. If it is, chances are that the driver will also work for 
you. But at this point the development is still in a very preliminary state.

The good news is that there is a standard for the firewire audio/midi 
transport protocol. This means that the core part of the driver will be 
the same for all firewire devices. The bad news is that the actual setup 
of the device (mixer settings i.e.) doesn't conform to a standard. The 
only problem is that experience learns that not every manufacturer 
implements the standards (correctly).

Regarding the manufacturer support:
The only thing we can do is promote the manufacturers that are willing 
to cooperate. I'll give an overview of my personal experience:
* I had real good experience up till now with ESI (Ego Systems inc). I 
sent some manufacturers using the DM1000 chipset a notification that in 
order to support their product, I would need
a device to fool around with. About two reply's and a few weeks later, I 
received their QuataFire 610 box. Excellent...
* The people at M-Audio also use the DM1000 chipset, and I also 
contacted them. They replied and wanted to provide a device, but they 
modified the reference firmware, and couldn't provide any info on their 
firmware... Maybe this will change once there is a driver available that 
only needs to be adapted for their stuff. I don't know, I still hope 
that this
* Two other company's using the DM1000 in their products and whom I 
contacted were Edirol and Terratec. I din't receive any response from 
them yet, not even a confirmation. The mails were sent more than a month 
ago.
* Another card I would really like to see ALSA support for is the EMU 
DAS range (1820 etc). So I contacted E-MU/Creative Labs to see if they 
were willing the cooperate. The product manager for these products was 
quite enthousiastic. But after 6 months of e-mail traffic the upper 
management descided that they wouldn't give out any info on the DSP. End 
of story.
* My first attempt at driver development was for the Guillemot 
(=Hercules) Maxi Studio ISIS. There was no support at all from 
Guillemot, they wouldn't even reply to emails. I ended up blowing up my 
own ISIS in numerous attempts to figure out the workings of the device. 
My overall advice on Guillemot/Hercules: stay away from them.

To summarize: If I were to buy a card at this point, I would first go 
and check if ESI has a product that fullfills my needs. That is the only 
pressure I can put on manufacturers.

Greets,

Pieter Palmers
freebob.sf.net

Olaf Christ wrote:

>Hi,
>
>as the owner of a firewire audio card (Motu 828mkII) I was disappointed when 
>trying to use it under linux. Asking Motu to provide tech docs and/or linux 
>drivers is useless: "We will possibly release linux drivers in the future, 
>but we never release any kind of technical documentation."
>Is there any effort to join forces for putting pressure on the manufacturers 
>yet? I am willing to create an address list ordered by audio card 
>manufacturer/model to make the manufacturers realize there is a need for 
>linux support.
>
>Any comments?
>
>Olaf
>
>
>
>On Thursday 18 November 2004 14:01, derek holzer wrote:
>  
>
>>Of course, the Firewire subsystem for Linux works fine. But AFAIK there
>>are no drivers existing for any firewire audio cards. Bug the various
>>manufacurers to release more technical info and they might eventually
>>show up.
>>
>>d.
>>
>>Victor LaLoggia wrote:
>>    
>>
>>>Hello Frank;
>>>
>>>  Thank you for your response, and I do not mean to be contrary, but what
>>>about the work the folks at http://www.linux1394.org/ are doing?
>>>
>>>  I see that their subsystem has been included Linux kernel sources since
>>>version 2.3.40.  Does the subsystem not work?
>>>
>>>  Thanks,
>>>  vic
>>>
>>>-----Original Message-----
>>>From: Frank Barknecht <fbar@footils.org>
>>>Sent: Nov 15, 2004 12:14 PM
>>>To: linux-audio-user@music.columbia.edu
>>>Subject: Re: [linux-audio-user] Using Linux Laptop for Live Performance
>>>
>>>Hallo,
>>>
>>>Victor LaLoggia hat gesagt: // Victor LaLoggia wrote:
>>>      
>>>
>>>> I am just beginning my research into the available software and
>>>> hardware, and would greatly appreciate any information. Especially
>>>> on hardware - what would be the best usb/ firewire interface for
>>>> live performance?
>>>>        
>>>>
>>>No Firewire audio yet on Linux. The best in your case is PCMCIA, which
>>>has the lowest latency. VX-Pocket or RME cards are good choices. Also
>>>try, if your internal soundcard is enough.
>>>
>>>Ciao
>>>      
>>>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
