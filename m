From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Tue, 13 Jun 2006 15:53:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606131549190.10493@tm8103.perex-int.cz>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Sam Revitch <sam.revitch@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Jun 2006, Sam Revitch wrote:

> Opinions?  Does one seem like it would be more robust, more reusable,
> or more work than the other?

How other drivers work? Network, video? I've not checked the code, but
I guess they don't care, too.

> As another individual pointed out a few months ago, there are some
> other problems with snd-usb-audio similar to those described above.
> If a certain usb audio device has open file handles and is
> disconnected or the system is suspended,
> snd_usb_audio_disconnect()->snd_card_free() will block in the khubd
> context while ALSA waits for the file handles to be closed, preventing
> khubd from doing anything else useful like processing probe requests.
> Using snd_card_free_in_thread() can be just as bad as it uses
> schedule_work() and blocks one of the "events" threads.  A hang in
> either context can cause problems for a resume-from-RAM operation.

Do you suggest a better solution? The original idea was to free slot (card 
number) before a next probe to guarantee that reconnect will grab this 
slot.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
