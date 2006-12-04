From: Shaya Potter <spotter@cs.columbia.edu>
Subject: userspace sample driver?
Date: Mon, 04 Dec 2006 18:52:57 -0500
Message-ID: <1165276377.5047.9.camel@localhost.localdomain>
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

[please cc me, as not subscribed to list]

Is there a sample, perhaps "null" user space driver somewhere that one
can use for learning about ALSA?  basically, based on getting my
bluetooth head phones working w/ my laptop I see that alsa supports user
space drivers very well.  

Basically I want to experiment w/ writing a network audio type driver
that basically plugs directly into alsa and would therefore not need any
application wrapping and would fit within a regular system perfectly,
but as I'm unsure where to start, I was hoping there was a null example
driver somewhere as that would probably make this task simple.

For further explanation, this is in relationship to our process
migration research (http://www.ncl.cs.columbia.edu/research/migrate/),
where we can move groups of processes between machines.  However, in
places where the hardware might be different, (such as video and sound)
this can prove more difficult.  For video we use thin client technology,
since the display is now totally in userspace, we can capture its state
in a machine independent manner and have the userspace viewer
application deal with the differences as its more capable of doing it.
I want to do something similar w/ sound.  At worst, I'll spend a decent
amount of deconstructing the bluetooth driver, but was hoping there was
a better way.

thanks.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
