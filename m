From: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Subject: Newbie help
Date: Wed, 05 May 2004 19:28:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40992430.A5495821@ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I am new to ALSA and to sound world, but my new project needs me to
start working on it. For the same, I installed ALSA on my DELL CPx
notebook, which runs linux 2.4.21 and ran Paul Davis's sample code in "A
Tutorial on Using the ALSA Audio API" for initial tests. 

The "Minimal Playback" and "Minimal Capture" programs work fine on their
own. Yet, when I put them together (it is recommended to use interrupt
driven approach, but this was just a trial, so I used the non-interrupt
version) to implement the following functionality :

- Capture for about 30 seconds and store in a buffer
- Read from the buffer and playback

.. all I listen is hissing sound. The code seems to work because I can
listen to the modulations of some sort ... but normal voice is converted
to incoherent (hissing) noise.

Can someone suggest what might be going wrong, or do I need to tune some
other parameters ? Any help is appreciated.

Thanks in advance
-Manu


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
