From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 17:45:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33325.62.106.184.128.1060616722.squirrel@www.undata.org>
References: <32833.62.106.184.128.1060585201.squirrel@www.undata.org>
        <200308111132.10869.chris@realcomputerguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308111132.10869.chris@realcomputerguy.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: chris@realcomputerguy.com
Cc: alsa-devel@lists.sourceforge.net, thomas@undata.org
List-Id: alsa-devel@alsa-project.org

> On Monday 11 August 2003 03:00, Thomas Charbonnel wrote:
>> > Is there an RME HDSP 9632 driver in development?
>> > The current hdsp driver from 0.9.6 will not load claiming the device
>> is not  present.
>>
>> No that I know of. The hdsp 9632 is quite different from the other
>> hdsp cards. Supporting it will require non-trivial driver adaptation.
>> Right now the driver claims the device is not present because it
>> doesn't recognise the card revision number (>= 0x96). I've asked RME
>> about the card, I'll let you know.
>
> I noticed the diff for the driver from rev 1.41 to 1.42 while browsing
> cvs  which added support for the rev 50 cards (I'm not a programmer,
> just a  curious sort). I'm guessing that I could add a "case 0x96" and
> the driver may  load, yet the card is so different it probably wouldn't
> work - especially  since the analog I/O is the main thing I'm looking to
> get as a starter.

Adding a "case 0x96" wouldn't be enough for audio (though it could get
midi working, just don't touch audio) : the matrix mixer code and the
metering code are different, as well as the number of available audio
channels.

I've just got an answer from RME. Expect something to test soon :)

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
