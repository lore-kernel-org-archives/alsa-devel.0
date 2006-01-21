From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Fri, 20 Jan 2006 20:53:02 -0500
Message-ID: <1137808385.3241.78.camel__27691.925087902$1137808462$gmane$org@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain>
	 <1137709308.8471.77.camel@localhost.localdomain>
	 <20060119224501.GC19398@stusta.de>  <20060120025513.GA2438@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 876C1191
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 02:53:16 +0100 (MET)
In-Reply-To: <20060120025513.GA2438@codepoet.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andersen@codepoet.org
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-01-19 at 19:55 -0700, Erik Andersen wrote:
> On Thu Jan 19, 2006 at 11:45:01PM +0100, Adrian Bunk wrote:
> > config SOUND_WAVEARTIST
> >         tristate "Netwinder WaveArtist"
> >         depends on ARM && SOUND_OSS && ARCH_NETWINDER
> >         help
> >           Say Y here to include support for the Rockwell WaveArtist sound
> >           system.  This driver is mainly for the NetWinder.
> 
> I own two netwinders (strongArm SA110) and I would be glad to
> fire them up to test things if someone feels like writing a
> driver....

I guess you are not volunteering to do it yourself...?

If you feel like tackling this google "Writing an ALSA driver", it
basically walks you through the process, you could do it in a weekend
with the source to the OSS driver in hand.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
