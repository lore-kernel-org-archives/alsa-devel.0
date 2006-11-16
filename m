From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Frequency Problems with 0d8c:0201 and snd-usb-audio
Date: Thu, 16 Nov 2006 18:26:34 +0100
Message-ID: <1163697994.10962.276090935@webmail.messagingengine.com>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163668222.21027.276016817@webmail.messagingengine.com>
	<1163696903.3406.29.camel@richip.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163696903.3406.29.camel@richip.dhs.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Richi Plana <richip@richip.dhs.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richi Plana wrote:
> > > The one major problem I have is that any audio played at 48000 Hz sounds
> > > distorted. Playing the same audio at 44100 Hz is fine.

Your device claims to support both 44.1 and 48 kHz.

What kind of distortion?

What are the contents of /proc/asound/card0/stream0 while some
48 kHz stream is playing?

> > > I just can't get audio to come out of the side, rear and center speakers.
> > 
> > Please try speaker-test.
> 
> Thanks for that tip. So the other channels and their mixer controls DO
> work. It's just that the motherboard manual mislabeled to Rear and
> Central/LFE ports, and I managed to find that out by using speaker-test.

I guess the problem is that ALSA's default channel order isn't the same
as that defined in the USB audio specification, and ALSA doesn't yet
remap the channels for USB devices.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
