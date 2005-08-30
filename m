From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000509]: Conexant Moden "not ready"
Date: Tue, 30 Aug 2005 12:26:34 +0200
Message-ID: <c706c769a644ee03ee57ab3eaf94710a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72B301C3
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:26:34 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=509> 
======================================================================
Reported By:                gbilotta
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   509
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux Testing
Kernel Version:             2.6.7
======================================================================
Date Submitted:             09-20-2004 19:20 CEST
Last Modified:              08-30-2005 12:26 CEST
======================================================================
Summary:                    Conexant Moden "not ready"
Description: 
modprobing for snd_intel8x0m gives the following error:

MC'97 1 converters and GPIO not ready (0xff00)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000857 intel8x0m does not work on asus a3n laptop
related to          0000890 no dialtone with modem &amp; strange lo...
======================================================================

----------------------------------------------------------------------
 sashak - 09-20-04 22:23 
----------------------------------------------------------------------
Hello Giuseppe "Oblomov",

I'm not sure that this is the reason, but according to AC97 spec (rev.2.3
at least) modem reset should be performed by writing something to register
AC97_EXTENDED_MID (0x3c) and AC97_RESET (0x0) should not be touched. So
probably this hw just works in right way.

Just for clarification could you try this patch ( cd linux-2.6.7 ; patch
-p0 ):

--- sound/pci/ac97/ac97_codec.c.orig    2004-09-20 23:00:24.903845416
+0300
+++ sound/pci/ac97/ac97_codec.c 2004-09-20 23:07:23.341233264 +0300
@@ -1784,7 +1784,16 @@
                goto __access_ok;
        }
 
+#define JUST_FORCHECK 1
+#ifdef JUST_FORCHECK
+       /* reset to defaults */
+       if(ac97->scaps & AC97_SCAP_SKIP_AUDIO)
+               snd_ac97_write(ac97, AC97_EXTENDED_MID, 0);     /* modem
*/
+       else
+               snd_ac97_write(ac97, AC97_RESET, 0);    /* audio */
+#else
        snd_ac97_write(ac97, AC97_RESET, 0);    /* reset to defaults */
+#endif
        if (bus->wait)
                bus->wait(ac97);
        else {

----------------------------------------------------------------------
 gbilotta - 09-22-04 00:24 
----------------------------------------------------------------------
Yes, your diagnosis seems to be correct. With the separate init code for
the modem I don't get the "not ready" error. Of course I'm still not 100%
sure whether I can use the modem or not ... is there some way I can check?

----------------------------------------------------------------------
 sashak - 09-22-04 02:16 
----------------------------------------------------------------------
Good for start. Thanks. :)
You may try to capture sound from phone line (with arecord) - when line is
connected you should be able to record dial tone in grabbed file.
If it will ok. Try to dial with slmodem-2.9.9-alsa
(http://linmodems.technion.ac.il/packages/smartlink/).
If not please send again '/proc/asound/Modem/codec97#0/mc97#1-1+regs'.

----------------------------------------------------------------------
 gbilotta - 09-22-04 13:52 
----------------------------------------------------------------------
I only get silence (except for an initial and final click) when trying to
record, and still a couple of errors. I'm uploading a test.out file
showing the (console) outputs from the recording and from cat'ing the
/proc regs file.

----------------------------------------------------------------------
 sashak - 09-22-04 19:53 
----------------------------------------------------------------------
Could you try patch below with 8000 rate arecord:

arecord -D hw:1 -v -d 5 -f S16_LE -r 8000 -t wav result.wav

And please grab '/proc/asound/Modem/codec97#0/mc97#1-1+regs' during
arecord or aplay.

Thanks.

--- sound/pci/intel8x0m.c.orig  2004-09-22 20:34:21.929490088 +0200
+++ sound/pci/intel8x0m.c       2004-09-22 20:48:53.969919792 +0200
@@ -643,12 +643,10 @@
        /* TODO: move it to ac97 controls */
        switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
-               snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
-                                    AC97_GPIO_LINE1_OH,
AC97_GPIO_LINE1_OH);
+               snd_ac97_write(ichdev->ac97, AC97_GPIO_STATUS, 0x31)
                break;
        case SNDRV_PCM_TRIGGER_STOP:
-               snd_ac97_update_bits(ichdev->ac97, AC97_GPIO_STATUS,
-                                    AC97_GPIO_LINE1_OH,
~AC97_GPIO_LINE1_OH);
+               snd_ac97_write(ichdev->ac97, AC97_GPIO_STATUS, 0x20)
                break;
        default:
                return -EINVAL;
@@ -684,9 +682,9 @@
        .rate_max =             16000,
        .channels_min =         1,
        .channels_max =         1,
-       .buffer_bytes_max =     32 * 1024,
+       .buffer_bytes_max =     64 * 1024,
        .period_bytes_min =     32,
-       .period_bytes_max =     32 * 1024,
+       .period_bytes_max =     64 * 1024,
        .periods_min =          1,
        .periods_max =          1024,
        .fifo_size =            0,
@@ -818,8 +816,8 @@
                .suffix = "Modem",
                .playback_ops = &snd_intel8x0m_playback_ops,
                .capture_ops = &snd_intel8x0m_capture_ops,
-               .prealloc_size = 4 * 1024,
-               .prealloc_max_size = 16 * 1024,
+               .prealloc_size = 32 * 1024,
+               .prealloc_max_size = 64 * 1024,
        },
 };

----------------------------------------------------------------------
 gbilotta - 09-23-04 14:33 
----------------------------------------------------------------------
Bad news. I had to rebuild the kernel because of other issues I was having,
and now even with your initial patch I get the "GPIO not ready" error.

The new patch (which is lacking a coule of ;, BTW :)) (yes, I tried using
it even though I got the error message) has the effect of having arecord
fail complaining about the number of channels not being available, even
when -c 1 was specified on the comand line.

I'm attaching cat_regs and cat_regs2, which is the cat of /proc/...+regs
during arecord execution, before and after the application of the patch.

----------------------------------------------------------------------
 sashak - 09-24-04 03:07 
----------------------------------------------------------------------
At the modem I found laptop with Si3036/8 codec where I am able to
reproduce both messages, but modem works - I am afraid that main problem
is unsupported codec.
Do you know is there some available paper about (it is named HSD11246 or
SmartMC II)?

----------------------------------------------------------------------
 gbilotta - 09-24-04 13:30 
----------------------------------------------------------------------
Hm.

Under Windows, I see:

"Crystal WDM Audio Codec", with vendor ID 8086, device ID 2485, subvendor
ID 1013, subdevice ID 5959, rev 02

"Intel(r) 82801AA AC'97 Audio Controller", vendor 8086, device 2415,
subvendor 1028, subdevice 0093, rev 02

and finally the modem itself

"Actiontec MD56ORD V92 MDC Modem", vendor 8086, device 2486, subvendor
14F1, subdevice 5421, rev 02

By contrast, lspci -vv (as posted) only shows two of them. Could this be
the reason for the problem?

----------------------------------------------------------------------
 gbilotta - 09-24-04 13:32 
----------------------------------------------------------------------
PS one more thing: Conexant softmodems are listed here:

http://www.conexant.com/products/entry.jsp?id=21

I'm not sure about which one I have though. Do you have any suggestions on
how I could find out?

----------------------------------------------------------------------
 sashak - 09-24-04 22:45 
----------------------------------------------------------------------
Data you see in win is from "customized" driver, so it should not be
problem.

Conexant link is useless - there is no related technical info - we need
the spec. Most likely it is not abaliable in public. I'll think how to
continue with it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-20-04 19:20 gbilotta       New Issue                                    
09-20-04 19:20 gbilotta       File Added: asound.tar.bz2                    
09-20-04 19:20 gbilotta       Distribution              => Debian GNU/Linux
Testing
09-20-04 19:20 gbilotta       Kernel Version            => 2.6.7           
09-20-04 19:21 gbilotta       File Added: lspci.out                        
09-20-04 22:23 sashak         Note Added: 0001795                          
09-22-04 00:24 gbilotta       Note Added: 0001809                          
09-22-04 02:16 sashak         Note Added: 0001810                          
09-22-04 13:52 gbilotta       Note Added: 0001812                          
09-22-04 13:53 gbilotta       File Added: test.out                         
09-22-04 19:53 sashak         Note Added: 0001818                          
09-23-04 14:33 gbilotta       Note Added: 0001826                          
09-23-04 14:33 gbilotta       File Added: cat_regs                         
09-23-04 14:34 gbilotta       File Added: cat_regs2                        
09-24-04 03:07 sashak         Note Added: 0001853                          
09-24-04 13:30 gbilotta       Note Added: 0001880                          
09-24-04 13:32 gbilotta       Note Added: 0001881                          
09-24-04 22:45 sashak         Note Added: 0001905                          
03-02-05 14:12 perex          Relationship added       related to 0000857  
03-02-05 15:17 perex          Relationship added       related to 0000890  
08-30-05 12:26 jdthood        Severity                 block => major      
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
