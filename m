From: =?ISO-8859-15?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: PLEASE improve the ALSA documentation!
Date: Sat, 16 Dec 2006 20:55:51 +0100
Message-ID: <45844F47.6070803@ingomueller.net>
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

PLEASE improve the ALSA documentation!

To many users (myself included), this is the most important thing of any
software application!

Last week, I spent two and a half days to configure Alsa, which I'd now
be capable to do in less than 30 minutes and anyone with a little
experience with Linux should be able to do in less than one hour. The
problem isn't (like I thought first), that Alsa is not capable of doing
the things I wanted to, or at least not in a clean way. The truth is,
I'm really impressed by all that can be done and how simple it in fact
is. The real problem is, that nobody tells you how to do it!

In order to change that, I'll try to describe precisely what problems I
had and - more important - how I think they could have been avoided:

1) When I started to get my sound to work, I didn't know a lot about
Alsa yet. But I stumbled upon your website quite early. Unfortunately,
it was almost completely useless for me at the beginning. I was missing
an explanation of the very basics. "Efficient support", "modularized",
"thread-safe design" mean nothing to an unexperienced user like me. What
would have helped might have been: "Alsa is a piece of software that
connects applications playing sound to the hardware sound cards by
providing them a universal interface. It includes the drivers for almost
every sound card available and is compatible with most applications,
even those using Alsa's predecessor OSS." If I had known that, I
would've been sure I was looking for a solution in the right place. But
this simple explanation was just missing (or hidden very well).

2) The separation of the site into users, developers and hardware
manufacturers makes a lot of sense. What I found in the user section was
not always helpful, though. For example, I think that "Background info"
is not the first thing a new user is interested in. The "Alsa soundcard
matrix" could be improved, too. In my opinion, the most crucial thing is
missing: "This is a list of supported sound cards. It shows which kernel
module has to be used for your hardware." The ALSA wiki is quite ok, but
the information is distributed in many subcategries. Users are missing
an introduction telling them: They have to install Alsa first. Then
configure Alsa. Then configure the applications. They need to know that
their distribution most likely did the first thing, and probably the
second, too. How we can check whether those things have been already
done? What possibilities do we have for the configuration and how and
why do we have to configure applications. That introduction should give
users a good overview about the problematic and lead them to places
where the different steps are explained in detail.

3) The problem I had to deal with the most: the .asoundrc file. I did
see the available documentation of that file on alsa-projects.org, but
only because I was lucky enough to find it on google instead of it being
linked to on the Alsa home page like I think I should be. Having found
that page, it was still difficult to understand the purpose of that
file. What would have helped would have been a brief overview of what
I'm able to do with that file, an explanation of the purpose and some
definitions or helpful tips. For example: "In the .asoundrc file, you
define virtual interfaces that applications can connect to. Every
interface modifies the sound stream in some way and then passes it on to
its slave, either another virtual interface or an hardware sound card."

4) I admit that most of the necessary information is somewhere out
there. Otherwise my soundcard would still not work at all, right?  :-)
The problem is that it is splattered all over the internet and consist
mostly of examples. Therefore, a user who is new to Alsa has to search
endlessly end then analyse the examples, understanding only bits of each
of them, "reverse engineering" those examples, and then try and solve
his own problems. I think that reverse engineering is something that
shouldn't need to be done with open source software. In my vision of a
good documented project, a new user would find the project's homepage on
google (maybe indirectly), understand his problem with the help of the
documentation and hopefully also find a standard solution there. If not,
he might find a similar problem being discussed in the included forum,
just like everything else concerning the project (instead of in many
different places), or at least be able to ask for help there. He would
not need to leave the projects page, unless he gets general or
distribution specific problems (for example, if he doesn't know how to
compile the kernel).

All that leads to one conlcusion: The documentation of Alsa has to be
improved and maybe even redone! And it has to be on the offical site of
the project and (at least partially) by those who know what they are
talking about. But (and this is the tricky part) it should be
understandable by most people who have some experience with Linux. I am
willing to help with making it understandable for the users, but I
wouldn't really know where to start, if I was to write documentation
from scratch. English is not my first language, so I would need some
help with that too.

Please show me that you, the creators and developpers of Alsa, feel the
need of improvement of the documentation of your project, in order to
make it usuable for everyone, not limiting it to an elitist group of
specialists, and support (activly as good as you can) the work on the
documentation done by users who want to help although they might not be
Alsa experts.
If I get enough support on this part of the Alsa project, if my work is
welcome and completed (reviewed, corrected...) by Alsa developers, I am
willing to spend a quite big amount of time implementing my suggestions.

Thanks in advance and greets, Ingo



PS: I just read about a conference where audio on Linux was a main
subject. It seems that not only users have problems on that topic.
"Audio on Linux sucks. Developers don't know which interface to use."
(http://developer.osdl.org/dev/desktop_architects/index.php/Desktop_Architects_Meeting-39)
That's nothing I can do about at all and it may even not concern Alsa.
But it shows that documentation is something that has to be worked on!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
