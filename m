From: "Mirabella, Mathew J" <Mathew.Mirabella@team.telstra.com>
Subject: RE: Audigy under Redhat8:  sound... but some issues.
Date: Thu, 27 Mar 2003 08:39:49 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <73388857A695D31197EF00508B08F2980A00EE9D@ntmsg0131.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "J. Scott Amort" <jsamort@telus.net>, alsa-devel list <alsa-devel@lists.sourceforge.net>, alsa-user list <alsa-user@lists.sourceforge.net>, sound-list list <sound-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

ok i did all that and have some sucsess... but still probs.
what i did is at the end of this email... but what i found is below..

i am using the 3rd port on the back of the audigy 2 which is meant to be =
front left and right when you have a 2 speaker set up like i have.  but =
no sound came from that.  i plugged the speakers into the digital out =
port and got the sound with a lot of static etc (which is meant to =
happen when you dont have digital speakers) so this means it is kind of =
working.  i also found that plugging my speakers into the rear left and =
right port or even the subwoofer port, i got clean sound.  so it kind of =
works.

but... the sound keeps giving little popping sounds and the bad thing is =
it just stops after a few seconds... then you have to re start the =
application you were using to play sounds.  this was consistent =
behaviour... and as i said, sound out of the subwoofer or rear port =
only.

Are there configuration things i have to fix?  how can i fix this =
popping and stopping issue.
and... how can i switch cards to card 1 (yamaha) when i want to.

Thanks for your help..=20


what i actually did....
i got the driver, libs utils and kernel from cvs all into the same dir =
as dirs for each.  then i did the ./compile for the drivers, then make =
install for the drivers and then repeated for libs and then utils (don't =
know what i was meant to do with the alsa-kernel though).
i also made sure that /usr/src was set up with two sym links, one called =
linux-2.4 and one just called linux, both pointing to =
/usr/src/linux-2.4.18-14.  as you can tell, that is the kernel i am =
using (out of the red hat cds).
i did not set up any kernel .config file in the /lib/modules/2.4.18-14 =
which was nesesary for installing the cvs of emu10k1 that i mentioned =
earlier.  but i imagine this would not be nesesary for the alsa stuff =
anyway.??
by the way... i did all of this stuff with ./cvscompile and make install =
as root.  hope this is ok??  it all seemed to work.  the drivers took =
the longest to compile.
then i changed the modules.conf with the audigy stuff for card 0 and the =
yamaha stuff for card 1.  then unmuted.  no sound.
then i rebooted, and tried to run stuff like alsamixer and alsacntl but =
realised i had not done the ./snddevices step so i did that and all =
started to work ok... the mixerat least.
i unmuted things in the alsamixer and stored them using alsacntl.
but still no sound.
that is when i tried the digital and rear / subwoofer ports and got some =
sound.




-----Original Message-----
From: J. Scott Amort [mailto:jsamort@telus.net]
Sent: Thursday, 27 March 2003 4:37 AM
To: Mirabella, Mathew J
Subject: RE: Audigy under Redhat8: some questions.


On Tue, 2003-03-25 at 21:40, Mirabella, Mathew J wrote:
> thanks for that help.
> i will try that.
> however, since i have already downloaded the whole cvs cvsroot dir, =
can i do something simple with that and configure and compile the lot in =
one go?
> and what is the difference between the stuff in cvsroot and cvsexport?

I must admit that I really don't know, I have never taken the cvs that
way.  I think you would be better off re-downloading it as I outlined.

Scott

=09


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
