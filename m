From: Dan Mills <dmills@spamblock.demon.co.uk>
Subject: Could someone have a look at a my driver code please.
Date: Wed, 30 Jul 2003 22:52:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <03073022520900.00991@spamblock>
References: <200307302036.h6UKaJ6p001930@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307302036.h6UKaJ6p001930@localhost.localdomain>
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

Hi all,
I have written a  *very*  crude driver for the waveterminal 192L (mostly 
my guesswork as to how the thing is hooked up). It is based on the ice1724 
code but is really an engineering prototype (worked for the first time 20 
minutes ago) and not ready for prime time.
 
In particular it ignores the eeprom except for a check that its contents 
match that of the one on my card. It works for output pair 1, and may work 
for the others but that is uncertain at this point. It probably also has 
locking issues at present. 

Would someone be willing to take a look and give some pointers as to how 
to make this thing into a fully correct alsa driver? 

Undocumented hardware and a driver architecture with which you are not 
familiar make development fun!

My code will go up on the web once I have shaken a few more bugs out
(The mixer does nothing very useful at present & I am fairly sure that
playing with the GPIO pins some will get the phantom power and mic pre 
working.....). 

Regards, Dan.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
