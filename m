From: Jesse Chappell <jesse@essej.net>
Subject: Re: Hammerfall DSP System Problems
Date: Thu, 12 Jun 2003 01:13:50 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0306120009030.1274@pi32.pi>
References: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: D R Holsbeck <drh@niptron.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2003, Paul Davis wrote:
> >Like you I think the HDSP driver understands my firmware revision. I have
> >also downgraded and upgraded my firmware without success.
> >
> >This whole Alsa/HDSP thing is amazingly weird...
> 
> at the moment, i regret that we made the move to user-space loading of
> the "firmware" when we did. i think now that it was a mistake to do it
> at that time. it has caused a fundamental change in the way the driver
> sets up, but it came at a time when we weren't confident that setup
> was working for various cases. 

I have now joined the ranks of troubleshooting HDSP owner.  I 
have a cardbus HDSP (rev 0b) with a Multiface.  IBM Thinkpad A31.
Kernel 2.4.20 LL+preemp with cardbus support in kernel.
Multiface connected and powered via AC adaptor.
I've been trying alsa-driver-0.9.4, and I detail my setup and 
problems below: 

snd-hammerfall-mem  loads normally

snd-hdsp            first stage loads fine (dmesg output snip):
  PCI: Setting latency timer of device 06:00.0 to 64
  ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4110: card initialization pending : waiting for firmware

------------------
# hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : RME Hammerfall DSP at 0x31000000, irq 9
Upload firmware for card hw:0
Hwdep ioctl error on card hw:0 : Input/output error.
------------------------

dmesg snippet while hdsploader ran with extra debugging added by 
me:
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed after 30 iterations
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3804: initializing firmware upload
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
....
 the code in snd_hdsp_create_alsa_devices() is executed here, 
successfully up until snd_hdsp_set_defaults() is called.  In that 
function, the loop where the gains for the matrix mixer are 
silenced executes hdsp_write_gain 128 times, and on the next 
iteration the following message is thrown:
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644:  
    wait for FIFO status <= 127 failed after 5000 iterations
causing the function to return -EIO hence the ioctl error passed 
back to hdsploader.

Any attempts to run hdsploader again result in more errors 
involving FIFO timeouts, getting worse until the following 
message is thrown every time:
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3804: initializing firmware upload
 ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:508: Hammerfall-DSP: no  Digiface or Multiface connected!

Unloading the modules, and ejecting and reinserting the card 
doesn't help matters, nor does a warm reboot.  I do not have 
windows on the laptop (yet) so I have not attempted to get it 
working there (to load the multiface firmware, then warm boot) or 
to downgrade the hdsp firmware to 0a.  Ideally, I can help to 
debug the primary problems with recent HDSP and recent ALSA.... I 
don't *need* to use the hardware right away (but I would like 
to :) 

If there is any offlist discussion about the HDSP debugging, 
please include me in those messages.

D R Holsbeck, what version of ALSA, and what HDSP firmware 
are you successfully using on your A31?  I know you have the 
Digiface though... I have the multiface.

Paul, any info you have on the initialization steps or iobox 
identification would be useful.  The code in 
hdsp_get_iobox_version() seems a bit odd to me.  I always get 
the:  ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: 
     wait for FIFO status <= 0 failed after 30 iterations
 in the primary conditional where it picks multiface or digiface.  
I suppose that is intentional, but I wonder if that technique 
masks some other problem, even though I do have a multiface.  How 
does that sequence work?

I want to get this crap working so I can test ardour better 
:)

jlc

   


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
