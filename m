From: Matthias Saou <matthias@rpmforge.net>
Subject: Release method?
Date: Wed, 23 Oct 2002 17:05:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023170553.3511839f.matthias@rpmforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Seeing how the 0.9.0rc4 release went, I was wondering if the ALSA people
wouldn't mind re-thinking the release method?
Apparently, Jaroslav and Takashi are the ones doing most, so this is
especially targetted to them.

One suggestion :

- Would it be possible to release some tarballs, supposedly identical to
the final ones but a few hours/days before public release and announce?
This is because :
  1) Many people (including me) would more easily find time to test these
     then to test the current CVS tree
  2) Some problems may show up not in the actual source, but in the way
     it is packaged (like the automake links)

One question :

- Would it be possible to have a different versioning scheme? For
packagers, and I am one, versions like "0.9.0rc4" < "0.9.0" are horrible
since they mean that some ugly hacking is needed (namely Epoch: tags for
rpm packages). It would have been so much easier if the versions had been
0.8.1, 0.8.2 etc. Especially as nearly everyone uses 0.9.0x anyway, and
that 0.5.0 is unmaintained...

Cheers,
Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.06 0.07 0.09


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
