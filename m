From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.50: sleeping function called from illegal context
Date: Tue, 3 Dec 2002 13:21:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212031321.41585.baldrick@wanadoo.fr>
References: <3DE3F32200B4A5E8@mel-rti20.wanadoo.fr> (added by postmaster@wanadoo.fr)
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DE3F32200B4A5E8@mel-rti20.wanadoo.fr>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 03 December 2002 19:34, Paul Davis wrote:
> >I guess another way of dealing with this kind of problem is to use a
> >semaphore rather than a spinlock, and a workqueue: when the interrupt
> >comes in, the call to snd_ctl_notify is put on the queue, where it will
> > later be run in process context, and can safely take the semaphore.
>
> can i get a pointer to some code that does this? we need to do this
> for handling MIDI I/O in the hammerfall dsp driver. doing it from
> the interrupt handler causes audio dropouts because the midi i/o is so
> much slower.

For the use of workqueues (introduced in 2.5), see
http://lwn.net/Articles/11360/
and
http://lwn.net/Articles/10963/

For the use of task queues (now gone) and tasklets,
see for example "Linux device drivers" by Rubini and
Corbet.

If you need to go to sleep, you need to use a workqueue.
If you are happy running in interrupt context, a tasklet may
be enough.

I hope this helps,

Duncan.


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
