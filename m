From: Benny Sjostrand <gorm@cucumelo.org>
Subject: SPDIF output finally working properly with CS4630
Date: Tue, 23 Jul 2002 22:33:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3DBDA2.10602@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

After a lot fustrated hacking nights and days, finally (at least) I 
manage to get a properly sound out from SPDIF interface on my Hercules 
Game Theater XP card, at least "so far as i can hear". The sound is no 
longer distorcionated and SPDIF is now integrated with the ALSA mixer 
(muted by default).

About other missing basic feutures, SPDIF input, 4 channels, multi PCM 
etc., well, I'm working on that, we see what I can do, at least there is 
a hope ...

The code is still very dirty, noisy, well, I know that it needs a lot of 
cleanup.

My new current snapshots:
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020723.tar.gz
http://www.cucumelo.org/~gorm/ospparser.tar.gz

Please, test it and give some feedback, maybe there are things that was 
working before
and are now broken., etc ...

but,
NOTE the code is very EXPERIMENTAL and may be very UNSTABLE for the moment.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
