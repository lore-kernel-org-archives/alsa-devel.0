From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: Suggestion: Multichannel enharnacements to alsa-lib.
Date: Wed, 2 Oct 2002 10:49:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021002104912.27940832.matthias@rpmforge.net>
References: <3D9AA3FB.5000104@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D9AA3FB.5000104@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time, James wrote :

> I am currently helping to write a media application in linux that plays 
> DVDs that have 5.1(e.g 6 channels) audio tracks.

Doesn't ogle already allow that?
http://www.dtek.chalmers.se/groups/dvd/

> It would be nice if my 
> audio application did not have to care about what speakers the user has, 
> and just output 6 channels every time and let alsa-lib adjust.

Indeed. I think you still have to indicate the number of speakers to use
with ogle, obviously.

>  Also, if 
> I used another audio application that could play CD-Digital Audio, 
> alsa-lib could automatically upmix it to 5.1 using dolby surround 2->4 
> upmix, and alsa-lib could then fill in the center and lfe channels.

This means adding some Dolby(C)(R)(TM)(etc.) Surround code into alsa-lib,
is that really possible?

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.07 0.23 0.22


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
