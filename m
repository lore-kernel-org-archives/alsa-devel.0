From: Florian Bomers <Florian.Bomers@sun.com>
Subject: snd_get_version() ?
Date: Mon, 04 Nov 2002 11:32:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC6CB54.E27A381E@sun.com>
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

I need to retrieve the installed ALSA version from within my program at run
time, and I am missing functions like 

  void snd_get_str_version(char* buffer, int len);
  void snd_get_num_version(int* major, int* minor, int* subminor, int* suffix);

Currently I parse /proc/asound/version which is ugly and may break in future if
that string's format is modified.

Thanks,
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
