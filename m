From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: 2.6.0-test11
Date: Mon, 01 Dec 2003 23:50:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3vfp02lv0.fsf@merlin.emma.line.org>
References: <Pine.HPX.4.33n.0312011002010.24218-100000@studcom.urz.uni-halle.de>
	<87smk4pbd7.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87smk4pbd7.fsf@sulphur.joq.us> (Jack O'Quin's message of "01
 Dec 2003 13:49:08 -0600")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

"Jack O'Quin" <joq@io.com> writes:

>> Apostolos Dimitromanolakis wrote:
>> > I noticed that the newest alsa driver has not yet found it's way to the
>> > 2.6 kernel tree.. I hope it does before the official 2.6.0 release.
>
> These lists naturally contain lots of messages about things not
> working.  So, I'd like to report that my experience with 2.6.0-test11
> and ALSA was completely successful.  I downloaded the sources,
> configured them, selected my ALSA drivers, compiled, installed,
> rebooted, and (*gasp*) everything worked fine!

I have a nit to pick with the 2.6.0-test11 shipped Alsa: XMMS 1.2.8's
Alsa plugin hogs the machine horribly if mmap() is enabled. Without
mmap(), it's fine. So, it's really a nit. It may be worthwhile
documenting though.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
