From: Pap Peti <roachkiller44@gmail.com>
Subject: Re: M-audio Audiophile Firewire
Date: Tue, 1 Nov 2016 16:38:37 +0100
Message-ID: <d8d82842-1a83-e01d-db8d-752778991976@gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
 <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
 <20161023224350.GB12315@marvin.atrad.com.au>
 <5951c05f-3fe4-a2fc-aab2-407fddf8a817@gmail.com>
 <6f6374d3-f616-0d9d-31ac-2d463573f889@sakamocchi.jp>
 <80a6876e-6ced-7daa-7268-1277850c8270@gmail.com>
 <f677dfd1-c67d-7669-f4d4-d0dd5d8ff99e@sakamocchi.jp>
 <7e765437-91b7-9ea3-c9d8-e97d8fb4f100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E7F266E4F
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 16:38:40 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id t79so114370568wmt.0
 for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2016 08:38:40 -0700 (PDT)
In-Reply-To: <7e765437-91b7-9ea3-c9d8-e97d8fb4f100@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Jonathan Woithe <jwoithe@just42.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

UPDATE:

jackd2         2:1.9.11~201 amd64

and my audio.conf:

# Provided by the jackd package.
#
# Changes to this file will be preserved.
#

@audio   -  rtprio     99
@audio   -  memlock    unlimited
@audio   -  nice      -10

(I added my username to the audio group)

Now the Qjack can start with firewire driver and realtime

An example:


1. Start Qjack (Driver: firewire, Sampe Rate: 48kHz, Realtime, Server 
Prefix: jackd)
2. Start Tracktion T5

Now the Messages / Status "output" is:

16:34:42.619 Statistics reset.

16:34:42.636 ALSA connection change.

16:34:42.645 D-BUS: Service is available (org.jackaudio.service aka 
jackdbus).

16:34:45.949 D-BUS: JACK server is starting...

Tue Nov 1 16:34:42 2016: Starting jack server...

Tue Nov 1 16:34:42 2016: JACK server starting in realtime mode with 
priority 10

Tue Nov 1 16:34:42 2016: self-connect-mode is "Don't restrict self 
connect requests"

Cannot connect to server socket err = No such file or directory

Cannot connect to server request channel

jack server is not running or cannot be started

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

Cannot connect to server socket err = No such file or directory

Cannot connect to server request channel

jack server is not running or cannot be started

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
skipping unlock

16:34:45.994 ALSA connection graph change.

16:34:46.036 D-BUS: JACK server was started (org.jackaudio.service aka 
jackdbus).

Tue Nov 1 16:34:45 2016: Saving settings to 
"/home/delest/.config/jack/conf.xml" ...

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_SPDIFIn L_in'

Tue Nov 1 16:34:45 2016: New client 'firewire_pcm' with PID 0

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_SPDIFIn R_in'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineIn L_in'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineIn R_in'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_MidiIn 1_in'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_SPDIFOut L_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_SPDIFOut R_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineOut1 L_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineOut1 R_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineOut2 L_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_LineOut2 R_out'

Tue Nov 1 16:34:45 2016: graph reorder: new port 
'firewire_pcm:000d6c0300d95b38_MidiOut 1_out'

16:34:48.188 JACK connection change.

16:34:48.191 Server configuration saved to "/home/delest/.jackdrc".

16:34:48.192 Statistics reset.

16:34:48.201 Client activated.

16:34:48.202 Patchbay deactivated.

16:34:48.207 JACK connection graph change.

Tue Nov 1 16:34:48 2016: New client 'qjackctl' with PID 5079

16:35:09.709 ALSA connection graph change.

16:35:09.721 ALSA connection change.

16:35:09.734 JACK connection graph change.

Tue Nov 1 16:35:09 2016: New client 'JuceJackDummy' with PID 5104

Tue Nov 1 16:35:09 2016: Client 'JuceJackDummy' with PID 5104 is out

16:35:11.627 JACK connection graph change.

Tue Nov 1 16:35:11 2016: New client 'JuceJackDummy' with PID 5104

16:35:11.687 ALSA connection graph change.

16:35:11.729 ALSA connection change.

16:35:11.992 ALSA connection graph change.

16:35:12.133 ALSA connection change.

Tue Nov 1 16:35:11 2016: Client 'JuceJackDummy' with PID 5104 is out

16:35:16.858 JACK connection graph change.

16:35:16.947 JACK connection change.

16:35:16.960 JACK connection graph change.

16:35:16.975 ALSA connection graph change.

16:35:17.157 ALSA connection change.

16:35:17.288 ALSA connection graph change.

16:35:17.359 ALSA connection change.

16:35:17.393 ALSA connection graph change.

16:35:17.562 ALSA connection change.

Tue Nov 1 16:35:16 2016: New client 'JUCEJack' with PID 5104

Tue Nov 1 16:35:16 2016: port 'JUCEJack:in_1' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:in_2' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:in_3' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:in_4' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:in_5' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_1' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_2' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_3' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_4' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_5' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_6' created

Tue Nov 1 16:35:16 2016: port 'JUCEJack:out_7' created

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_1' to 
'firewire_pcm:000d6c0300d95b38_SPDIFOut L_out'

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_2' to 
'firewire_pcm:000d6c0300d95b38_SPDIFOut R_out'

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_3' to 
'firewire_pcm:000d6c0300d95b38_LineOut1 L_out'

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_4' to 
'firewire_pcm:000d6c0300d95b38_LineOut1 R_out'

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_5' to 
'firewire_pcm:000d6c0300d95b38_LineOut2 L_out'

Tue Nov 1 16:35:16 2016: Connecting 'JUCEJack:out_6' to 
'firewire_pcm:000d6c0300d95b38_LineOut2 R_out'

Tue Nov 1 16:35:16 2016: ERROR: JackGraphManager::Connect different port 
types port_src = 24 port_dst = 12

16:35:19.777 JACK connection graph change.

16:35:19.968 JACK connection graph change.

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_1' from 
'firewire_pcm:000d6c0300d95b38_SPDIFOut L_out'

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_2' from 
'firewire_pcm:000d6c0300d95b38_SPDIFOut R_out'

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_3' from 
'firewire_pcm:000d6c0300d95b38_LineOut1 L_out'

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_4' from 
'firewire_pcm:000d6c0300d95b38_LineOut1 R_out'

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_5' from 
'firewire_pcm:000d6c0300d95b38_LineOut2 L_out'

Tue Nov 1 16:35:19 2016: Disconnecting 'JUCEJack:out_6' from 
'firewire_pcm:000d6c0300d95b38_LineOut2 R_out'

Tue Nov 1 16:35:19 2016: Client 'JUCEJack' with PID 5104 is out

Tue Nov 1 16:35:19 2016: New client 'JUCEJack' with PID 5104

Tue Nov 1 16:35:19 2016: port 'JUCEJack:in_1' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:in_2' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:in_3' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:in_4' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:in_5' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_1' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_2' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_3' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_4' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_5' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_6' created

Tue Nov 1 16:35:19 2016: port 'JUCEJack:out_7' created

Tue Nov 1 16:35:19 2016: Connecting 
'firewire_pcm:000d6c0300d95b38_SPDIFIn L_in' to 'JUCEJack:in_1'

Tue Nov 1 16:35:19 2016: Connecting 
'firewire_pcm:000d6c0300d95b38_SPDIFIn R_in' to 'JUCEJack:in_2'

Tue Nov 1 16:35:19 2016: Connecting 
'firewire_pcm:000d6c0300d95b38_LineIn L_in' to 'JUCEJack:in_3'

Tue Nov 1 16:35:19 2016: Connecting 
'firewire_pcm:000d6c0300d95b38_LineIn R_in' to 'JUCEJack:in_4'

Tue Nov 1 16:35:19 2016: ERROR: JackGraphManager::Connect different port 
types port_src = 5 port_dst = 17

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_1' to 
'firewire_pcm:000d6c0300d95b38_SPDIFOut L_out'

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_2' to 
'firewire_pcm:000d6c0300d95b38_SPDIFOut R_out'

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_3' to 
'firewire_pcm:000d6c0300d95b38_LineOut1 L_out'

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_4' to 
'firewire_pcm:000d6c0300d95b38_LineOut1 R_out'

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_5' to 
'firewire_pcm:000d6c0300d95b38_LineOut2 L_out'

Tue Nov 1 16:35:19 2016: Connecting 'JUCEJack:out_6' to 
'firewire_pcm:000d6c0300d95b38_LineOut2 R_out'

Tue Nov 1 16:35:19 2016: ERROR: JackGraphManager::Connect different port 
types port_src = 24 port_dst = 12


Maybe the solution: somehow routing ALSA via JACK, and after I can use 
the DAW with firewire driver, and the others with ALSA in each time?

Regards

Peti


On 11/01/2016 02:54 PM, Pap Peti wrote:
>
> Okay,
>
> Now I went back to Linux Mint Sarah (18) with Cinnamon window manager 
> (x64)
>
> MY HW:
>
> H/W path         Device      Class          Description 
> ======================================================= 
>                              system         Computer 
> /0                           bus            Motherboard 
> /0/0                         memory         3834MiB System memory 
> /0/1                         processor      Intel(R) Core(TM) i5-2520M 
> CPU @ 2.5 /0/100                       bridge         2nd Generation 
> Core Processor Family /0/100/2                     display        2nd 
> Generation Core Processor Family /0/100/16                    
> communication  6 Series/C200 Series Chipset Family 
> /0/100/16.3                  communication  6 Series/C200 Series 
> Chipset Family /0/100/19        enp0s25     network        82579LM 
> Gigabit Network Connection /0/100/1a                    bus            
> 6 Series/C200 Series Chipset Family /0/100/1b                    
> multimedia     6 Series/C200 Series Chipset Family 
> /0/100/1c                    bridge         6 Series/C200 Series 
> Chipset Family /0/100/1c.1                  bridge         6 
> Series/C200 Series Chipset Family /0/100/1c.1/0    wlp3s0      
> network        Centrino Advanced-N 6205 [Taylor Pea 
> /0/100/1c.3                  bridge         6 Series/C200 Series 
> Chipset Family /0/100/1c.3/0                bridge         
> XIO2000(A)/XIO2200A PCI Express-to-P /0/100/1c.3/0/0              
> bus            XIO2200A IEEE-1394a-2000 Controller 
> /0/100/1c.4                  bridge         6 Series/C200 Series 
> Chipset Family /0/100/1c.4/0                generic        MMC/SD Host 
> Controller /0/100/1d                    bus            6 Series/C200 
> Series Chipset Family /0/100/1f                    bridge         QM67 
> Express Chipset Family LPC Cont /0/100/1f.2                  
> storage        6 Series/C200 Series Chipset Family 
> /0/100/1f.3                  bus            6 Series/C200 Series 
> Chipset Family /0/2             scsi1       storage /0/2/0.0.0       
> /dev/cdrom  disk           DVDRAM GT50N
>
> and:
>
> Linux 4.4.0-45-generic x86_64
>
> ffado-dbus-ser 2:2.2.1+svn2
>
> ffado-mixer
>
> DAW: Tracktion 5 (x64) /if I use with ALSA driver, I cant play sounds 
> paralell with another applications e.g.: browser - youtube, or any player)
>
> And I cant connect JACK firewire backend with realtime priority.
>
> "
>
> 14:51:17.044 D-BUS: JACK server could not be started. Sorry
>
> Cannot connect to server socket err = No such file or directory
>
> Cannot connect to server request channel
>
> jack server is not running or cannot be started
>
> JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
> skipping unlock
>
> JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
> skipping unlock
>
> Tue Nov 1 14:51:16 2016: Starting jack server...
>
> Tue Nov 1 14:51:16 2016: JACK server starting in realtime mode with 
> priority 10
>
> Tue Nov 1 14:51:16 2016: self-connect-mode is "Don't restrict self 
> connect requests"
>
> Tue Nov 1 14:51:16 2016: ERROR: Cannot lock down 107341338 byte memory 
> area (Cannot allocate memory)
>
> Tue Nov 1 14:51:17 2016: ERROR: firewire ERR: FFADO: Error creating 
> virtual device
>
> Tue Nov 1 14:51:17 2016: ERROR: Cannot attach audio driver
>
> Tue Nov 1 14:51:17 2016: ERROR: JackServer::Open failed with -1
>
> Tue Nov 1 14:51:17 2016: ERROR: Failed to open server
>
> Tue Nov 1 14:51:19 2016: Saving settings to 
> "/home/delest/.config/jack/conf.xml" ...
>
> 14:51:25.334 Could not connect to JACK server as client. - Overall 
> operation failed. - Unable to connect to server. Please check the 
> messages window for more info.
>
> Cannot connect to server socket err = No such file or directory
>
> Cannot connect to server request channel
>
> jack server is not running or cannot be started
>
> JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
> skipping unlock
>
> JackShmReadWritePtr::~JackShmReadWritePtr - Init not done for -1, 
> skipping unlock*"*
>
> So, I think maybe the JACK make me less CPU usage in the DAW , and/or 
> I can play sound from another source too, in each time. But if I can 
> solve theese problems with ALSA, thats also okay for me :) Regards Peti
> On 10/28/2016 03:30 AM, Takashi Sakamoto wrote:
>> On Oct 27 2016 23:10, Pap Peti wrote:
>>> My controller: *-firewire                    description: FireWire 
>>> (IEEE 1394)                    product: XIO2200A IEEE-1394a-2000 
>>> Controller (PHY/Link)                    vendor: Texas Instruments 
>>>                    physical id: 0                    bus info: 
>>> pci@0000:06:00.0                    version: 01                    
>>> width: 32 bits                    clock: 66MHz                    
>>> capabilities: ohci bus_master cap_list                    
>>> configuration: driver=firewire_ohci latency=32 maxlatency=4 mingnt=2 
>>>                    resources: irq:19 memory:f1c04000-f1c047ff 
>>> memory:f1c00000-f1c03fff 
>> Not enough to re-generate your issue in my hand. Please inform below 
>> information to me:  - applications in your test  - operations in your 
>> test  - the environment of your test; distribution, kernel version, 
>> and so on Regards Takashi Sakamoto 
