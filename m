From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: RE:  Application using ALSA-driver es-1968 for Maestro-2e
Date: Thu, 20 Jun 2002 10:42:37 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206201041370.17027-100000@cmn24.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


The es1968 driver is broken for capture.  I reported this last Fall
but no one ever fixed it.  You can try using arecord and it doesn't
work either, so there's no need to send your own code snippets.

I too had success with the es1968 driver in version 0.5, but it broke 
with the 0.9 versions.

The OSS-free driver does work with the Maestro-2e, so that could be a 
starting point for a fix.  I haven't been able to use ALSA on my 
laptop because of this.

--gary scavone





-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
