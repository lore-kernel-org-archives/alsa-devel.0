From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Wed, 21 May 2003 13:35:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305211334530.1480-100000@pnote.perex-int.cz>
References: <s5hk7ckvbap.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7ckvbap.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, Paul Davis <paul@linuxaudiosystems.com>, Arthur Peters <amp@singingwizard.org>, Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2003, Takashi Iwai wrote:

> At Wed, 21 May 2003 02:32:02 +0200,
> Pieter Palmers wrote:
> > 
> >   Ok, second try:
> > 
> > alsa 0.9.3c fresh from CVS
> >    ---------------------------------------
> >     /proc/asound/version:
> >    Advanced Linux Sound Architecture Driver Version 0.9.3c.
> >    Compiled on May 21 2003 for kernel 2.4.20-LL with versioned symbols.
> > 
> >     /proc/asound/cards:
> >    0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
> >                         Ensoniq AudioPCI ENS1371 at 0xb000, irq 5
> > 
> >    ---------------------------------------
> 
> how about this one?  this should fix another deadlock
> (including the simplified expression of stream lock)

Takashi, the self_group is designed to avoid mess in the lowlevel drivers. 
Now, the code is same for both linked and standalone streams. Please, do 
not remove it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
