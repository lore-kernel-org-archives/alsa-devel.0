From: gtrfree <gtrfree@supereva.it>
Subject: Re: [PATCH] us428control support for mixxx
Date: 5 Oct 2006 00:39:31 -0000
Message-ID: <20061005003931.28475.qmail@mail.supereva.it>
Reply-To: gtrfree@supereva.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


GESTES Cedric wrote:

> This patch allow to change the midi mapping of the us428, the new 

> mapping is used with mixxx.

> To use the new mapping:

> ../us428control -m mixxx

> 

> I have splitted the class who does the mapping, it is more easy to add 

> new mapping now.

> Furthermore I need to find a way to communicate with the program, to 

> change mapping on the fly.

> Cause currently us428control is launched from udev, and to change the 

> mapping you should kill the previous us428control and launch another.

> 

> I already posted an older version on the bug tracker, but I had'nt have 

> response for it. (with different addrese cause gmail bounce my mail to 

> sf.net)

> thanks.

> 



Hi, I'm not a developer, just an user... and I'm new with Linux so don't count too much my opinion. ;-)



I'm running OpenSuSE 10.1 - 32bits and seems that the us428control in 'mixxx mode' doesn't work. It starts good but only the lights in the eq sections lit, nothing more.

When I run Mixxx in Jack-mode there isn't 'something' to connect to the Tascam control into the QJackctl midi-window (I mean some 'mixxx-control input').

If I start Mixxx in standard mode, there isn't the  Tascam to choose in the midi configuration. Anyway I tried every option with no results (Play, stop and faders don't work with Mixxx).



Sorry to carry bad news but I repeat: I'm very new with Linux (still fighting with 3-4 us428 inputs!) and I hope it's just a problem of mine, not Mixxx or your patch.



Cheers.





--

---------------------------------------------------------------
Mettiti al centro del mondo! Crea il tuo blog e condividi con
i tuoi amici idee, immagini e video, da web e da cellulare!
http://beta.dada.net/
---------------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
