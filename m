From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Switching sound cards on the fly
Date: Thu, 15 Mar 2007 21:29:32 -0400
Message-ID: <75b66ecd0703151829t1513551dkc94b3d4025cee98a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: markknecht@gmail.com
List-Id: alsa-devel@alsa-project.org

How difficult would it be to add to alsa-lib a mechanism where
applications can register an "ALSA config changed" callback that would
be invoked when an app like gnome-sound-properties changes the default
sound device by updating .asoundrc?  Changes to ALSA config files
could be detected via inotify.

I think this could allow for relatively seamless switching of the
audio output device.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
