From: Justin Cormack <justin@street-vision.com>
Subject: Re: still hammerfall-mem on hdsp?
Date: 17 Jan 2004 18:04:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074362691.28226.4.camel@lotte.street-vision.com>
References: <20040116222019.GA12671@finnendahl.de>
	<20040117143105.1576449c.TimBlechmann@gmx.net>
	<20040117172420.GA2865@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040117172420.GA2865@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-01-17 at 17:24, Orm Finnendahl wrote:
> Am 17. Januar 2004, 14:31 Uhr (+0100) schrieb Tim Blechmann:
> >
> > you shouldn't need this...
> 
> Thanks. I get snd-hdsp loaded and the firmware uploaded. "cat
> /proc/asound/card0/hdsp" looks good. But when I try to run alsamixer i
> get 
> 
> no mixer elems found 
> 
> This is a freshly installed machine and I fear there are some missing
> device links or something. I ran the snddevices script in alsa-driver.
> Bear with me if this is stupid and just point me to appropriate
> readmes if possible.

it doesnt have a mixer, other than the hardware matrix mixer.
Docs are on the website, but try

amixer cset numid=5 26,0,32768
amixer cset numid=5 27,1,32768

to route playback channels 1 and 2 to multiface analogue channels 1,2 or
digiface adat1 channels 1 and 2.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
