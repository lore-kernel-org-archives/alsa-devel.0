From: <jfm3@ouroboros-complex.org>
Subject: Re: hdsp driver status
Date: Sat, 5 Jul 2003 08:19:33 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33044.24.225.156.130.1057418373.squirrel@webmail.ouroboros-complex.org>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
        <3F044FF5.2010602@boosthardware.com>
        <3F0456A5.9000600@boosthardware.com>
        <1057252106.7192.61.camel@lotte>
        <32866.81.50.18.84.1057263312.squirrel@www.undata.org>
        <1057322609.7193.65.camel@lotte>
        <35616.217.128.161.242.1057324690.squirrel@www.undata.org>
        <1057325373.10858.77.camel@lotte>
        <35748.217.128.161.242.1057327134.squirrel@www.undata.org>
        <1057331014.10858.87.camel@lotte>
        <36141.24.225.156.130.1057376158.squirrel@webmail.ouroboros-complex.org>
        <32832.217.128.97.180.1057393794.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32832.217.128.97.180.1057393794.squirrel@www.undata.org>
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

That hdsploader patch sort of works. I can get sound out of my Multiface now.

I ran hdsploader the first time and it failed. I ran it a second time and
the red light on the Multiface went out, but the hdsploader process never
finished. In fact, it did not even respond to kill -9. It was idle --
neither user nor kernel cpus were being used by it as it wedged. But the
red light on the Multiface was out. So I rebooted Linux, running
hdsploader now works, and now I can hear sound out of the Multiface.

I still have no idea what I'm doing in terms of managing that gigantic
mixer. My modules.conf file needs work. Let me see if I can narrow down
the problem some more, or blame it on cosmic rays, or something.

Much thanks to all.

(jfm3)




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
