From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: libasound and libpthread
Date: Mon, 29 Jul 2002 15:40:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4545CB.579EA77C@libero.it>
References: <E17Z9Fw-00028n-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Thomas Roeder <rdr@emt.iis.fhg.de>
Cc: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >I am working with Alsa 0.9.0beta12 version and I am also using posix
> >threads (libpthread) in my project. In the release version of the
> >program I link both libraries (libpthread, libasound) dynamically and
> >everything works well. In the debug version however, I have to do static
> >linking of the libpthread for proper debugging.
> 
> why? i use pthreads a great deal, and i have never had to do this.
> 
> and no, libasound does not use pthreads or any other form of threads.

Thomas, you should know to not rely too strong to Paul's words.

He own a big heart, but unfortunately a big mouth too, that he's often
unable to keep under control ;-)

Some portions of libasound *do* use pthreads.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
