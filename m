From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Frequency Problems with 0d8c:0201 and snd-usb-audio
Date: Thu, 16 Nov 2006 10:10:22 +0100
Message-ID: <1163668222.21027.276016817@webmail.messagingengine.com>
References: <1163613613.3406.14.camel@richip.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163613613.3406.14.camel@richip.dhs.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Richi Plana <richip@richip.dhs.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richi Plana wrote:
> I have an ASRock 939Dual-VSTA mobo that comes with a C-Media Electronics
> based sound system. Its USB Vendor and Product ID is 0d8c:0201,

Please show the output of "lsusb -v" for this device.

> The one major problem I have is that any audio played at 48000 Hz sounds
> distorted. Playing the same audio at 44100 Hz is fine.

Does "aplay something.wav" work?

> I just can't get audio to come out of the side, rear and center speakers.

Please try speaker-test.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
