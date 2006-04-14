From: John Rigg <ad@sound-man.co.uk>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Fri, 14 Apr 2006 12:54:48 +0100
Message-ID: <20060414115448.GA3018@localhost.localdomain>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe> <20060413031705.GA9160@hurl.ugcs.caltech.edu> <1144898970.10666.139.camel@localhost.localdomain> <20060414082632.GA21247@hurl.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060414082632.GA21247@hurl.ugcs.caltech.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 14, 2006 at 01:26:32AM -0700, Lance Blisters wrote:
> Now I have latest JACK from CCRMA in /usr/lib and JACK from CVS
> patched for MMAP in a local directory.  I have alsa-lib RPM from
> fedora core updates, patched for duplex multi access.  I can run
> my patched JACK, and i can open multi_playback and multi_capture
> with 16 channels each, JACK runs and reports the rare XRUN.  But
> I can't connect from any clients; starting with QJACKCTL yields
> "Cannot connect to JACK server as client" and ardour tries to start
> its own server then fails because one is already running, then
> "Could not connect to JACK server as  "ardour"".  I get the
> same JACK connection problem whether using direct card access
> or ALSA multi device.

If you have two versions of JACK installed it will cause problems.
Ardour expects to find libjack.so in /usr/lib and will use that instead of
the one in /usr/local/lib. You can make it use the correct one by
removing the packaged version and putting a symlink from
/usr/lib/libjack.so to /usr/local/lib/libjack.so:

ln -s /usr/local/lib/libjack.so /usr/lib/libjack.so

John


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
