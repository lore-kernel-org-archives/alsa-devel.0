From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: he's back/HDSP issues
Date: Thu, 23 Mar 2006 07:00:01 -0500
Message-ID: <1143115201.4329.8.camel@localhost.localdomain>
References: <1143074638.4344.4.camel@localhost.localdomain>
	<s5hd5gdjxfi.wl%tiwai@suse.de>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hd5gdjxfi.wl%tiwai@suse.de>
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

On Thu, 2006-03-23 at 10:57 +0100, Takashi Iwai wrote:
> At Wed, 22 Mar 2006 19:43:57 -0500,
> Paul Davis wrote:
> > 
> > Well, after a long absence from this list, I return. I will admit, its
> > mostly a result of deep confusion about changes that seem to have been
> > made with respect to the HDSP driver/support. 
> 
> Hey Paul, nice to see you back here ;)

and at LAC this year ? or do you have other plans?

> > What is that status of the "package" called "alsa-firmware" ? Is it now
> > deprecated or should distributions be including it?
> 
> alsa-firmware is mandatory for hdsp, it contains only the firmware
> "data", no program.  It should be installed to the kernel firmware
> path and/or the hdsploader firmware path.

the problem is that alsa-firmware does not seem to exist for fedora core
after 1.0 at all. i have tried rpmfind, rpm.pbone.net and yum search,
and they all suggest that no such package exists. so it appears as if it
has been dropped by fedora. do you have any idea on this? CCRMA still
seems to include it as a package, but not fedora itself.

> AFAIK, at each PCM operation (open, prepare, hw_params), hdsp driver
> checks the status register and reloads the firmware if needed.
> I don't know whether the status of external boxes is reflected to this
> register bit, but it's easy to add an ioctl to trigger the manual
> firmware reloading.

ok, sounds pretty reasonable.

--p




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
