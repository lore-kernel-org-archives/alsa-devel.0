From: Jesse Chappell <jesse@essej.net>
Subject: Re: still hammerfall-mem on hdsp?
Date: Sat, 17 Jan 2004 14:38:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <7c985d9e9b9c5b23e8d9997f4d08328d@essej.net>
References: <1074362691.28226.4.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074362691.28226.4.camel@lotte.street-vision.com>
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

Justin Cormack wrote on Sat, 17-Jan-2004:

 > On Sat, 2004-01-17 at 17:24, Orm Finnendahl wrote:
 > > Am 17. Januar 2004, 14:31 Uhr (+0100) schrieb Tim Blechmann:
 > > >
 > > > you shouldn't need this...
 > > 
 > > Thanks. I get snd-hdsp loaded and the firmware uploaded. "cat
 > > /proc/asound/card0/hdsp" looks good. But when I try to run alsamixer i
 > > get 
 > > 
 > > no mixer elems found 
 > > 
 > > This is a freshly installed machine and I fear there are some missing
 > > device links or something. I ran the snddevices script in alsa-driver.
 > > Bear with me if this is stupid and just point me to appropriate
 > > readmes if possible.
 > 
 > it doesnt have a mixer, other than the hardware matrix mixer.
 > Docs are on the website, but try
 
You really need to use hdspmixer and hdspconf, they are available
in the alsa-tools (or utils, not sure).  The former is TotalMix
clone to give a full GUI to the powerful matrix mixer.  hdspconf
lets you set other settings (clock sync/rate, adat/optical input, etc)

jlc


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
