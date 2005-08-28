From: Nicolas Boullis <nboullis@debian.org>
Subject: writing an alsa driver for an MPEG decoder chip
Date: Sun, 28 Aug 2005 16:46:42 +0200
Message-ID: <20050828144637.GA4452@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am a member of the dxr3 project, that tries to write a linux driver 
for the MPEG decoder em8300 chip that is mainly used in Sigma Design's 
Hollywood+ and Creative Labs DXR3 boards.
This chip handles hardware decoding of MPEG video, but is also able do 
perform some limited audio playback.
We corrently have a working OSS interface for the audio playbak, that 
I'd like to replace with an ALSA one.
I tried to write one, using Takashi Iwai's excellent "Writing an ALSA 
Driver" guide. Unfortunately, the driver that I managed to write seems 
to work fine when playing sound with xmms, but all other apps that I 
tried failed to get any sound.

Anyone can help me figure out whet I missed?
You can grab the relevant file at
http://dxr3.sourceforge.net/download/em8300_alsa.c

Thanks in advance,

Nicolas Boullis


PS: I am not subscribed to this list, please CC replies to me.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
