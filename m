From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [linuxsh-dev] Hotplug firmware problems
Date: Thu, 6 Oct 2005 09:32:28 -0400
Message-ID: <200510060932.28168.vapier@gentoo.org>
References: <1128452684.5085.4.camel@localhost.localdomain> <s5h8xx8chi3.wl%tiwai@suse.de> <1128539845.3388.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1128539845.3388.2.camel@localhost.localdomain>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linuxsh-dev@lists.sourceforge.net
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 October 2005 03:17 pm, Adrian McMenamin wrote:
> On Wed, 2005-10-05 at 13:47 +0200, Takashi Iwai wrote:
> > At Tue, 04 Oct 2005 22:59:30 +0100,
> >
> > Adrian McMenamin wrote:
> > > On Tue, 2005-10-04 at 20:04 +0100, Adrian McMenamin wrote:
> > > > I am attempting to load the firmware my device (AICA sound on
> > > > Dreamcast) needs via hotplug...
> > >
> > > Messed about with the hotplug scripts and now get this ... but I don't
> > > know why firmware.agent doesn't load the firmware... and I assume there
> > > is no sound.agent available...
> >
> > Does /etc/hotplug/firmware.agent work correctly?
>
> Well, no, in the sense that no firmware is loaded :(
>
> The logs report its invocation though I've added some echo lines into
> the firware.agent I'm using and they don't appear in any log, suggesting
> it isn't being found...

try redirecting the debug echos into a file instead ?
echo blah >> /tmp/firmware-log
-mike


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
