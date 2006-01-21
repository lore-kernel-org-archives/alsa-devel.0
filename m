From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Fri, 20 Jan 2006 22:52:50 -0500
Message-ID: <1137815571.3241.133.camel__38597.9041610428$1137815673$gmane$org@mindpipe>
References: <20060120082155.24254.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 04A3718C
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 04:52:59 +0100 (MET)
In-Reply-To: <20060120082155.24254.qmail@dag.newtech.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dag Nygren <dag@newtech.fi>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 10:21 +0200, Dag Nygren wrote:
> > On Thu, 2006-01-19 at 21:24 +0100, Krzysztof Halasa wrote:
> > > Don't you all think a large part (if not most) of the
> > > "ALSA-unsupported"
> > > cards is no longed in any (Linux-related) use? I wouldn't be surprised
> > > if they just don't exist anymore. Who is to write drivers for them and
> > > -
> > > more importantly - who can test them? 
> > 
> > Yes, it would require a collector of ancient sound hardware... do you
> > know anyone like that?
> > 
> > Even the NeoMagic 256 which is a Pentium II era device and was in
> > widespread use we cannot find a tester for.
> 
> I could do that, my boy is still playing tuxpaint and other stuff on my old 
> laptop
> with such a chip.

Thanks!

Basically just see if you can produce a hang by repeatedly loading and
unloading snd-nm256, preferably at a console, so you can see any Oops.
If you do see the hang, try the reset_workaround options described in
ALSA-Configuration.txt.

If you can reproduce a hang add printks in the module __init code and
try to narrow down where it dies.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
