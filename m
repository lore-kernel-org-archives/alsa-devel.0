From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: Test model
Date: Fri, 17 Feb 2006 12:42:51 +1030 (CST)
Message-ID: <200602170212.k1H2CpPr019500@auster.physics.adelaide.edu.au>
References: <acb0c1690602160208w1eb86af2uc38cb7592ba355ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602160208w1eb86af2uc38cb7592ba355ff@mail.gmail.com> from "Paulo Matias" at Feb 16, 2006 08:08:24 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paulo Matias <syscoder@gmail.com>
Cc: Rimas Kudelis <rq@akl.lt>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Paulo

> By the description of Rimas, I think we have the same Acer notebook,
> or, at least, we've the same connections (mine is a TravelMate
> 4062WLMi, but I seriously suspect all TravelMate 4060 series has the
> same hardware and connections, only varying in LCD size, RAM and HD
> size, and presence of internal BlueTooth adapter).

Sounds likely.

> I had the same problems he had and got sound from the same pins he got.

Excellent news - that at least rules out obscure hardware faults in 
Rimas' machine.

> Jonathan, by your last email, I was thinking in a possibility. You
> asked me about a external volume control. There are two keys at the
> keyboard for increasing and decreasing the volume. They are Fn+Up
> Arrow and Fn+Down Arrow. I was thinking in the possibility it
> controls, via software, a volume control plugged in the out of the
> codec. Is it possible?

My Fujitsu laptop has similar buttons and I must confess I've never tried
them.  I know the similarly labeled brightness buttons are trapped and
handled by the hardware since they work under Linux without me having to
tell the system about them.  I suspect however that the volume controls are
treated as just another key which can be used by software in whatever way it
chooses. Using showkey (or similar programs) would confirm this.  The reason
I say this is because in the case of the mixer, sofware must be informed of
any changed done behind its back by hardware whereas this isn't essential
for brightness.

> Someone who has windows in this laptop could help, using this keyboard
> controls and checking if it controls the mixer volume, or something
> else.

This test would only show what happens when windoze is booted.  It won't 
tell us whether it's doing it by directly talking to the hardware or whether
the windoze driver traps those keys and does the volume adjustments itself.

> I've also taked a look at the windows drivers cd Acer provided. The
> Realtek drivers installer has a directory called WDM that contains
> .inf files that seems to contain the internal routings for varied
> models. I haven't analysed it so much yet to confirm, but I can
> provide the files on request.

That's interesting.  I'd be interested in seeing these files.  Perhaps
email it/them privately.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
