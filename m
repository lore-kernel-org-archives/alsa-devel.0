From: Damien Sandras <dsandras@seconix.com>
Subject: Alsa 0.9.0 RC5 + RH8 + GnomeMeeting
Date: 07 Nov 2002 13:47:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036673221.17759.28.camel@heraclite>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I subscribed to this mailing list, because GnomeMeeting users have
reported a problem using ALSA 0.9.0RC5 together with GnomeMeeting and
RedHat 8.0.

Actually, the problem is simple to explain, hard to fix, at least for
me. Several users complained that using GnomeMeeting was freezing their
machine. This corresponds to a driver bug, somewhere, as "user-space"
programs can't crash a machine directly. The only particularity of
GnomeMeeting is that it is reading and writing to the device at the same
time.

Only RedHat 8.0 users seem to be affected. Some of the users with
problems installed ALSA 0.9.0RC3 and the problems disappeared.

Are there any known problems, or changes, in ALSA 0.9.0RC5 that could
cause problems on RedHat when used with GnomeMeeting? Can any of you,
with a RedHat, do some tests? What should I do?

Thanks,
-- 
 _	Damien Sandras
(o-	GnomeMeeting: http://www.gnomemeeting.org/
//\	FOSDEM 2003:  http://www.fosdem.org
v_/_	
	H.323 phone:  callto://ils.seconix.com/dsandras@seconix.com




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
