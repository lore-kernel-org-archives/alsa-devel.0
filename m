From: Steve Smith <ssmith@vislab.usyd.edu.au>
Subject: Identifying the PCM/Mic mixer
Date: 10 Jul 2003 16:13:17 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057817597.832.10.camel@piccinini.vislab.usyd.edu.au>
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

Hi,

I'm writing an Alsa driver for an application that needs both playback
and capture, and needs to control the mixer settings.  I'm using the
plughw: interface for both play and capture so I assume that I need to
control the mixer volume for the PCM interface.  Is this correct, and
how do I identify the PCM mixer element?  I could just compare the elem
name, but this seems like a bit of a hack.

Thanks,
Steve



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
