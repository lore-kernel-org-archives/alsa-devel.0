From: Andrew Gaydenko <a@gaydenko.com>
Subject: SPDIF-out bit depth
Date: Tue, 22 Nov 2005 02:17:25 +0300
Message-ID: <200511220217.25747@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
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

Hi!

Is there a way to determine SPDIF-out bit depth during a playing back?

I have tried to play a 96KHz/24bit file: JACK server was started with 96KHz/32bit,
aqualung player was used for playing back. 'iecset -x' dump out shows byte 1 of
channel status as '0x00'. In accordance with AES3-2003 document, it means "no more
rather 20bit". I'd want to have and see 24bit depth :-)

The ICE1724 driver is in use.

What have I missed?

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
