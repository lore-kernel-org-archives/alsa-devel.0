From: "Ivica Bukvic" <ico@fuse.net>
Subject: Question regarding current ESS Maestro 3M soundcard support
Date: Mon, 11 Feb 2002 21:28:53 -0500
Message-ID: <a49vak$aq1$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all!

I have an Dell Inspiron 8K and my question is whether the current
Maestro M3 chip is fully supported or does it currently only furnish
SB16 compatibility mode (I might be talking nonsense here, but this is
what I heard a while ago, or something like it and my understanding is
that the current driver support is only partial due to incomplete
disclosure of the hw specs by the ESS, again, please correct me if I am
wrong). Basically, from my understanding it seems that the M3 soundcard
is being classified as a "sound accelerator" (whatever that means), and
as such I would expect it to be capable of mixing audio streams in
hardware (just as emu10k1 chip does, even though emu10k1 is much more
powerful). So far, I was only able to get one stream out of the card in
the latest ALSA driver, while I got 2 streams with the OSS-Free drivers
(third stream would garble the two existing streams and return an i/o
error).

So, is this the default behavior?

I would assume that most of the modern-day cards should be capable of
down-mixing at least 16 or 32 streams of sound, since that is what they
are usually capable of reproducing in Windows at any given time (unless
in Windows the down-mixing is done in software, which is certainly a
possibility and in many cases a known fact).

So, my questions are:

Is this a hardware limitation?

or

Is this current driver's limitation?

If the second is the case, then what are the chances of improving this
issue in the nearby future?

Finally, what are the chances of getting the ESS to talk and give us the
exact specs for this soundcard so that the driver can be finished?

Any help would be greatly appreciated!

Ivica Ico Bukvic, composer, multimedia sculptor, 
programmer, webmaster & computer consultant 
http://meowing.ccm.uc.edu/~ico/ 
============================
"To be is to do"   - Socrates
"To do is to be"   - Sartre
"Do be do be do"   - Sinatra
"I am"             - God



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
