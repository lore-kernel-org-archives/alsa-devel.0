From: "Lars Karlstrom" <lasse8888@hotmail.com>
Subject: Problems with Input/Output Sensitivity Switch on M-Audio Delta 44
Date: Fri, 02 Jul 2004 16:22:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY13-F43ecaEt5u4rt0007035a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

First of all, please consider that I am a newbie to alsa, so please correct 
me if I am wrong.

I am trying to figure out how to write an application that can control the 
input and output sensitivity switches on a M-Audio Delta 44 card (ice1712). 
If I have understood everything I should be able to control this in 
envy24control, my problem is that these options doesn't even appear in 
envy24control. Other things in envy24control does work though, for example 
the VU-meter. Does anyone have a clue why this is? In the application for 
Windows these settings works fine so there is probablly nothing wrong with 
the card.

Because this doesn't work I have started digging into the alsa-kernel code 
and the code for envy24control to try to find something useful, this is what 
I have found.
Conclusions from digging in envy24control:
- The block of code that is trying to find how many different sensitivities 
that is available returns zero (called adc_senses and dac_senses in the 
code?).
- If I try to run the code that sets these sensitivities (even though I get 
zero adc/dac_senses) I get an error message "Unable to write dac sense: No 
such file or directory". But I guess this is what should happen since these 
options doesn't exist.. Just had to try..
Conclusions from looking at the alsa-kernel code:
- When i searched for "Input Sensitivity Switch" (which seems to be the 
string that envy24control uses for finding how many sensitivities that are 
available) in the code, I found that this string only exists in 
alsa-kernel/pci/ice1712/ews.c, this seems to be a driver for Terratec-cards. 
Also in this file I found that there seems to be only 2 sensitivities, 
"+4dBu" and "-10dBV", when I tested the Windows application I got 3, 
"+4dBu", "Consumer" and "-10dBV". After I found these 2 things I am 
wondering if this whole sensitivity switch thing is implemented or not for 
the Delta series.

Cheers
/Lars

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
