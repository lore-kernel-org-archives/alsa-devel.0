From: Peter Vollmer <remllov_@gmx.de>
Subject: VT1712 digital mixer to consumer ac97 only mono?
Date: Wed, 23 Jul 2003 20:11:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030723195734.05cde540@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hi all,

I am using the Terratec EWS88MT (VT1712 / Envy24 based) soundcard and would 
like to route the digital mixer output to the consumer output (headphone 
socket) using the "digital mixer to ac97" option in alsamixer. The signal 
is routed correctly, but it is only a mono version of the stereo mix 
signal. Did anybody succeed in using this feature for stereo ?

The envy24 datasheet says on page 4-41:
MT3C: Digital Mixer Monitor Routing Control Register
Address Offset: 3Ch
Default Value: 00h

Bits Attribute Description:
7:6 R0 -
0 R/W 1: Route digital mixer output to the Consumer AC'97 path by 
allocating Channel-A and B.

Does that mean I would have to use the DirectSound Channels A&B sound 
settings to yield stereo (they are mono by default)?
I tried this and it did not work.

Thanks

Peter  



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
