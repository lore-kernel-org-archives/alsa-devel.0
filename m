From: "Frank W. Miller" <fwmiller@cornfed.com>
Subject: RE: writing user program for alsa under fedora core 1
Date: Sat, 29 May 2004 20:53:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <FDEHJOEHEEGCJHLBEHMFGEOBCAAA.fwmiller@cornfed.com>
References: <1085876764.23479.1.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1085876764.23479.1.camel@eviltwin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Depner <eviltwin69@cableone.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Thanks for the reply...

I probably need to be more specific here.  I have a driver that works well
with OSS under Red Hat 9.  When I reinstalled my system using Fedora Core 1,
I did not need OSS any more.  I have nice sound coming from my speakers
using ALSA.  When I try to run my existing binary that makes OSS calls on
top of Fedora that is using an ALSA driver for my soundcard, I get some
strange behaviour, some of the calls don't work the same.  For example, the
card supports full-duplex but the ALSA driver seems to think it will only
support half-duplex.  When I try to set the sampling rate on the 16-bit
interface, I get an error (cant remember which one right now).  So my
thought was, especially after reading the docs, i.e. the HOWTO-0.9 or
something like that, that I should just rewrite the driver to make ALSA type
calls.  That's when I discovered that I dont have this header file.

So, I obviously have a working ALSA subsystem, since my soundcard works with
the CD player for example.  All I really need to do is get to a place where
I can write a program making ALSA API calls.  Thats what I need help to do.
Now, is it really necessary for me download all the source and rebuild it
and all that to accomplish this task?

Thanks,
FM



-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Jan Depner
Sent: Saturday, May 29, 2004 8:26 PM
To: Frank W. Miller
Cc: alsa-devel
Subject: Re: [Alsa-devel] writing user program for alsa under fedora
core 1


Your best bet is to download the sources and build the packages.  That
way you'll know exactly what you've got.  Also, at some point you may
have to go into the libraries and do some debugging.

Jan

On Sat, 2004-05-29 at 19:02, Frank W. Miller wrote:
> Greetings,
>
> I'm writing a softphone for Linux under Fedora Core 1.  I've had this
> client working well using OSS under Red Hat 9 for awhile now.  I've run
> into some problems however when trying to use the OSS calls under
> Fedora.  I thought I would try to just write an ALSA driver and went to
> the Programming docs.  Trouble is, they reference a header file
> <alsa/asoundlib.h> and this file doesnt exist in my Fedora core distro.
> Do I need another RPM install or something?
>
> Thanks,
> FM
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
