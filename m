From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: rc4
Date: Wed, 23 Oct 2002 12:24:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023122441.4121e36f.sjt@star.sr.bham.ac.uk>
References: <Pine.LNX.4.21.0210231231440.321-100000@mailserver.intern.bfad.de>
	<3DB67F3B.4090407@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DB67F3B.4090407@boosthardware.com>
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

On Wed, 23 Oct 2002 19:51:39 +0900
Patrick Shirkey <pshirkey@boosthardware.com> wrote:

PS> > 
PS> > What is the "true one" method of compling ALSA CVS?
PS> > 
PS> 
PS> It's in the online docs but for your convienience
PS> 
PS> ./cvscompile --with-cards=snd-xxx;make;make install
PS> 
PS> where snd-xxx is the name of the module for your card.
PS> 

nearly:
./cvscompile --with-cards=xxx;make;make install
where snd-xxx is the name of the module for your card.

James
-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
