From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: ICE1724 & Prodigy  instant reboot..
Date: Sun, 16 Nov 2003 10:53:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB79D6D.3050006@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi everybody,

I'm still working on the audiotrak prodigy driver.  However for some 
reason the ice1724 module performs an instant reboot of the kernel when 
I try to record at 44khz. Recording at 96khz seems fine but as soon as 
you select 44khz on arecord, something odd happens. No data come out and 
no error messages from the module but the computers reboots after 1-2 
seconds. Experiments on the console revealed some kernel error messages 
(something with the word vm inside :) milliseconds before the reboot but 
there is
no time to read the messages really.  Is this a known problem with the 
ice1724 (i guess not) or something else is wrong? Note that the hardware 
access of prodigy to the DAC/ADC works fine and the interrupts should be 
generated ok. Also the ice1724 configuration is copied directly from the 
win driver and should be fine. Any ideas?

Apostolis




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
