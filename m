From: <jfm3@ouroboros-complex.org>
Subject: Re: hdsp driver status
Date: Fri, 4 Jul 2003 20:35:58 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <36141.24.225.156.130.1057376158.squirrel@webmail.ouroboros-complex.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1057331014.10858.87.camel@lotte>
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

> On Fri, 2003-07-04 at 14:58, Thomas Charbonnel wrote:
>> > And the driver is 0.9.0rc6 not 5, and it is patched to add 0xb
>> (unless that was in 0.9.0rc6 but not 5). And the matrix mixer does
>> work (just rechecked, which took a little while as the machine is in
>> another country...)
>>
>> Ok, thanks for your help. Could you then try the latest driver with
>> this patch applied to hdsploader. It forces the upload of the true and
>> tested old firmware. What bothers me is that if RME insists so much on
>> flashing the cards when upgrading driver, it must be that something
>> changes in the way the hardware is accessed. I remember something was
>> broken when I tried the 0xb card, but can't remember what. It could be
>> the metering stuff I was debugging then. At that time we were waiting
>> for the new firmware files from RME, and I expected it would solve the
>> problem.
>
> ok, will try on Monday/Tuesday when I am in same country as the card as
> it is easier. I have a 0xa here that I will test over the weekend.
>
>> Did you drop the alsa-dev CC on purpose ?
>
> No, accident...
>

I would like to give this patch a go. Can you post it to the list? (Or did
I miss it somehow?)

(jfm3)




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
