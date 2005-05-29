From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000373]: Sound in Quake 3 does not work
Date: Sun, 29 May 2005 08:07:42 +0200
Message-ID: <c7893f37f7ead4512566c8e866e8f91b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A62601C3
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 08:07:42 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=373> 
======================================================================
Reported By:                damage
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   373
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Suse Linux 9.1
Kernel Version:             2.6.5-7.95-default
======================================================================
Date Submitted:             07-09-2004 21:37 CEST
Last Modified:              05-29-2005 08:07 CEST
======================================================================
Summary:                    Sound in Quake 3 does not work
Description: 
I already tried several things to get sound working in Quake 3. It doesn't

work. Sound in other applications, such as xmms, works without problems.
My System: SUSE Linux 9.1 Pro 64bit, MSI K8T Neo FIS2R, Athlon 64 3200,
1GB 
RAM, VIA 8237 on board sound

I tried it with the ALSA version that comes with the Default Suse Kernel,
then 
with version 1.05a and at the moment I've installed a version from CVS two

days ago. I loaded the alsa module with dxs_support 0 to 4, that didn't 
resolve the issue.

Without changing anything in the ALSA configuration Quake 3 starts and the

game runs without problems, but there is no sound. The following error 
message is displayed when Quake 3 starts.
------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less 
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

Enabling direct access to the OSS playback device and disabling the OSS 
capture device with 
echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "quake3.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss
I get sound in the Quake 3 menu, but as soon as I enter a map the game
hangs 
and the only way to get back to X is to kill the process.

I also tried the user space ALSA OSS wrapper library. With this library I
only 
get some crackling noises in the menu and in the game.

With xrun_debug 1 I get a few of the following messages (at least with the

actually installed drivers from CVS) in the system log. These messages are

also there when I run other applications than Quake 3.
Jul  8 19:07:48 mordor kernel: ALSA sound/core/pcm_lib.c:199: Unexpected 
hw_pointer value [1] (stream = 0, delta: -1024, max jitter = 8192): wrong

interrupt acknowledge?
Jul  8 19:07:48 mordor kernel: ALSA sound/pci/via82xx.c:731: invalid 
via82xx_cur_ptr, using last valid pointer
Jul  8 19:08:00 mordor last message repeated 194 times

I don't know whether that has something to do with the problem.

======================================================================

----------------------------------------------------------------------
 badbunny - 10-27-04 00:37 
----------------------------------------------------------------------
Have you tried seting the dxs_support options yet. In modprobe.conf try
adding 
"options via82xx dxs_support=4".

----------------------------------------------------------------------
 Xero - 05-29-05 08:07 
----------------------------------------------------------------------
seems like this bug has been sitting open a little while. I have noticed
similar myself and think I've tracked down just what is going on.

Basically, when quake3 converts to a rate that isn't a multiple of it's
native rate of 22050, it freezes when it plays certain sounds. So, for
example, quake3 +set sndspeed 44100 with a card that supports 44100 will
work just fine. However, change that value to 48000 and it'll freeze on
certain sounds. I've experimented a bit and found that even higher rates
such as say, 88200, will work fine, and 96000 won't. So I actually believe
this is a problem with quake3, not alsa.

I believe the above mentioned via card only runs at 48000, or it did at
one point, and thus this issue was probably unavoidable.

this patch dated 4/11/05 makes me think those with that card will probably
be able to get this working fine now simply by running at a rate that's
multiple of 22050:
http://www.alsa-project.org/alsa/ftp/kernel-patches/mm/3111.patch


I like to run my card at 96000 and that is how I noticed this problem...I
just wish AOSS worked better with quake3 so I could avoid all of
this...Also, that quake3.x86 0 0 direct thing that is always being used I
find isn't necessary as long as you specify the appropriate sndspeed, at
least in my case. For now I've settled at running my card at 88200...as
this also fixes an issue with beep/xmms, dmix, and distortion, again
related to rate conversion...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-04 21:37 damage         New Issue                                    
07-09-04 21:37 damage         File Added: alsa_q3_debug.txt                    
07-09-04 21:37 damage         Distribution              => Suse Linux 9.1  
07-09-04 21:37 damage         Kernel Version            => 2.6.5-7.95-default
07-09-04 21:41 damage         File Added: alsa_q3_debug.txt                    
07-09-04 21:46 damage         Note Added: 0001396                          
07-09-04 21:50 damage         Issue Monitored: damage                      
07-11-04 00:04 tokugawa       Note Added: 0001406                          
07-11-04 02:35 damage         Note Added: 0001407                          
07-18-04 19:13 damage         Note Added: 0001459                          
07-26-04 16:20 Deelight       Note Added: 0001474                          
10-27-04 00:37 badbunny       Note Added: 0002268                          
04-09-05 16:42 jdthood        Status                   new => acknowledged 
04-09-05 16:42 jdthood        Description Updated                          
04-09-05 16:42 jdthood        Additional Information Updated                    
05-29-05 08:07 Xero           Note Added: 0004780                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
