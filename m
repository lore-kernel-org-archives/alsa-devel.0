From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: alsa docs - PHP help
Date: Wed, 21 Aug 2002 13:43:47 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D631A83.3000000@boosthardware.com>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D52949C.6030706@boosthardware.com> <3D53606D.3020201@mindcom.fi> <3D5366C4.9050101@boosthardware.com> <3D536705.9040705@mindcom.fi> <3D536C72.10302@boosthardware.com> <3D536DE5.20601@mindcom.fi> <3D537354.2030900@boosthardware.com> <3D537337.4080802@mindcom.fi> <3D537C3C.9000105@boosthardware.com> <3D5B6FE2.1040603@mindcom.fi> <3D5B7BA7.7040502@boosthardware.com> <3D5B7FC5.2030404@mindcom.fi> <3D60EDB4.7080600@boosthardware.com> <3D60EE47.7050704@mindcom.fi> <3D60FA94.4010001@boosthardware.com> <3D610A82.6080709@mindcom.fi> <3D629F9B.8070301@mindcom.fi>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Using urlencode on the template doesn't solve the problem for older
browsers.

Can anyone think of a regex to auto encode the every line in the index 
page that looks like this:

<a
href="doc-php/template.php3?company=Abit&card=AU10&chip=FM801&module=fm801">Install</a>

So that the variables are ulrencoded before the page is rendered?

Otherwise I/future maintainers have to go through every device and hand 
type it in and any patches that are made too.

Ergh!

I'm thinking of something like

   	if (line = <a href="doc-php/template.php3?...){
		for (every variable){
			rewrite as urlencode($variable);
		}
	}		

would I then have to use urldecode in the template?

thx.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
