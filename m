From: Peter Plessas <plessas@mur.at>
Subject: Re: hg configure no soundcard all
Date: Fri, 8 Sep 2006 00:05:27 +0200
Message-ID: <20060907220526.GB8250@mur.at>
References: <20060906224618.GA8250@mur.at> <s5h1wqom3n8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1wqom3n8.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

thanks for your response!

I tried a fresh hg checkout and ran the hgcompile script, which has
problems finding the alsa-kernel directory as follows:

files are in:
/alsa_hg2/alsa-driver
/alsa_hg2/alsa-kernel

i set the ALSAKERNELDIR to
ALSAKERNELDIR=/usr/local/src/alsa_hg2/alsa-kernel

and run
./hgcompile  

getting:
No alsa-kernel is found.
Please specify the correct location via ALSAKERNELDIR environment
variable.

manually running the steps explained in the INSTALL file gets the same
problem as there is at
make ALSAKERNELDIR=/usr/local/src/alsa_hg2/alsa-kernel all-deps:
find: /usr/local/src/alsa_hg2/alsa-driver/alsa-kernel/: No such file or
directory

so there seems to be an offset in the directory structure which i did
wrong, as the ALSAKERNELDIR is not the path of the 'alsa-kernel'
directory. but the directory that very 'alsa-kernel' directory lives in.

So a very simple misunderstanding at my side of the keyboard.

Did succeed using the ftp snapshots though, so my system is happily
playing audio now.

Conclusion: some misunderstanding the exact location the ALSAKERNELDIR
variable should point at

Thanks again for the help!

Peter



* Takashi Iwai <tiwai@suse.de> [2006-09-07 11:23]:
> At Thu, 7 Sep 2006 00:46:18 +0200,
> Peter Plessas wrote:
> > 
> > Dear List.
> > 
> > Wanting to compile the drivers from the hg repository, but being stuck
> > at running ./configure which ends with:
> > 
> > 	checking for which soundcards to compile driver for... configure: error:
> > 	Unknown soundcard all
> > 
> > when i specify a single card i get about the same error:
> > 
> > 	...
> > 	Unknown soundcard hdsp
> > 
> > This must be something really simple, but i don't really get the
> > solution.
> > 
> > If anyone has an idea, i'd be glad to know!
> 
> Did you run hgcompile, or did something by yourself?
> Is autoconf new enough?
> 
> If you'd like just to try a recent version, you can pick up a daily
> tarball from
> 	ftp://ftp.suse.com/pub/projects/alsa/snapshot/
> and they are ready for configure without autoconf & co.
> 
> 
> Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
