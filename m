From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: Setting alsamixer settings from API
Date: Tue, 18 Feb 2003 22:08:10 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <00c801c2d79a$3a4dae20$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi,

I have just finished writing a sound capture program using ALSA 0.9.0rc7 and
Red Hat Linux 7.2.  Whilst there are no problems with the operation of the
program some users are complaining that whenever they re-boot their machines
and re-start my sound program, they have to :
1. bring up alsamixer
2. unmute everything in alsamixer
3. set the ADC capture flag on in alsamixer
4. adjust various volume settings in alsamixer.
5. Bring up the gnome audiomixer gui (the sound comes out in mono until the
audiomixer is brought up - without even changing any settings -  I don't
know what's going on there???).

It all seems a lot of hassle for the average, non-IT trained users and I do
like to keep them HAPPY.

Are there API function calls which allow altering alsamixer settings etc
from within the program code?  Any information on this (or direction to
useful documentation) would be appreciated.

Regards,

Pete




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
