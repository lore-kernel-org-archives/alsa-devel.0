From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver status
Date: Thu, 3 Jul 2003 22:13:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32861.81.50.18.84.1057263181.squirrel@www.undata.org>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
        <3F044FF5.2010602@boosthardware.com>
        <3F0456A5.9000600@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F0456A5.9000600@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pshirkey@boosthardware.com
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> following the above I decided to check I was setting the correct params
> in the matrix and it turns out that line out has been moved to numid 22
> (before it was 5).
>
> amixer -D hw:1 cset numid=22 0,0,16384
>

You're mixing things up.
This is the syntax of the matrix mixer ctl.
The line out value type is boolean. To enable line outs you should this :
amixer -D hw:1 cset numid=22 1

I think the command you were using was doing the exact opposite of what
you wanted.

Maybe you should remove your asound.state file. Alsactl may try to restore
the state of parameters whose numid changed, leading to unpredicted and
presumably unwanted results.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
