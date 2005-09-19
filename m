From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: Best default values for "External Amplifier" and "Audigy Analog/Digital Output Jack"
Date: Mon, 19 Sep 2005 15:03:42 +0200
Message-ID: <m2fys1tdjl.fsf@vador.mandriva.com>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk>
	<m21x3lutb7.fsf@vador.mandriva.com> <432EB331.2010600@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432EB331.2010600@yahoo.co.uk> (Thomas Hood's message of "Mon, 19
	Sep 2005 14:46:41 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Hood <jdthood@yahoo.co.uk> writes:

> > i second that.
> 
> Here are the controls that are (currently) set in the ALSA initscript
> in Debian.  I would appreciate it if you could give me a similar list
> of controls that are set by Mandriva.

cf http://cvs.mandriva.com/cgi-bin/cvsweb.cgi/soft/sound-scripts/

the "initialize sound level script" is alsa_default.pl whose latest
version is:
http://cvs.mandriva.com/cgi-bin/cvsweb.cgi/soft/sound-scripts/alsa_default.pl?rev=1.28&content-type=text/x-cvsweb-markup


it's called by reset_sound:
http://cvs.mandriva.com/cgi-bin/cvsweb.cgi/soft/sound-scripts/reset_sound?rev=1.3&content-type=text/x-cvsweb-markup

reset_sound is called by an udev rule (alsa.rules which runs alsa.dev)
or by sound init script (if not using udev) on the first boot. It can
also be directly run by the end user to reinitialize its sound level
to what we set up on the first boot (ie if he messed up his config)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
