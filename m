From: =?iso-8859-1?q?Sylvain=20Petreolle?= <spetreolle@yahoo.fr>
Subject: Re: Current CVS doesnt compile on latest RedHat
Date: Sat, 8 Nov 2003 13:09:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031108120909.54258.qmail@web10103.mail.yahoo.com>
References: <Pine.HPX.4.33n.0311071239240.21540-100000@studcom.urz.uni-halle.de>
Reply-To: spetreolle@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0311071239240.21540-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Many thanks,  this works.

> This is an incompatibility between the official Linux kernel and the
> -ac patch.  Apparently, RedHat now includes this patch.
> 
> Change the offending line in serialmidi.c to
> 
> 	if (atomic_read(&tty->count) > 1) {


=====
Sylvain Petreolle (spetreolle_at_users_dot_sourceforge_dot_net)
 ICQ #170597259
Say NO to software patents
Dites NON aux brevets logiciels

"What if tomorrow the War could be over ?" Morpheus, in "Reloaded".

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
