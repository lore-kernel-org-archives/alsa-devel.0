From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MAYA44 USB audio device doesn't work with   1.0.4.
Date: Fri, 28 May 2004 17:43:35 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405281740090.24462-100000@studcom.urz.uni-halle.de>
References: <6.0.0.22.2.20040528082652.01f45930@mail.audioslack.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <6.0.0.22.2.20040528082652.01f45930@mail.audioslack.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luke Yelavich <luke@audioslack.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luke Yelavich wrote:
> usbcore: registered new driver snd-usb-audio

No other message?  There should be at least an error message when the
driver fails to initialize.  Please try to compile the kernel with
ALSA's "Debug detection" enabled, or --with-debug=detect when
configuring the package.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
