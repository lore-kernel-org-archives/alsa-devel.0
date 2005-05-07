From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Audigy 2 P16V HD capture status.
Date: Sat, 07 May 2005 17:33:25 +0100
Message-ID: <427CEDD5.1050000@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am currently working on getting capture working on the P16V device on
the Audigy 2 Sound card.
The capture is 32bits, but the 16bit Audio data is padded with zeros.

If one wishes to do capture, use the table below to select the input you
want. I have only tried these 3 different inputs so far. If someone
finds any others, just tell me.

Input           HD Capture Channel      HD Capture Source
CD-spdif        0                       SPDIF
Optical-spdif   1                       SPDIF
MIC             0                       I2S

One can select a number of different capture rates 44.1, 48, 96 and 192.
Apparently 44.1khz should not work for the Analog to digital converters
so some distortion might be observed if one selects that option.

The P16V or CA0151 capture device is "hw:0,4"

Use the latest alsa-driver cvs in order to use the latest features.

James



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
