From: ljp <ljp@llornkcor.com>
Subject: Re: porting oss app to alsa
Date: Thu, 30 Jan 2003 07:17:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301300717.36415.ljp@llornkcor.com>
References: <200301292018.47486.ljp@llornkcor.com> <m2ptqfdj4l.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2ptqfdj4l.fsf@vador.mandrakesoft.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thursday January 30 2003 03:31 am, Thierry Vignaud wrote:
> ljp <ljp@llornkcor.com> writes:
> > Is there a simple document outlining the OSS functions and their
> > ALSA equivalents?
>
> for basic usage : do man of open(), read(), close(), write().

Thank you, I am aware of these.

> this is portable but limited (open/closing mixer/device, setting mix ,
> output samples, ...)
>
> for high level usage, look at html doc in libalsa2.

ya, I was asking if there is a document that explains how to port OSS apps.
Such as:

OSS						ALSA
-------------------------------------------------------
SNDCTL_DSP_GETOSPACE	 something_or_another
MIXER_READ				 some_mixer_function	

Some simple doc like that, outlining the different functions and the ALSA 
counterparts, I think, would allow people like me, with too many projects, 
and not enough time, to add ALSA functionality to apps.

I am asking this, as the ALSA OSS compat. seems to be getting depreaciated (I 
dont blame it), and stuck on rc1.


ljp


-- 
My cat's a debugger....

Potter, Lorn, "ljp"
core member / Web Administrator
Project OPIE- the Open Palmtop Integrated Environment
http://opie.handhelds.org 
IRC: irc.freenode.net #opie #opie.de

llornkcor@handhelds.org
llornkcor@helixcommunity.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
