From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver status
Date: Sun, 6 Jul 2003 11:33:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34975.81.51.161.173.1057484037.squirrel@www.undata.org>
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
        <33044.24.225.156.130.1057418373.squirrel@webmail.ouroboros-complex.org>
        <32870.24.225.156.130.1057461318.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32870.24.225.156.130.1057461318.squirrel@webmail.ouroboros-complex.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3@ouroboros-complex.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>> I ran hdsploader the first time and it failed. I ran it a second time
>> and the red light on the Multiface went out, [...]
>
> For the record, this is incorrect. I run it once and the red light goes
> out. I have a feeling the error message is incorrect, because the "card"
> seems to work now. hdsploader seems to not be robust in the face of
> running twice against the same card. Again, thank you.
>

Thanks for your report. I'm glad the card gets of some use for rev 11
multiface users, but note that this is more of a workaround than the real
solution. I really suspect something is broken when using the old firmware
with rev 11 cards.
Can you please send me the output of dmesg just after you run hdsploader
and it returns an error, and report precisely the status of the card
before and after hdsploader is run (red light on/off, sound working or
not) ?

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
