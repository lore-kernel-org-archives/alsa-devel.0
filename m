From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: alsa-driver annoyance
Date: Tue, 18 Apr 2006 18:52:35 +0100
Message-ID: <1145382755.9257.1.camel@localhost.localdomain>
References: <1145048699.9434.7.camel@localhost.localdomain>
	 <20060417120106.GA25991@turing.informatik.uni-halle.de>
	 <1145291403.9244.2.camel@localhost.localdomain>
	 <s5hlku39p4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 3BC00183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 19:52:42 +0200 (MEST)
In-Reply-To: <s5hlku39p4g.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-18 at 12:03 +0200, Takashi Iwai wrote:
> At Mon, 17 Apr 2006 17:30:03 +0100,
> Adrian McMenamin wrote:
> > 
> > On Mon, 2006-04-17 at 14:01 +0200, Clemens Ladisch wrote:
> > > Adrian McMenamin wrote:
> > > > I am cross compiling alsa driver for use on an NFS root mounted
> > > > partition hosted on my development box for use by a box running a 2.6.15
> > > > kernel - the development box uses a 2.6.12 kernel
> > > > 
> > > > Alsa-driver insists on creating a 2.6.15 modules directory on the
> > > > development box hierarchy and then installing modules in that directory
> > > > and not in the NFS root partition.
> > > 
> > > What are the parameters and the output of the configure script?
> > > 
> > 
> > I discovered that this was really an issue about the help.
> > 
> > The option --with-moddir sets the installation directory for the modules
> > though the help makes that less than clear - especially as it listed
> > under "Optional Packages" and not "Fine tuning of the installation
> > directories".
> > 
> > Maybe it should be patched?
> 
> No, it should work without --with-moddir option.
> 
> The symptom implies that the configure script didn't detect the right 
> kernel version.  Did you pass a proper --with-build=xxx option?

Yes, I did. The problem was it attempted to install the modules in the
hierarchy of the build machine not in the NFS mountable hierarchy. This
is not a question of detecting the right kernel version at all.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
