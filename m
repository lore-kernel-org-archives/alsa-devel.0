From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp cardbus coldboot bug workaround
Date: Mon, 4 Aug 2003 07:06:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <39847.81.51.162.83.1059973592.squirrel@www.undata.org>
References: <32812.80.11.13.118.1059826005.squirrel@www.undata.org>
        <90bc1390e02860d700dc0b3ffab2eb74@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <90bc1390e02860d700dc0b3ffab2eb74@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jesse@essej.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I have never had the cold boot problem and I use the conditions
> you mention above.  My hardware is an IBM ThinkPad A31, with a
> rev 0xb HDSP cardbus, acpi *not* enabled (not compiled in and
> a noacpi kernel cmdline), with AC power.
>
> Hmmm, your solution might help people that do have the problem,
> though.
>
> jlc
>
>

Thanks for the report. I use 0xa, so that can be a clue, plus my
cardbus-to-pci bridge is only supported by linux since kernels > 2.4.19.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
