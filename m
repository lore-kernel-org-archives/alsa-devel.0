From: Ralph Crongeyer <rcrongeyer@rpicc.com>
Subject: Re: Static with Intel 82801CA-ICH3 Driver in ALSA 0.9.6
Date: Tue, 23 Sep 2003 11:28:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309231128.47141.rcrongeyer@rpicc.com>
References: <200309231040.57534.rcrongeyer@rpicc.com> <s5h8yofr1ik.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yofr1ik.wl@alsa2.suse.de>
Content-Disposition: inline
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

Yea, I can try it. But i'm not sure how to go about it? Is it source code that 
needs to be compiled?

Ralph

On Tuesday 23 September 2003 11:02 am, Takashi Iwai wrote:
> At Tue, 23 Sep 2003 10:40:57 -0400,
>
> Ralph Crongeyer wrote:
> > Hi all,
> >
> > I'm having trouble with the Intel 82801CA-ICH3 Driver in ALSA 0.9.6. All
> > I here is static. I have removed the config files after uninstalling
> > 0.9.4 and then installing alsa-drivres, alsa-utils, and alsa-lib (0.9.6
> > version). And all I get is noise?
> > This is hapining on a Toshiba Satellite 5105-S501 laptop using the
> > Lunar-Linux distro with the 2.4.20 Kernel and compiled with gcc 3.2.3.
>
> could you try cvs version?
>
> if it doesn't work, please show /proc/asound/card0/ac97#0 and
> ac97#0regs files.  (also, /etc/asound.state to be sure).
>
>
> thanks,
>
> Takashi
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
