From: Koef <koef@xs4all.nl>
Subject: Re: via82xx on MSI K8T Neo2 FIR (simple patch included)
Date: Mon, 25 Oct 2004 22:11:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041025201132.GA26502@bukken.notsupported.org>
References: <417D5AE7.2000601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <417D5AE7.2000601@web.de>
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

On Mon, Oct 25, 2004 at 09:58:31PM +0200, Michael Wagener wrote:

> via82xx works on MSI K8T Neo2 FIR with dxs_support=1:

> ac97 is an ALC850 which works with the latest ac97_codec.c.

I have this board too, and use dxs_support=1, but
/proc/asound/card0/codec97#0#/ac97#0-0 always tells me

SPDIF Control: Consumer Non-audio Category=0x2 Generation=1 Rate=48kHz

even when playing 44.1 kHz material. Does this mean that everything is
resampled to 48 kHz?

Thanks, Koef.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
