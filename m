From: Bob Ham <node@users.sourceforge.net>
Subject: Re: [ardour-dev] Re: guitar + sblive + ardour + ladspa
	effects
Date: 29 Jul 2002 22:09:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027976945.10076.95.camel@insanity>
References: <1027973318.10978.62.camel@insanity>
	<3D45A636.4030000@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D45A636.4030000@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>, Ardour Devel Mailing List <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-07-29 at 21:31, Patrick Shirkey wrote:

> Have a read of the arecord quicktoot
> 
> http://www.boosthardware.com/LAU/quicktoots
> 
> That will give you some info about using alsamixer correctly.

Getting ardour to be able to record/modify the incoming sound isn't the
issue.  It's getting ardour to do that without it going through the
speakers beforehand.  I don't want to hear any sound if I put the mixer
slider down to nothing in ardour.  At the moment, I hear the original,
clean guitar signal.  I assume the line input is getting routed to both
jack's alsa_pcm inputs and the soundcard's amp.  I want it only to go to
jack, and then the ladspaified signal to the amp afterwards.

Bob

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
