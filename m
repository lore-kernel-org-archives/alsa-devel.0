From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1
 works, alsa-driver-1.0.9rc2 doesn't
Date: Thu, 31 Mar 2005 22:44:53 +0200
Message-ID: <424C6145.20703@pobox.sk>
References: <20050330230127.47575.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050330230127.47575.qmail@web52903.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Problem is, that your card was not detected correctly and ac97 mixer 
initialization is was not run.
Looks like card identification broke lot of cards and things.

Peter Zubaj

Chris Rankin wrote:

>--- James Courtier-Dutton <James@superbug.co.uk> wrote:
>  
>
>>Chris Rankin wrote:
>>    
>>
>>>I've just compared the results with the alsa-driver-1.0.9rc1 and alsa-driver-1.0.9rc2 tarballs
>>>with my Audigy2 sound card.
>>>
>>>The summary: I can record via the microphone with rc1, but can't with rc2.
>>>
>>>The command I'm using is:
>>>
>>>$ arecord -d10 -f cd -t wav > test.wav
>>>
>>>      
>>>
>>What does cat /proc/asound/cards  output?
>>    
>>
>
>0 [Audigy2        ]: Audigy2 - Sound Blaster Audigy2
>                     Sound Blaster Audigy2 (rev.4, serial:0x10031102) at 0xccc0, irq 21
>1 [ICH            ]: ICH4 - Intel 82801DB-ICH4
>                     Intel 82801DB-ICH4 with AD1981B at 0xffa20400, irq 17
>2 [WebCam         ]: USB-Audio - USB Device 0x46d:0x8b4
>                     USB Device 0x46d:0x8b4 at usb-0000:00:1d.1-1, full speed
>
>
>Send instant messages to your online friends http://uk.messenger.yahoo.com 
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by Demarc:
>A global provider of Threat Management Solutions.
>Download our HomeAdmin security software for free today!
>http://www.demarc.com/Info/Sentarus/hamr30
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
