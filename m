From: Guido Trentalancia <guido@trentalancia.com>
Subject: Re: Hercules P32 DJ: severe sound distortion during
 MIDI transfers
Date: Fri, 22 Mar 2019 17:06:22 +0100 (CET)
Message-ID: <351256499.62701.1553270782127@pim.register.it>
References: <1553114844.12865.6.camel@trentalancia.com>
 <1335514032.30698.1553207267014@pim.register.it>
 <s5hr2azp9t3.wl-tiwai@suse.de>
 <D5E663E4-9118-4CA3-8ADE-5F97202D9404@trentalancia.com>
 <s5himwbb5h4.wl-tiwai@suse.de>
 <53EC51B6-618E-47B4-95E8-B24BECEEBC98@trentalancia.com>
 <s5hef6zb4k6.wl-tiwai@suse.de> <1553262288.26146.4.camel@trentalancia.com>
 <s5htvfv9d9z.wl-tiwai@suse.de>
 <AF692377-8E9F-4483-81EC-712B31526DE4@trentalancia.com>
 <s5hsgvf9cs0.wl-tiwai@suse.de>
 <BF82F065-6E1F-4017-AB3E-70555EDBA2BB@trentalancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmailsmtp.register.it (webmailsmtp30.register.it
 [81.88.63.155])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84FD7F8076F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 17:06:23 +0100 (CET)
In-Reply-To: <BF82F065-6E1F-4017-AB3E-70555EDBA2BB@trentalancia.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

> On the 22nd of March 2019 at 16.05 Guido Trentalancia <guido@trentalancia.com> wrote:
> 
> 
> I suppose the Fedora 29 kernels are included in the range I tested as broken, i.e. 4.12 -- 5.0.

I have checked and can now confirm the above, as Fedora 29 kernel is version 4.18.16, therefore included in the same range I tested as broken.

> So, there is something triggering it on my system and not the other, maybe the USB system as pointed out by Clemens.
> 
> I'll make some research on the two USB systems...
> 
> I would also like to try USB Audio driver from kernel 3.0.1.
> 
> What else do you suggest?
> 
> Guido
> 
> Il 22 marzo 2019 15:58:23 CET, Takashi Iwai <tiwai@suse.de> ha scritto:
> >On Fri, 22 Mar 2019 15:54:03 +0100,
> >Guido Trentalancia wrote:
> >> 
> >> As already explained, I have tested the following kernels:
> >> 
> >> - kernel 5.0.2 -----> BROKEN
> >> - kernel 4.17.10 --> BROKEN
> >> - kernel 4.12.9 ---> BROKEN
> >> 
> >> So, it's been around for very long.
> >> 
> >> What do you suggest doing?
> >
> >But which kernel is used for another user who can use without the
> >problem?  I suppose they use the recent kernel with Fedora?
> >
> >> I have found reports on the web about similar problems (with other
> >audio
> >> interfaces) with kernels>3.0.0.
> >
> >Such a regression should have been reported earlier, otherwise it
> >becomes more and more difficult to catch up...
> >
> >
> >thanks,
> >
> >Takashi
> >
> >
> >> Regards,
> >> 
> >> Guido
> >> 
> >> Il 22 marzo 2019 15:47:36 CET, Takashi Iwai <tiwai@suse.de> ha
> >scritto:
> >> 
> >>     On Fri, 22 Mar 2019 14:44:48 +0100,
> >>     Guido Trentalancia wrote:
> >>          
> >>          Hello Takashi.
> >>          
> >>          I have carried out the test that you proposed...
> >>          
> >>          My reply follows your quoted text.
> >>          
> >>          On Fri, 22/03/2019 at 11.12 +0100, Takashi Iwai wrote:
> >>              On Fri, 22 Mar 2019 11:04:01 +0100,
> >>              Guido Trentalancia wrote:
> >>                  
> >>                  Hello Takashi,
> >>                  
> >>                  I am using the latest version of everything,
> >including kernel and
> >>                  ALSA
> >>                  userspace library / tools.
> >>                  
> >>                  The other user has exactly the same hardware and has
> >tested same
> >>                  firmware
> >>                  (both 1.36 and latest
> >>                 1.46), but with Fedora 29 and it is working.
> >>                  
> >>                  Perhaps Fedora 29 has a different version of the
> >ALSA library, I
> >>                  will find
> >>                  out, try to downgrade, test again and report back.
> >>              
> >>              Yes, that'd be really helpful.  If aligning the software
> >doesn't fix
> >>              the issue, it's either because of the hardware or the
> >difference of
> >>              usage patterns.
> >>          
> >>          I have tested exactly the same ALSA userspace library and
> >plugins
> >>          distributed by Fedora 29 and it does NOT work !
> >>          
> >>          As already explained, the usage pattern is exactly the same
> >between me
> >>          and the user which is not experiencing this severe problem.
> >>          
> >>          Also, the hardware is the same: Hercules P32 DJ (with
> >exactly the same
> >>          firmware version 1.46 which is the latest).
> >>          
> >>          So, the conclusion is that it must be a kernel bug ! I was
> >expecting
> >>          this, as already pointed out in previous messages.
> >>     
> >>     Did you test the
> >>     very same kernel, too?  Without that confirmation, no
> >>     one can conclude that at all...
> >>     
> >>     If the kernel makes difference, you can try identify which kernel
> >>     version starts showing the problem, and at best, do git
> >bisection.
> >> 
> >>     thanks,
> >>     
> >>     Takashi
> >> 
> >>          Can you please help me fix this bug since you wrote the
> >driver and/or
> >>          are maintaining it ?
> >>          
> >>          Thanks,
> >>          
> >>          Guido
> >>          
> >>              thanks,
> >>              
> >>              Takashi
> >> 
> >>                  Guido
> >>                  
> >>                  Il 22 marzo 2019 10:53:11 CET, Takashi Iwai
> ><tiwai@suse.de> ha
> >>                  scritto:
> >>                  
> >>                      On Fri, 22 Mar 2019
> >>                 10:17:17 +0100,
> >>                      Guido Trentalancia wrote:
> >>                           
> >>                           It cannot be a firmware bug, as you say,
> >because:
> >>                           
> >>                           - it does NOT happen on Windows!
> >>                      
> >>                      It doesn't mean that the device behaves
> >correctly as
> >>                  advertised.
> >>                      
> >>                           - it does NOT even always happen on Linux:
> >other users
> >>                  (with different kernel
> >>                           / ALSA library) are not experiencing the
> >same problem;
> >>                           - it happens with several firmware
> >versions, including the
> >>                  latest one (1.36
> >>                           and 1.46).
> >>                           
> >>                           So it is either a bug in ALSA kernel
> >driver, USB sound
> >>                  driver (more likely) or
> >>                           ALSA library.
> >>                           
> >>                           Now, you are in charge of the USB sound
> >driver, can you
> >>                  please double check??
> >>                      
> >>                      If it doesn't happen for other users with the
> >very same device,
> >>                  you'd
> >>                      need to identify what's the difference
> >>                 between your case and
> >>                  others.
> >>                      For example, if the difference of alsa-lib
> >matters, you can try
> >>                  the
> >>                      very same condition.
> >>                      
> >>                      This kind of bug can't be easily debugged
> >without the actual
> >>                      hardware, unfortunately.
> >>                  
> >>                      Takashi
> >>                  
> >>                           Regards,
> >>                           
> >>                           Guido
> >>                           
> >>                           Il 22 marzo 2019 09:55:52 CET, Takashi Iwai
> ><tiwai@suse.de
> >>                      ha scritto:
> >>                           
> >>                               On Thu, 21 Mar 2019 23:27:46 +0100,
> >>                               Guido Trentalancia wrote:
> >>                                    
> >>                                    I wonder if this might be due to a
> >bug in the
> >>                  "USB Audio Driver for Alsa"?
> >>                                    
> >>                                   
> >https://git.kernel.org/pub/scm/linux/kernel/git/t
> >>                  orvalds/linux.git/tree/sound/usb
> >>                                    
> >>                                   
> >https://git.kernel.org/pub/scm/linux/kernel/git/t
> >>                  iwai/sound.git/tree/sound/usb
> >>                               
> >>                               More likely a buggy firmware of your
> >USB audio device
> >>                  :)
> >>                               
> >>                                From the driver implementation POV,
> >both audio and
> >>                  MIDI devices are
> >>                               handled by individual endpoints, hence
> >they shouldn't
> >>                  conflict.
> >>                               
> >>                               Or another possibility would be some
> >USB host side
> >>                  issue like the
> >>                               bandwidth.  But
> >>                               it's a MIDI stream that is very low
> >data rate, so this
> >>                               sounds also unlikely...
> >>                           
> >>                               thanks,
> >> 
> >>                  Takashi
> >>                           
> >>                                    Guido
> >>                                    
> >>                                        On the 20th of March 2019 at
> >21.47 Guido
> >>                          Trentalancia
> >>                                        <guido@trentalancia.com wrote:
> >>                                       
> >>                                        Hello.
> >>                                       
> >>                                        I am hitting a very serious
> >bug (ALSA kernel
> >>                  driver or ALSA library)
> >>                                        when using the Hercules P32 DJ
> >audio
> >>                  interface.
> >>                                       
> >>                                        The sound is severely
> >distorted during MIDI
> >>                  transfers.
> >>                                       
> >>                                        To reproduce:
> >>                                       
> >>                                          + start playing something in
> >a first
> >>                  console:
> >>                                       
> >>                                        console1# AUDIODEV=hw:2,0 play
> >audio.wav
> >>                                       
> >>                                          + the audio plays fine
> >> 
> >>                                          + now start "amidi" in a
> >second console
> >>                  while the above track is still
> >>                                            playing
> >>                                           
> >>                                        console2#
> >>                                   amidi -p hw:2,0,0 -d
> >>                                       
> >>                                          + the sound is now severely
> >distorted
> >>                  (basically noise, with some
> >>                          hard-
> >>                                            to-distinguish features
> >resembling the
> >>                  original track) until "amidi"
> >>                                            is
> >>                                            interrupted !
> >> 
> >> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
