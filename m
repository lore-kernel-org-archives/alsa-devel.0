From: Roger E Critchlow Jr <rec@elf.org>
Subject: tecra 8100 / ymfpci
Date: Wed, 03 Dec 2003 16:54:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCE77D2.8000204@elf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi --

  The appended has been moderating for a few weeks.

  The funny thing is the other night I had 2.6.0-test11 playing sounds as
clear as could be for a while.  But it has since, after miscellaneous
reonfigs and reboots, reverted to making scratchy noises only.

  Getting toshiba specific acpi extensions, as in using the planet ccrma
2.4.2-6.ll.rh90 kernel, didn't solve the problem for me either.  Perhaps
SuSe tweaked the toshiba_acpi extensions?

  But it seems likely, still, that the toshiba specific acpi may be
banging bits in registers near or overlapping the ymfpci assignments,
or that there's a power saver setting that semi-mutes the sound chip.

  Hope this helps.  I'll probably stumble through getting the alsa
cvs version compiled in a day or two.

- rec --

>
>Greetings --
>
>   I was just checking on this, again, since I have yet another Tecra 
>8100 for Alsa to fail to work on.  I see that there was a success back 
>in July under 0.9.5 (kernel unspecified), but I'm running the planet 
>ccrma alsa-driver-0.9.6-2 and there's still nothing but static coming 
>out of the speakers here.
>
>   But, I also noticed the following post over at linuxquestions.org 
>from 11-Nov-2003 which suggests that the problem is in the toshiba 
>specific power mgmt.  Apparently, on some current SuSe releases the Alsa 
>driver works on the Tecra 8100 between the install and the first reboot, 
>then produces static.  Talk about your unrewarding bug to work on.
>
>   None of this helps me, I'm running kernel-2.4.20-20.1.caps.rh90 from 
>planet ccrma, and there are no toshiba_acpi modules to be found.
>
>   Yet, I get the feeling that this bug may be reaching its expiration date.
>
>-- rec --
>
> > Last edited by shutterbug on 11-11-2003 at 01:56 AM
> >
>  
>
>>> Toshiba 8100 laptop sound on SuSE 9.0 	( post #6)
>>> 
>>> _It's interesting.
>>> Sound works properly after installation and before first boot.
>>> After that, sound is just crackles and clicks.
>>> Here is a solution for SuSE 9.0.
>>> 
>>> If you are good at the command line:
>>> Login as root.
>>> Edit the file /etc/sysconfig/powermanagement.
>>> Look for the line that starts with ACPI_MODULES.
>>> Change the line so that it says this:
>>> ACPI_MODULES="ac battery button fan processor thermal toshiba_acpi"
>>> Then exit, _save, and reboot.
>>> 
>>> Or if you prefer a GUI:
>>> Run the YaST2 program.
>>> Click on System in the left panel.
>>> Click on "Editor for /etc/sysconfig Files" in the right panel.
>>> In left panel of resulting Configuration Options screen,
>>> click to open up (make visible) System, Powermanagement,
>>> ACPI, General, ACPI_MODULES.
>>> In right panel replace Setting of: ACPI_MODULES
>>> to be:
>>> ac battery button fan processor thermal toshiba_acpi
>>> Then click Finish to close Configuration Options screen.
>>> Then click Close to close the YaST program.
>>> 
>>> Using either method, the only part of the settings that were missing
>>> for my Toshiba 8100 laptop was "toshiba_acpi".
>>> 
>>> I rebooted and the sound problems disappeared.
>>> IF FACT... the sound worked after initial installation and before first reboot,
>>> but even then it was pretty bad. Now the sound is quite good.
>>    
>>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
