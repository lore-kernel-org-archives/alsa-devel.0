From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Guillemot ISIS Maxi Studio
Date: Thu, 21 Aug 2003 09:27:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F447451.6090605@student.kuleuven.ac.be>
References: <20030816041945.GA23675@ice_nine.wi.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

You can find most info about the alsa driver for the ISIS at
http://isisalsa.sourceforge.net/
You can also take a look at http://www.estudiohum.cl/Isis.htm for the
user base.

A few weeks ago there was a first driver release, based upon alsa 0.9.5.

There are two utils available to make the ISIS work:
* maxiinit: a firmware load/card config utility that enables the card
* an alsa driver (beta release) for the isis in 'multimedia' mode.

after using the maxiinit tool, you can choose which driver you want to
use: the isis driver or the generic maestro2E driver. The latter offers
only es1968 support, but is of higher quality than the isis driver,
which is a beta release.

Should you have some time available for this project, it would be very
welcome. For the moment I'm the only one working on it, and I don't have
that much spare time.

Ciao

Pieter

Anthony wrote:

 >Hi,
 >
 >Curious if there is any progress/info regarding the
 >Guillemot ISIS Maxi Studio card. I found some mails
 >back in 2000 which weren't very positive. I understand
 >this has two chipsets, a es1968 and a sam9457. There
 >are some kernel drivers for the later which dont help
 >with using jack and the es1968 driver loads, appears
 >happy but no output at all. So is there a user base out
 >there to make some progress on this? I'd be happy to
 >devote some time provided I'm not stabbing away in the
 >dark.
 >
 >--ant
 >
 >
 >-------------------------------------------------------
 >This SF.Net email sponsored by: Free pre-built ASP.NET sites including
 >Data Reports, E-commerce, Portals, and Forums are available now.
 >Download today and enter to win an XBOX or Visual Studio .NET.
 >http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
 >_______________________________________________
 >Alsa-devel mailing list
 >Alsa-devel@lists.sourceforge.net
 >https://lists.sourceforge.net/lists/listinfo/alsa-devel
 >
 >
 >






-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
