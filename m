From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Cross compiling alsa-driver
Date: Thu, 06 Apr 2006 23:27:16 +0100
Message-ID: <1144362437.9219.11.camel@localhost.localdomain>
References: <1144187819.9472.25.camel@localhost.localdomain>
	 <s5hwte4ntxt.wl%tiwai@suse.de>
	 <1144361810.9219.6.camel@localhost.localdomain>
	 <1144362206.9219.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144362206.9219.9.camel@localhost.localdomain>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-04-06 at 23:23 +0100, Adrian McMenamin wrote:
> On Thu, 2006-04-06 at 23:16 +0100, Adrian McMenamin wrote:
> > On Wed, 2006-04-05 at 13:27 +0200, Takashi Iwai wrote:
> > > At Tue, 04 Apr 2006 22:56:59 +0100,
> > 
> > > 
> > > You didn't pass a proper --with-kernel option.
> > > See alsa-driver/INSTALL.
> > > 
> > 
> > Makes no difference. Still broken.
> > 
> > Long outputs follow - configure appears to ignore the specified
> > --with-build and --with-kernel options. I'll have a look at the script
> > 
> Appears to be broken
> 
> echo "$as_me:$LINENO: checking for directory with kernel source" >&5
> echo $ECHO_N "checking for directory with kernel source... $ECHO_C" >&6
> if test -d "/lib/modules/`uname -r`/source" -o -L "/lib/modules/`uname
> -r`/source"; then
>   DEFAULT_KERNEL_DIR="/lib/modules/`uname -r`/source"
>   DEFAULT_KERNEL_BUILD="/lib/modules/`uname -r`/build"
> elif test -d "/lib/modules/`uname -r`/build" -o -L "/lib/modules/`uname
> -r`/build"; then
>   DEFAULT_KERNEL_DIR="/lib/modules/`uname -r`/build"
> else
>   DEFAULT_KERNEL_DIR="/usr/src/linux"
> fi
> 
> 

Scrub the above... this appears later

CONFIG_SND_KERNELDIR="$kerneldir"
echo "$as_me:$LINENO: result: $kerneldir" >&5
echo "${ECHO_T}$kerneldir" >&6

echo "$as_me:$LINENO: checking for directory with kernel build" >&5
echo $ECHO_N "checking for directory with kernel build... $ECHO_C" >&6

# Check whether --with-build or --without-build was given.
if test "${with_build+set}" = set; then
  withval="$with_build"
  kernelbuild="$withval"
else
  kernelbuild="$DEFAULT_KERNEL_BUILD"

fi;
CONFIG_SND_KERNELBUILD="$kernelbuild"
echo "$as_me:$LINENO: result: $kernelbuild" >&5
echo "${ECHO_T}$kernelbuild" >&6


> 
> I know nothing about configure scripts but this looks to me like it just
> assumes we're building for the current machine and ignores the cross
> options. Is that right?
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
