From: Mark J Roberts <mjr@znex.org>
Subject: Re: Audigy2 test results.
Date: Wed, 5 Feb 2003 07:10:58 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205131058.GA215@znex>
References: <20030205095109.GA198@znex> <s5hznpbey50.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hznpbey50.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai:
> what kind of output is expected on this jack?

Line one output. The working jacks are outputs two and three.

> this might be a bug of the driver, but not sure, atm.
> could you check whether interrupt counts increase when you receive a
> midi input?

They don't. MIDI _output_ generates plenty of interrupts, though.

I've verified that the keyboard and cable I'm using are working.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
