From: "Edward Wildgoose" <Ed@Wildgooses.com>
Subject: Re: Is a complete Alsa restart possibly without rebooting?
Date: Wed, 6 Aug 2003 18:37:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01de01c35c41$67e0c800$cb40a8c0@FRiskMan.com>
References: <NDBBLGIKBJENLAMOLFHGIEKKCOAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>    I don't think you need to send the file. So far this is sort of what
I'm
> doing by hand, but it isn't working. I can stop audio apps, then stop
Alsa,
> remove everything from memory (I think), and then restart Alsa. Alsa
starts
> up cleanly with no error messages, but sound does not return.

Actually perhaps this is the problem that I am seeing as well on a P4P800
board with a hyperthreaded P4.  I have a dual P3 which starts and stops alsa
fine, at least up to about alsa 0.9.4.  However, with this board if I do an
alsa restart, modules reload, but no sound until reboot, and this happens
with various builds at least as far back as 0.9.2

The main soundcard is an RME 96/8 PAD, but I also have an onboard intel
compatible thing which seems to suffer the same issues.

Also in my case I don't get any OSS devices created, /dev/dsp, etc.

Just an extra datapoint I hope...



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
