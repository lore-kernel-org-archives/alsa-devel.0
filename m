From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: PDAudioCF questions
Date: Thu, 14 Aug 2003 23:59:12 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030814235912.5ae58979.erikd-alsa@mega-nerd.com>
References: <3F3B867E.D0D41B46@bright.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F3B867E.D0D41B46@bright.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Aug 2003 07:54:23 -0500
Dave Phillips <dlphilp@bright.net> wrote:

> Greetings:
> 
>   I'm testing the Core Sound PDAudioCF card on a laptop, an Omnibook
> 4150, using a CF-to-PCMCIA adapter. The card appears to initialize
> correctly, and 'cat /proc/asound/cards' tells me this:
> 
> 	0 [PDAudioCF      ]: PDAudio-CF - Core Sound PDAudio-CF
>         	             Core Sound PDAudio-CF at 0x100, irq 11
> 
> 'ls /proc/asound/card0' yields this information:
> 
> 	dlphilp@localhost:~$ ls /proc/asound/card0/
> 	id  oss_mixer  pcm0c
> 
> where 'pcm0c' is a subdirectory and oss_mixer simply lists mixer
> elements. However, I've been unable to invoke a mixer for the card. That
> might be why I receive the following error trying to use arecord:
> 
> 	dlphilp@localhost:~$ arecord -Dhw:PDAudioCF -f cd
> 	RIFF$ÿÿWAVEfmt o`aD¬o±acodataÿÿRecording WAVE 'stdout' : Signed 16 bit
> Little Endian, Rate 44100 Hz, Stereo
> 	arecord: pcm_read:1110: read error: Input/output error

Hi Dave,

Do you have a digital input connected? The thing that makes digital inputs
different from analogue ones is that they need to synch to the serial input
stream. For the PDAudioCF, this means that you need to tell it the input
sample rate. You can find this out by doing:

     amixer -c PDAudioCF cget iface=PCM,name='IEC958 External Rate'

which will give you the sample rate if you have an input connected or 0
if no input is connected. 

Once you know the input sample rate you should do one of these:

    arecord -Dhw:PDAudioCF -r <rate> -f cd file.wav
    arecord -Dhw:PDAudioCF -r <rate> -f cd >/dev/null

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
Everything that I've learned about computers I have boiled 
down into three principles:
  PC/Windows: You think it won't work, and it won't.
  Macintosh: You think it will work, but it won't.
  Unix: You think it won't work, but if you find the right 
        guru, you can make it work.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
