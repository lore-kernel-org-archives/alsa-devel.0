From: Alexander Broekhuis <a.broekhuis@admiraalkruys.nl>
Subject: emu10k1 pcm settings
Date: Sun, 10 Oct 2004 11:32:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1097400720.2916.2.camel@akhorahil.internal.admiraalkruys.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I posted the following message to the user list, but didn't get a reply
yet. Perhaps someone on this list knows more about it.

-----------------------------------------------------------------

Hi,

I have a soundblaster emu10k1 soundcard that shows up as TriTech TR28602
in alsamixer. If I play a mp3 or movie using xmms, bmp or mplayer (and
perhaps more programs) there are about 10 emu10k1 pcm mixers in
alsamixer. If there is nothing playing they aren't there. 

That is my first question: why do they only show up if there is
something playing?

Second question: If I change song or movie the emu10k1 pcm settings are
reset, and the sound sounds bad because of those settings.

If I play several files with mplayer it shows this between the files:
alsa-uninit: pcm closed

It seems pcm is closed and reopened between files, could that be the
reason for the pcm resets?

The following german post talks about the same problem and has 2
screenshots:

http://www.linuxforen.de/forums/archive/index.php/t-116650.html

Screenshots:
http://free.pages.at/puempel/vorher.png //This shows the custom
settings.
http://free.pages.at/puempel/nacher.png //This shows the settings after
changing files. (I didn't make these shots, but they show exactly the
same as it does for me)

Hope someone can help me with this problem.

TiA,

Alexander Broekhuis



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
