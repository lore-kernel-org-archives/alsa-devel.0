From: Marcel Holtmann <marcel@holtmann.org>
Subject: Support for the Bluetooth subband codec (SBC)
Date: Mon, 08 Nov 2004 02:45:54 +0100
Message-ID: <1099878354.6896.80.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi guys,

besides the Bluetooth headset/handsfree support there is another type of
audio support. It is the high quality audio (A2DP) for headphones and so
on. To include a native support for these devices with every Bluetooth
adapter (for example the ones built into your notebook) it is necessary
to support the subband codec (SBC) from Philips. The codec description
is in the Advanced Audio Distribution Profile (A2DP).

I am not an audio expert and far away from doing any codec specific
things, but from my understanding the ALSA kernel part should be
extended with the SBC type for PCM devices and the library should know
how to convert any PCM data into the SBC format so we can use it inside
the kernel in a A2DP driver.

Any comments?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
