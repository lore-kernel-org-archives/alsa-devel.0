From: Florian Bomers <Florian.Bomers@sun.com>
Subject: save to use new API ?
Date: Mon, 04 Nov 2002 11:38:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC6CCC1.BB5876B8@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

if I released a program now in binary form, is it safer to use the new function
prototypes of alsa-lib by defining ALSA_PCM_NEW_HW_PARAMS_API or better use the
old, deprecated ones ?

My program compiles with or without, and I'd prefer to use the new API, but I
noticed that when I compile against rc5, it doesn't even run with rc4, so I fear
that my binary compiled against rc5 won't run with later versions of ALSA lib.

Thanks for letting me know.
Florian

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
