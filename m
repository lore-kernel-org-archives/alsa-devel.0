From: Stephen Hassard <steve@hassard.net>
Subject: Re: Configuring ALSA in kernel-2.5
Date: Thu, 27 Mar 2003 13:27:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030327212713.GA26666@www.angio.com>
References: <1048788276.2474.3.camel@tiger> <20030327193627.GA26072@www.angio.com> <1048794921.2474.31.camel@tiger> <200303272106.24524.ketelaars@wanadoo.nl> <1048798804.16646.1.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1048798804.16646.1.camel@tiger>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

technically, you don't need to run the script, with one really huge catch. you need a working devfsd. with the recent devfsd update, that's not really a possibility, therefore you need the script.

if you're seriously going to use alsa, it's worth updating the 2.5 kernel's alsa with one from CVS or a recent release. the kernel version is old and crusty.

if you've been watching the alsa-devel mailing list, I sent out a message a week ago asking how to do this.

the quick and sloppy answer to this is:
1. download and extract alsa (tgz or cvs) and kernel
2. in /usr/src/linux-2.5.xx/sound, do: "cp -Rf /path_to_alsa/alsa-kernel/* ."
3. in /usr/src/linux-2.5.xx/include/sound, do: "cp -Rf /path_to_alsa/alsa-kernel/include/* ."

that should be enough to update alsa in the kernel.

later,
Steve

On Thu, Mar 27, 2003 at 04:00:04PM -0500, Louis Garcia wrote:
> I thought you didn.t need that package because it was merged into 2.5?
> 
> --Lou
> 
> On Thu, 2003-03-27 at 15:06, Frans Ketelaars wrote:
> > On Thursday 27 March 2003 20:55, Louis Garcia wrote:
> > > Sorry no, I'm not running devfs. Where is that script snddevices?
> > >
> > > Thanks for your help, --Lou
> > 
> > <big snip>
> > 
> > In the alsa-driver directory :)
> > 
> > HTH,
> > 
> >     -Frans
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by:
> > The Definitive IT and Networking Event. Be There!
> > NetWorld+Interop Las Vegas 2003 -- Register today!
> > http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
