From: fn ln <neplace1@yahoo.ca>
Subject: linux's SNDCTL_SEQ_RT_ENABLE and perl's MIDI::Music
Date: Tue, 26 Mar 2002 17:52:30 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020326225230.87515.qmail@web21309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, midi@perl.org
List-Id: alsa-devel@alsa-project.org


 Hi,

 I would like to use perl, I guess, to record what an
external device plays, and then be able to play it
back.

http://www.perl.com/CPAN-local/authors/id/S/SE/SETHJ/MIDI-Music-0.01.tar.gz

 needs SNDCTL_SEQ_RT_ENABLE so it can record MIDI
events and calcualtes the delta times itself, I guess.

 What do I need to do to make MIDI::Music work ?
Do I need to patch MIDI::Music.xs or do I need to
patch ALSA ? What would be easier ? 

searching through /usr/src/linux/alsa-driver-0.5.11
for SNDCTL_SEQ_RT_ENABLE yielded no results, neither
did
http://www.google.com/search?q=alsa+SNDCTL_SEQ_RT_ENABLE&btnG=Google+Search

   Thanks,

      John


______________________________________________________________________ 
File your taxes online! http://taxes.yahoo.ca
