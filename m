From: Friedrich.Ewaldt@gmx.de
Subject: copy plugin, connecting output-input (virtual soundcard with connected out->in)
Date: Tue, 13 Aug 2002 14:16:40 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <13809.1029241000@www8.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Patrick,

> There is a plugin called copy in the pcm plugins docs. Have a read.
> 
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins

I did a lot of tests and experiments with the copy plugin (everything that
came into my mind) but had no success in getting sound from an ALSA output
device to an input device. Besides, I have some problems using the copy plugin
with some applications (e.g. brutefir). I get a "file descriptor in bad state"
error when brutefir calls snd_pcm_start. (you'll find further description od
this problem at
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg04080.html
)
Do you know what I should do to get this running?

One question to the ALS experts: 
Is there (or would it be a big deal to write one) some kind of virtual
soundcard device I could use? I'm thinking of some virtual "card" I could write
audio data to (say, to an ALSA "output device" of this virtual card) and
capture this data by using the "input device" of this virtual card. 

*From an application point of view, this should look like a real soundcard
with a cable connecting the output(s) to the input(s).*

(The virtual card would indicate always free buffers to the application
using it and would just move 2 pointers to get the input and output streams
synchronized. Or something similar -- or something completely different. Sorry, I
don't know ;-) )

Or -- is there any other solution to simulate a card with connected
out-/inputs?
Something like a software version of a hardware audio patch panel would be
quite interesting for many others, I think.

Many thanks in advace for any help,
fritz_e

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
