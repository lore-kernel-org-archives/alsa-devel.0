From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Mixer API
Date: Tue, 3 Aug 2004 11:00:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408031056020.1844@pnote.perex-int.cz>
References: <200408030820.i738Ka4k016237@www7.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408030820.i738Ka4k016237@www7.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Aug 2004, Peter Zubaj wrote:

> Hi,
> 
> I have question:
> What is prefered mixer api for ALSA ?
> 
> There are 2 of them:
> 1) ctl (snd_ctl_* and snd_hctl_*)interface - directly maped to driver
> 2) mixer (snd_mixer_*) interface - build above ctl interface

The control interface (ctl) interface is for raw access to hardware.
You can build mixers for specific hardware.

The mixer interface should offer the abstraction for the most of 
standard mixer applications. At this time, no abstraction is implemented 
and the mixer elements are build from the control interface with some 
assumptions. These assumptions are broken for mentioned cards like emu10kx 
etc. I am actually working on interface inside the alsa library which will
allow us to describe the mixer abstraction using a simple lisp interpreter 
(or maybe a lisp compilator later).

So wait, please. I hope that I will have something useable this month.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
