From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Where did my PCM devices go (using devfs)?
Date: Sat, 17 May 2003 15:14:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305171513480.21997-100000@pnote.perex-int.cz>
References: <20030517122922.35181.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030517122922.35181.qmail@web40603.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 17 May 2003, [iso-8859-1] Chris Rankin wrote:

> Hi,
> 
> I've just loaded the latest CVS version of ALSA and
> discovered that my /dev/snd directory now contains
> only the following devices:
> 
> /dev/snd/controlC0
> /dev/snd/controlC1
> 
> I use devfs with Linux-2.4.20, and I obviously have
> two sound devices installed. Yes, I know that
> /proc/asound/dev has been removed - but I obviously
> don't link to it because I still see the control
> devices.

Oops. I forget to move devfs stuff. Please, could you try CVS again? Thank 
you.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
