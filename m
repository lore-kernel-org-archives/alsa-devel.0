From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Subject: mixer element types
Date: Sat, 08 May 2004 20:32:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084041123.31499.16.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on properifying the ALSA support in GNOME Volume Control.
When opening a sound mixer, I noticed that several elements will be both
a capture and a playback element. Also, there is separate functions for
setting the playback and the capture volume. How are those functions of
the element related? If I set the playback volume, does this affect the
capture volume on a hardware level? And what is the playback or capture
part of this element supposed to visualize/abstractize?

Also, I see several non-volume elements (switches? Things such as
External Amplifier Power Down or 3D - switch). What are those? What do
they do, what's their function, what do they visualize/abstractize on
the hardware level?

I'm asking all this to get an idea of how to picture those in GNOME
Volume Control (for the first question: each function of the element as
a separate track? Or all functions together as one track?; for the
second question: as a checkbox? something else? omit completely?).

Ronald



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
