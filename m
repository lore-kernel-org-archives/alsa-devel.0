From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: C-Media / usb device bug ?
Date: Tue, 19 Sep 2006 08:36:43 +0200
Message-ID: <1158647803.13410.271265867@webmail.messagingengine.com>
References: <200609181921.10510.pyaggi@alsurdelsur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200609181921.10510.pyaggi@alsurdelsur.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pablo Yaggi <pyaggi@alsurdelsur.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pablo Yaggi wrote:
>  I'm working in a multi-capture application with alsa and i discovered
> if i attach two "c-media usb headphone set" adapters to an usb hub which
> is attached to my computer when i try to read from the two devices the
> first one read (also open) errors with (-77) bad file descriptor status
> and the other one keep working. When i attach the two devices directly to
> the usb connectors (without hub) all works fine, the two devices can be
> read at the same time.

What kernel version are you using?

The EHCI transaction translator code (which is responsible for moving
audio data through an high speed hub) got a bugfix in 2.6.17, but still
artificially limits the bandwidth.  It will be rewritten in 2.6.18.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
