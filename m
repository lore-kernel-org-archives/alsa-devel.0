From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Frequency Problems with 0d8c:0201 and snd-usb-audio
Date: Mon, 20 Nov 2006 14:54:57 +0100
Message-ID: <1164030897.32341.276591015@webmail.messagingengine.com>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163792369.8128.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163792369.8128.8.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2006-11-15 at 11:00 -0700, Richi Plana wrote:
> > I have an ASRock 939Dual-VSTA mobo that comes with a C-Media Electronics
> > based sound system. Its USB Vendor and Product ID is 0d8c:0201,
> 
> Weird, I've never heard of mobos with onboard USB sound.  Does it come
> integrated or as a separate package?

It's just a chip on the mobo.

It makes sense - USB devices are completely self-contained; unlike HDA
codecs, they don't need initialization tables or any other configuration
code in the BIOS.  (And nobody will miss the eighth USB port, especially
on a cheap mobo like this.)


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
