From: Michal Kochanowicz <michal@michal.waw.pl>
Subject: Re: Re: Mixer programming - is there any documentation
 available?
Date: Tue, 16 Jul 2002 12:53:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D33FB30.6020806@michal.waw.pl>
References: <E17Tomo-0000ZW-00@usw-sf-list2.sourceforge.net> <20020715174522.87026.qmail@web21004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2002 at 10:45:22AM -0700, Kevin Conder wrote:
 > Merely saying something is worthless doesn't help improve it at all. So
 > could you tell us what you expect from API documentation? What is
 > ALSA's API documentation missing?
Please tak a look at these descriptions. For example:
------------------------------------------------------------------------
snd_mixer_class_register

Register mixer element class.

Parameters:
     class   Mixer element class
     mixer   Mixer handle

Returns:
     0 on success otherwise a negative error code

For use by mixer element class specific code.
------------------------------------------------------------------------

I really don't know what these classes are...

 > Please be specific as possible (examples? searchable? alphabetical
Better explanation what for is given function. Some short howtos: to use
mixer you need to call function a(), pass it's result to function b()
and you will get handle which you can pass to function c() to set volume
or d() to get current volume.

 > index?). Have you read any other API documentation that you thought was
 > good? If you can point out any examples that can be freely viewed or
 > downloaded from the Internet, that would be especially helpful.
I think Java APIs are well commented (note that they use javadoc which,
I think, is similar to doxygene). Take a look at this:
http://java.sun.com/j2se/1.4/docs/api/index.html
or this:
http://java.sun.com/j2ee/sdk_1.3/techdocs/api/index.html
or at tutorials:
http://java.sun.com/j2ee/tutorial/1_3-fcs/index.html

Also QT documentation is well written:
http://doc.trolltech.com/3.0/

Please understand me: I've got SB Live! for two days, I wanted to make
mixer for it (none of mixers I know fully support it). And I spent
almost entire day reverse-engineering alsamixer. This is simply wrong...
If I had better documentation, I'm sure I could write that mixer in two
days...

One more thing... what good is for even best library, if it's so hard to
use...

Regards
-- 
--= Michal Kochanowicz==--==--==BOFH==--==--==michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
