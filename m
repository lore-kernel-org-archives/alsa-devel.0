From: "Dan Nyborg" <nyborg@www.vertice.ca>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Thu, 31 Jul 2003 10:37:16 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030731163611.M29660@vertice.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hello,

tried playback of a mono file, to the same ends. yesterday in one instance, i
got around 45min of stereo playback before  a lock up.

also experienced a lock up in ardour yesterday, monitoring a single channel
and outputing it on another channel.

haven't tried recording anything to see if the same problem exists there. 
it's tough to test these things as i'm guaranteed a lock-up, ie: my drives
have to be fsck'd each time.

does anyone know of a way to safely debug this? can i catch the playback
thread before it pees on the floor, "NO! Geez hdsp, stream goes out the
urinal! ...hold that thing, damnit!!!" ?

dan.

Mark Knecht wrote:

>>however, when i try to play something with alsaplayer or aplay, my system
>>freezes after 2 sec to 2 min of playback... sometimes i can get through a
>>whole file, sometimes only partial, but an eventual lock-up is
>>inevitable. i
>>have not tried sending anything other than stereo, 44100kHz, 16bit files.
>
>
>Dan,
>   I'm using a 'similar' driver from Thomas, but not the identical driver,
>and with the HDSP 9652, not the MultiFace. Using aplay and MONO wave files
>I'm fine. Using anything in stereo results in all sorts of problems,
>including hard locks or at the minimum no further sound. Only a reboot fixes
>this for me.
>
>   Could you try a mono file and see what results you get?
>
>   alsaplayer sometimes works for me. For about 30 seconds I'll get sound,
>and then the sound stops and doesn't work until a reboot.
>
>- Mark
>
>
>
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by: Free pre-built ASP.NET sites including
>Data Reports, E-commerce, Portals, and Forums are available now.
>Download today and enter to win an XBOX or Visual Studio .NET.
>http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>


--
Open WebMail Project (http://openwebmail.org)



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
