From: Xarteras <xarteras@nostalgicnetworxx.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 16 Oct 2008 12:56:20 +0000
Message-ID: <48F739F4.5070303@nostalgicnetworxx.org>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<loom.20081016T120322-319@post.gmane.org>
	<s5h8wso3ejg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nostalgicnetworxx.org (snowleopard.nostalgicnetworxx.org
	[87.106.211.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 33CF224134
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 14:58:35 +0200 (CEST)
In-Reply-To: <s5h8wso3ejg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 16 Oct 2008 12:03:41 +0000 (UTC),
> Jan Wolf wrote:
>> Takashi Iwai <tiwai <at> suse.de> writes:
>>
>>> Hi,
>>>
>>> $SUBJECT is now on my sound-unstable git tree:
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
>>> together with other experimental patches.
>>>
>>> If you're using 2.6.27-rc* git tree, pull the master branch of the
>>> tree above into yours, and run make oldconfig.  That is,
>>>     % cd /your/git-tree
>>>     % git pull git://...../sound-unstable-2.6.git master
>>>
>>> If you are not using 2.6.27-rc*, or not familiar with git, you can try
>>> alsa-driver-unstable snapshot tarball available at
>>>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
>>> Run configure, make and make install as usual ALSA-driver tarball.
>>>
>>> (I didn't check whether the tarball correctly includes the sbxfi
>>>  stuff.  It should have been generated automatically.  If not, wait
>>>  for a while.  If it still doesn't include sbxfi code, please report.
>>>  I'll fix it tomorrow morning.)
>>>
>>> The driver is built only for 2.6.26 or later.  If you have an older
>>> kernel, edit alsa-driver*/kconfig-vers and change the version of
>>> CONFIG_SND_SBXFI to 2.6.24 or whatever you want.  Then run
>>> ./gitcompile, instead of configure in this case to update the
>>> configure script.
>>>
>>> **NOTE**
>>> The driver is totally untested.  It's just compiled without errors,
>>> but not reviewed after a quick writing.  So, don't expect it ever runs
>>> at the first try.  A crash is highly possible.
>>>
>>> There are some build conditions found in sound/pci/sbxfi/sbxfi.c,
>>> starting with XXX_*.  You can change it if you want.  As default, it's
>>> for non-fullduplex but accept different rates.  Not sure whether this
>>> works at all.
>>>
>>> Any test- (and better debugging-) reports are appreciated.
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> I finally managed to play music over xmms with this driver.
>> I needed to modify something, because most music is 44100Hz and the driver did
>> not work with this rate.
>>
>> 61,62c61,62
>> < #undef XXX_48K_ONLY
>> < #define XXX_CONT_RATE
>> ---
>>> #define XXX_48K_ONLY
>>> #undef XXX_CONT_RATE
>> 529a530,532
>>>       case 44100:
>>>               ratec = 0x4c;
>>>               break;
>> It also needs to run in 48000Hz mode or else it will playback way to slow.
> 
> So, XXX_96K_ONLY doesn't work well?
> 

Interesting, XXX_96K_ONLY also works, just XXX_CONT_RATE doesn't.

>> I think this flag in ratec switches to 96KHz mode in the X-Fi, in windows this
>> mode is only available in Audio creation mode, so it must be handled in a
>> special way somehow.
> 
> Thanks, good to know ;)

It's just speculation on my part, but as I just played around with the 
flag it didn't seem to do anything, at least with 44100Hz input.
Otherwise the code I patched in just makes sure ratec is set at all when 
playing back at 44100Hz, otherwise playback in xmms just hangs.

> 
> And, which X-Fi model do you have?
> Please show the lspci -nv output, too.
> 

I've got the X-Fi Elite Pro.
That's The one with the external In/Out box.

Speaking of which, the headphone jack on it does not output a signal 
yet, the signal only goes to line out.

There's some relais on the card that seem to switch these, they click 
multiple times with the windows driver and not all all with yours, I 
think that's the reason :)

And lspci outputs:

05:08.0 Multimedia audio controller [0401]: Creative Labs SB X-Fi 
[1102:0005]
         Subsystem: Creative Labs Device [1102:0022]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 32 (1000ns min, 1250ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at b400 [size=32]
         Region 1: Memory at c5000000 (64-bit, non-prefetchable) [size=2M]
         Region 3: Memory at c0000000 (64-bit, non-prefetchable) [size=64M]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Kernel driver in use: SB-XFi
