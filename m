From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: new alsa docs.
Date: Tue, 6 Aug 2002 10:47:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020806104713.2f0ce97e.sjt@star.sr.bham.ac.uk>
References: <20020805232519.H683@cebreiro.nc.rr.com>
	<3D4F9602.7030804@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D4F9602.7030804@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 06 Aug 2002 18:25:22 +0900
PS> > On Tue, 06 Aug 2002, Patrick Shirkey wrote:
PS> > 
PS> > 
PS> >>I'm have soreted out all the final bugs I had with the new docs
PS> >setup. >Added the midi stuff and I feel that the site is ready for
PS> >prime time.>
PS> >>You can see it here:
PS> >>
PS> >>http://www.alsa-project.org/alsa-doc/

Just a couple of minor queries.
1) In the "Setting up modprobe and kmod support" you do not include the
line:
        alias sound-service-0-8 snd-seq-oss
(at least for the two cards relevant to me [trident and ice1712] but you
do
include it in the explanation. Which is recommended?

2) For debian it is possible to add a new file "alsasound" (say) to
/etc/modutils/ and update-modules will find it (I'm not sure if this is
recommended practice or not, I'm still very much a beginner with
debian).

Overall though, a nice piece of work, that should be very useful in
making ALSA more accessible to new users.

James


-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
