From: Richi Plana <richip@richip.dhs.org>
Subject: Re: Frequency Problems with 0d8c:0201 and	snd-usb-audio
Date: Fri, 17 Nov 2006 11:57:47 -0700
Message-ID: <1163789867.3406.55.camel@richip.dhs.org>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163668222.21027.276016817@webmail.messagingengine.com>
	<1163696903.3406.29.camel@richip.dhs.org>
	<1163697994.10962.276090935@webmail.messagingengine.com>
	<1163701408.3406.41.camel@richip.dhs.org>
	<1163784381.27992.276274101@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1163784381.27992.276274101@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-11-17 at 18:26 +0100, Clemens Ladisch wrote:
> This device has two configuration that are supposed to support 48 kHz,
> but the second one (that is used by the driver) has a packet size that
> would be about right for 96 kHz.
> 
> Please try the patch below.

That did it! Thanks!

I'll email the motherboard manufacturer and maybe C-Media. Will update
the mailing list if I get a reply.

Will the patch make the next version (1.0.14)?
--

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
