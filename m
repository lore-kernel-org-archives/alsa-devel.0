From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: AC97 codec odd behaviour (STAC9708/11) / Aureal Card IS SUPPORTED!
Date: 12 Jun 2003 17:51:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055454710.889.30.camel@localhost>
Reply-To: mjander@mat.utfsm.cl
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I'm facing some odd things with a Aureal MX300 with a
AC97 codec. For some reason the AC97 interface doesnt
set the EAPD (external amp enable) bit correctly, and i have 
to set it explicitly after calling the ac97  mixer initializer.

Maybe, that the AC97 codec write function actually implemented
for the Aureal cards "misses" some writes, but i just want to be sure
if this bit works for other cards with a STAC9708/11 or similar
codec that need this bit by default, or if i really need to set it
myself ??

I would like to ask once again please to update the ALSA Soundcard
matrix that there is a ALSA driver for all the Aureal cards.
The driver very soon to be posted here can be found at:
http://savannah.nongnu.org/projects/openvortex
If you don't want to be anoyed with this again, please update that
compatibility matrix ;)

Thank you very much

Manuel Jander




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
