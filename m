From: elchhome@gmx.de
Subject: Re: Dell OEM Soundblaster Live 5.1 with different PCI
 ID
Date: Thu, 19 Dec 2002 11:47:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E01A3D4.20908@gmx.de>
References: <3E019532.6080001@gmx.de> <s5hu1hauvxh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

thanks for your fast answer :)
I will give you feedback at latest monday, because I am not at home at 
the moment
you are right, this is emu10k1 not audigy
regards
Andreas


Takashi Iwai schrieb:

>At Thu, 19 Dec 2002 10:45:22 +0100,
>elchhome@gmx.de wrote:
>  
>
>>Hello Friends,
>>
>>Dell ships since a month an OEM Soundblaster Live 5.1 (sb0200) with a 
>>different PCI ID
>>
>>for original sblive you got 1102:0002
>>the Dell version has 1102:0006
>>
>>I got  no sound with the actual version of the sound driver.
>>Could anyone be so kind to incorporate this into the source code?
>>    
>>
>
>please try the attached patch.
>this will add the entry as emu10k1 (sb live!).  it seems that the chip
>is emu10k1, not audigy.
>if it works, please let me know.  i'll commit it to cvs.
>
>
>thanks,
>
>Takashi
>  
>




-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
