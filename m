From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Wed, 14 Jun 2006 13:37:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606141330280.10637@tm8103.perex-int.cz>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
	<s5h1wts9eae.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wts9eae.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Sam Revitch <sam.revitch@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Jun 2006, Takashi Iwai wrote:

> > As another individual pointed out a few months ago, there are some
> > other problems with snd-usb-audio similar to those described above.
> > If a certain usb audio device has open file handles and is
> > disconnected or the system is suspended,
> > snd_usb_audio_disconnect()->snd_card_free() will block in the khubd
> > context while ALSA waits for the file handles to be closed, preventing
> > khubd from doing anything else useful like processing probe requests.
> > Using snd_card_free_in_thread() can be just as bad as it uses
> > schedule_work() and blocks one of the "events" threads.  A hang in
> > either context can cause problems for a resume-from-RAM operation.
> 
> Hm, this has to be fixed.  Just skipping the wait for file close will
> solve the problem?

Skipping the wait means calling snd_card_free() in last fops->release(), 
but as I mentioned, the card slot is still in use in this time. So it is 
not guaranteed that the reconnected devices will have same IDs. I think 
that best way is to fix applications to handle such situations as fast as 
possible and eventually add an event mechanism (if missing) to notify 
applications as fast as possible that device is no more available.

BTW: It's good that the USB layer handles susped/resume in midlevel.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
