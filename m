From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: arecord -D cards.pcm.iec958
Date: Tue, 28 May 2002 19:22:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020528192245.7093ae73.Lars.Heineken@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi !

I finaly managed to capture sound from spdif-in using my Terratec EWX24/96 (ICE1712)

Doing it this way:  arecord -D cards.pcm.iec958 -c 12 -r 44100 -f S32_LE test.wav  
// all other ways failed, as you can only record from spdif when using S32_LE and 12 channels.

My problem now: This is a twelve track, 44 Hz 32bit Little Endian Wave ?
                I have no idea what to do next.

I would like to record a single stereo signal from spdif-in. How can I accomplish that ?

Regards,

Lars.

PS: I searched the while for hours but got no closer than this. Recording from -D 0 works fine, but records only from analog-in, even when the sliders (AND captures) in alsamixer are set for recording spdif ONLY. (?)

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
