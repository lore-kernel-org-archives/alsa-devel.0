From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: Asus P5QL-EM motherboard (ALC1200 codec) -
	no	sound through S/PDIF
Date: Fri, 14 Nov 2008 12:58:44 +0800
Message-ID: <1226638730.458905.27492@de>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de>
	<9b7acddf9b27fdc3fea4444c2db912cf@localhost>
	<dfbb90e1b88698b6b74f8d59fa20600c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C512C24365
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 05:58:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <dfbb90e1b88698b6b74f8d59fa20600c@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrei Tanas <andrei@tanas.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 09:22:10AM -0500, Andrei Tanas wrote:
> > I cannot find any 'HDMI' words in your report below.
> > Can you provide some more info about it? Such as the full output of
> > 'aplay -l' and 'cat /proc/asound/card0/codec\#3'.
> 
> Here's "aplay -L" with autodetection

Thank you. What's the output of 'aplay -l' ?

> And here's "cat /proc/asound/card0/codec#0"

This is the regular codec.
Are there /proc/asound/card0/codec#{1,2,3}?

The HDMI codec would look like this one:

% cat /proc/asound/card0/codec\#3                                                                                                    
Codec: Generic 8086 INTEL G45 DEVELK                                                                                                 
Address: 3                                                                                                                           
Vendor Id: 0x80862803                                                                                                                
Subsystem Id: 0x80860101                                                                                                             
Revision Id: 0x100000                                                                                                                
No Modem Function Group found                                                                                                        
Default PCM:                                                                                                                         
    rates [0x0]:                                                                                                                     
    bits [0x0]:                                                                                                                      
    formats [0x0]:                                                                                                                   
Default Amp-In caps: N/A                                                                                                             
Default Amp-Out caps: N/A                                                                                                            
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0                                                                                          
Node 0x02 [Audio Output] wcaps 0x6211: 8-Channels Digital                                                                            
  Converter: stream=0, channel=0                                                                                                     
  Digital: Enabled                                                                                                                   
  Digital category: 0x0                                                                                                              
  PCM:                                                                                                                               
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000                                                                       
    bits [0x1e]: 16 20 24 32                                                                                                         
    formats [0x5]: PCM AC3                                                                                                           
Node 0x03 [Pin Complex] wcaps 0x40739d: 8-Channels Digital Amp-Out CP                                                                
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1                                                                         
  Amp-Out vals:  [0x00 0x80]                                                                                                         
  Pincap 0x00000094: OUT Detect HDMI                                                                                                 
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI                                                                             
    Conn = Digital, Color = Unknown                                                                                                  
    DefAssociation = 0x1, Sequence = 0x0                                                                                             
  Pin-ctls: 0x00:                                                                                                                    
  Unsolicited: tag=08, enabled=1                                                                                                     
  Connection: 1                                                                                                                      
     0x02                                                                                                                            

Thanks,
Fengguang
