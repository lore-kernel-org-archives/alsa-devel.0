From: Horacio de Oro <horacio@trimaxcba.com>
Subject: Re: Mixer problem with VT8233/A/8235/8237 AC97 Audio
 Controller (rev 60)
Date: Mon, 24 Jan 2005 21:10:05 -0300
Message-ID: <41F58E5D.4000409@trimaxcba.com>
References: <41F1CE80.1080302@trimaxcba.com> <s5hd5vv2lfk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5vv2lfk.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Takashi Iwai wrote:
> At Sat, 22 Jan 2005 00:54:40 -0300,
> Horacio de Oro wrote:
> 
>>I've a problem with the mixer of my sound card. It never has worked fine.
>>
>>I run 'aumix', the /dev/mixer is opened fine:
>>
>>horacio@corralito-ng:~$ lsof  /dev/mixer
>>COMMAND    PID    USER   FD   TYPE DEVICE SIZE NODE NAME
>>mixer_app  859 horacio   34u   CHR   14,0      5239 /dev/mixer0
>>aumix     1869 horacio    3u   CHR   14,0      5239 /dev/mixer0
>>
>>I can change any volume control (for example: "CD"). While I move the 
>>control, I can hear the volume goes UP and DOWN, but I can't change the 
>>"main" volume, and I can't change the "PCM" volume (this control are on 
>>"top").
> 
> 
> They are not supporbed by your hardware.
> CMI9739 AC97 codec doesn't have Master and PCM volumes.
> Only PCM switch works.
> 
> 
> Takashi
> 

Hi Takashi! Thanks for your response!

Using "Gnome Volume Control" v2.8.0 (or earlier), the "PCM" works like a 
"binary variable", so:
   1) if the PCM volume is between 1% to 100%, then the volume you hear 
is at maximum (the same volume is at 1% and to 100%).
   2) if you put PCM volume at 0%, the PCM volume go off, and you can't 
hear more mp3, wav, etc.

So:
  PCM = 0% -> PCM volume off
  PCM = 1% to 100% -> PCM volume at maximum

This way, the only way to put the volume a little down, is using the 
speakers.

Is this the way the mixer should work? (because of the lack of support)

Thanks in advance!!

Horacio


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
