From: Sebastian Hack <lists@s-hack.de>
Subject: Re: Inspiron 8200 and the CS4205
Date: Sun, 22 Sep 2002 11:42:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020922094200.GA1571@miles.wgnet>
References: <20020918140355.GA1592@miles.wgnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020918140355.GA1592@miles.wgnet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have the same Problem as Rodney Gordon II and Stuffed Crust. I also
have clicks and pops in both native alsa and oss playback. Using jack,
enlarging the period size has positive effects but does not eliminate
the problem.

I found one thing: The Inspiron 8200's BIOS routes all devices (USB,
VGA, Ethernet, Sound) to IRQ 11 (at least mine does). Windows XP
leaves this untouched, except the IRQ for the CS4205, which is set to
5. I don't know why, but perhaps, this could hint on a IRQ sharing
problem with the CS4205.

On the other hand, the i810_audio linux kernel sound driver works
quite fine with IRQ 11, but I think that we all agree, that this is
not an alternative to alsa :-)

Regards,
Sebastian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
