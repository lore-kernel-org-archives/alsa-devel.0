From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: ALSA CVS and JACK?
Date: 26 Feb 2003 14:25:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046287523.1101.4.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302251856280.2277-100000@pnote.perex-int.cz>
	<E18nkIs-0002Oa-00@sc8-sf-list1.sourceforge.net>
	<s5hsmubxv48.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmubxv48.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-02-26 at 04:13, Takashi Iwai wrote:
> At Tue, 25 Feb 2003 14:02:05 -0500,
> Paul Davis wrote:
> > 
> > >Can we see reports? I don't see any reason for crashes.
> > 
> > nobody that this has happened to so far has had an oops trace. they
> > are always running graphical apps and do not have a serial console. i
> > am too nervous (:) to try it myself (hence i still have ALSA CVS from
> > way back). apparently it may it also be connected to a particular
> > kernel version.
>  
> isn't it the 2.4.20+ext3 problem?
> 

OK, I switched to ext2 on all file systems. Now I can run latencytest to
completion, although oddly it complains about how it can't kill top. The
upper bound for audio latency on this crusoe-based c1mw is presently
6.8ms, both according to latencytest and the pd latency measuring patch.
The cpu latency is reported at around 1.5ms.

Jack and freqtweak still make the system hang, although I have to try
several times to start freqtweak at all without getting the error
message that freqtweak was "shut down" by the jack server.

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
