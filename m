From: John Anderson <panic-alsa@semiosix.com>
Subject: Re: Problems with USB driver and Swissonic USB Studio
Date: 19 Jul 2002 12:54:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027076078.1745.20.camel@groovious>
References: <1027074021.1203.15.camel@groovious>
	<s5hofd4qad8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hofd4qad8.wl@alsa2.suse.de>
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

On Fri, 2002-07-19 at 12:29, Takashi Iwai wrote:
> At 19 Jul 2002 12:20:21 +0200, John Anderson wrote:
> > 
> > I'm using a Swissonic USB Studio.
> > 
> > With an older CVS version (from around 29th June), playback and capture
> > were pretty much OK, except for a ticking (the repetitive peaks issue?)
> > and some noise. Using the latest CVS version:
> > 
> > aplay -D studio /mnt/spare/music/test.wav 
> > Playing WAVE '/mnt/spare/music/test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> > aplay: set_params:737: Broken configuration for this PCM: no configurations available
> 
> perhaps you'll need to update also alsa-lib from cvs.

Did that already.

> applications are not necessarily rebuilt, though.

Did that too.

Anything else obvious that I might have missed?

bye
John

-- 

Freelance DataDreamer http://www.semiosix.com
Good Things require a precise lack of control



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
