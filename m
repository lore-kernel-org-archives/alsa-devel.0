From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver status
Date: Fri, 4 Jul 2003 15:18:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <35616.217.128.161.242.1057324690.squirrel@www.undata.org>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
        <3F044FF5.2010602@boosthardware.com>
        <3F0456A5.9000600@boosthardware.com>
        <1057252106.7192.61.camel@lotte>
        <32866.81.50.18.84.1057263312.squirrel@www.undata.org>
        <1057322609.7193.65.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1057322609.7193.65.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: justin@street-vision.com
Cc: thomas@undata.org, pshirkey@boosthardware.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> > you mean 0xb? I have one that works on 0.9.0rc5, but wont work on
>> 0.9.4/todays cvs.
>>
>> That's surprising. Does the matrix mixer work with 0.9.0rc5 ?
>
> Yes its fine. But I though it was only the 9652 that had a matrix mixer
> problem...
>
> Justin
>

I've just had a look at the 0.9.0rc5 driver code. Either your card is not
a 0xb version, either you're using a patched 0.9.0rc5:

(from the snd_hdsp_create() function)

        switch (rev & 0xff) {
        case 0xa:
                /* hdsp_initialize_firmware() will reset this */
                hdsp->card_name = "RME Hammerfall DSP";
                break;

        default:
                return -ENODEV;
        }



If you patched your driver (e.g. adding a 0xb case to the rev switch) then
this means the rev 0xb cards can work with the old firmware, which
surprises me a lot. I remember trying once a rev 0xb card a couple of
months ago. I used it in combination with my 0xa card to test Adat and
S/PDIF external sync. I forced it to initialize with the old firmware, but
IIRC the matrix mixer was broken.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
