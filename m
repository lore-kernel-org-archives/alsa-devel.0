From: Paul Davis <pbd@op.net>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 10:17:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206241415.g5OEFkf09744@post2.fast.net>
References: <s5hptyg96f0.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 24 Jun 2002 15:01:55 +0200."
             <s5hptyg96f0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Joshua Haberman <joshua@haberman.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>the names above are not defined on all cards (except for default).
>i think we need a kind of config database for each card.
>this is useful not only for pcm but also for parsing the mixer
>structure.

i think this is the wrong solution. i believe the correct solution is
to provide a **simple** way to get every defined PCM device name.

a config database for cards doesn't cover multi devices, or channel
subsets, or share devices, etc. etc.

>> in addition this also doesn't deal with the issue of users with more
>> than one soundcard installed.
>
>this is not difficult, since the card number can be passed via
>CARD argument.

thats not my point. an application that wants to provide a way to
select the audio input and output needs to be able to know which all
the PCM devices that are defined. the whole beauty of the naming
system is that its based around physical cards, but that also means
that card numbers are not the right way to start thinking about this.

--p



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
