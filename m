From: Ciaccia <ciacciax@yahoo.com>
Subject: Static build of alsa-lib
Date: Fri, 16 Mar 2007 06:17:00 -0700 (PDT)
Message-ID: <217312.5363.qm@web31004.mail.mud.yahoo.com>
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

Hi there,
I would like to compile an alsa application for an
embedded system with no shared-libraries support. My
application just needs PCM, with no plug-ins, no mixer
and no midi and the application should be a standalone
executable with no external dependencies, otherwise it
will not work.

I tried to compile alsa-lib with static support, but
without luck (-ldl is always needed in the gcc line
and gcc always prints some weird warnings). Since I
don't need external plugins nor ladspa, I think there
should be a way to compile an application in a 100%
static manner, but I still have to figure out how.

I also found this thread with a similar problem with
uClinux
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg18253.html
but at the end I did not understand how/if the problem
was solved.

Do you think it should be possible to compile alsa-lib
with no dependencies on dl? How?

Otherwise, would it be possible to write an alsa
application that does not rely on alsa-lib (i.e.,
by using the alsa kernel APIs directly)? Has someone
already tried it? Some hints?

Every hint is extremely welcome

Thanks a lot
Best regards
Andrea


 
____________________________________________________________________________________
Food fight? Enjoy some healthy debate 
in the Yahoo! Answers Food & Drink Q&A.
http://answers.yahoo.com/dir/?link=list&sid=396545367

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
