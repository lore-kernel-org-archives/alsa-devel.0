From: User for realtime audio <audiodev@ind.RWTH-Aachen.DE>
Subject: Re: Terratec EWS88MT
Date: Tue, 22 Oct 2002 09:46:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB50238.5000103@ind.rwth-aachen.de>
References: <3DB40D41.8070107@ind.rwth-aachen.de> <s5hy98r3lmp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------040007030902050904020504"
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


--------------040007030902050904020504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Takashi Iwai wrote:

>At Mon, 21 Oct 2002 16:20:49 +0200,
>User for realtime audio wrote:
>
>>Dear users,
>>
>>I am using the ice1712-driver for my Terratec EWS88MT soundcard.
>>
>>All compiles fine and the modules are loaded as well. After having 
>>compiled and installed everything
>>I tried to use the envy24control tool. After typing the instruction to 
>>start it nothing happens but the whole system is dead.
>>I have to reset by pushing the button.
>>
>>The same happens when simply calling 'amixer contents'.
>>
>>aplay ...wav does not play any sound even though all channels have been 
>>unmuted.
>>
>>I have now added a soundblaster audigy as first soundcard which works well!
>>
>>Has anyone experienced similar problems with that Terratec card?
>>
>
>which version are you using?
>there was a dead-lock mutex bug in i2c code but should have been fixed
>on the latest version.
>
>please try the cvs version.
>
>
>Takashi
>
>
>
I am running kernels 2.4.16 with low latency patches and the RTC patch 
from alsa-package-rc3
and 2.4.18 without any patches alternatively. The alsa-package was rc-3 
and is now the current
CVS-version. In all cases envy24control and amixer contents lead to the 
system lock (amixer without contents works fine!)

I have started "strace envy24control" which let me know that

ioctl(4, 0xc245512, 0xbfffedb0)

is the instruction that causes the system lock. Multiple ioctls with 
only the third argument differing
returned 0 just before the system lock.

When calling amixer contents, the last message printed is:

numid=103, iface=mixer, name='Input Sensitivity Switch', index=1
    ; TYPE=enumerated, access=rw---, values=1, items=2
    ; Item #0 ='+4dBu'
    ; Item #1 = '-10dBV'


In comparison to the previous outputs coming from amixer contents
the following line is missing:
    ; values=0

Any idea?

Regards,
Hauke



--------------040007030902050904020504
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<html>
<head>
</head>
<body>
<br>
<br>
Takashi Iwai wrote:<br>
<blockquote type="cite" cite="mid:s5hy98r3lmp.wl@alsa2.suse.de">
  <pre wrap="">At Mon, 21 Oct 2002 16:20:49 +0200,<br>User for realtime audio wrote:<br></pre>
  <blockquote type="cite">
    <pre wrap="">Dear users,<br><br>I am using the ice1712-driver for my Terratec EWS88MT soundcard.<br><br>All compiles fine and the modules are loaded as well. After having <br>compiled and installed everything<br>I tried to use the envy24control tool. After typing the instruction to <br>start it nothing happens but the whole system is dead.<br>I have to reset by pushing the button.<br><br>The same happens when simply calling 'amixer contents'.<br><br>aplay ...wav does not play any sound even though all channels have been <br>unmuted.<br><br>I have now added a soundblaster audigy as first soundcard which works well!<br><br>Has anyone experienced similar problems with that Terratec card?<br></pre>
    </blockquote>
    <pre wrap=""><!----><br>which version are you using?<br>there was a dead-lock mutex bug in i2c code but should have been fixed<br>on the latest version.<br><br>please try the cvs version.<br><br><br>Takashi<br><br><br><br></pre>
    </blockquote>
I am running kernels 2.4.16 with low latency patches and the RTC patch from
alsa-package-rc3<br>
and 2.4.18 without any patches alternatively. The alsa-package was rc-3 and
is now the current <br>
CVS-version. In all cases envy24control and amixer contents lead to the system
lock (amixer without contents works fine!)<br>
    <br>
I have started "strace envy24control" which let me know that <br>
    <br>
ioctl(4, 0xc245512, 0xbfffedb0) <br>
    <br>
is the instruction that causes the system lock. Multiple ioctls with only
the third argument differing<br>
returned 0 just before the system lock.<br>
    <br>
When calling amixer contents, the last message printed is:<br>
    <br>
numid=103, iface=mixer, name='Input Sensitivity Switch', index=1<br>
&nbsp;&nbsp;&nbsp; ; TYPE=enumerated, access=rw---, values=1, items=2<br>
&nbsp;&nbsp;&nbsp; ; Item #0 ='+4dBu'<br>
&nbsp;&nbsp;&nbsp; ; Item #1 = '-10dBV'<br>
    <br>
    <br>
In comparison to the previous outputs coming from amixer contents<br>
the following line is missing:<br>
&nbsp;&nbsp;&nbsp; ; values=0<br>
    <br>
Any idea?<br>
    <br>
Regards,<br>
Hauke<br>
    <br>
    <br>
    </body>
    </html>

--------------040007030902050904020504--



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576301;v?
http://www.sun.com/javavote
