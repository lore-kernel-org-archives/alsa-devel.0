From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: intel8x0.c rev 1.87 kills audio on resume
Date: Mon, 10 Nov 2003 16:08:18 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031111000818.46871.qmail@web21004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Apologies for posting twice: I forgot to put a meaningful subject on the first posting.



Hi

As was reported on this list ealier, on a Dell I8200 with inte8x0, 
sound dies after
suspend/resume, and this is only repaired by removing and re-installing 
the drivers.

This is tue to the patch to intel8x0.c (1.86->1.87, 2003-07-30) which 
actually does good things:
i.e., instead of waiting to all possible codecs, it only waits for 
those present.  Unfortunately,
this was a bug-covering-a-bug: since it no longer waits for an 
inexistent codec, something goes
wrong.  Adding a hard-coded wait of a HZ/4 (as was before) solves the 
problem.  So there's
something else there that's not waited for or what?

Now the only patch I have the knowledge to create is just this, i.e., a 
hard-coded additional
waiting time (well 1/4 of a sec on resume is not that an awful thing 
anyways...).  Please, those
of you who actually understand what is going on, can you make a more 
constructive suggestion?

Thanks,
Itay



__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
