From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Simple alsa sequencer question
Date: Tue, 28 Oct 2003 10:23:40 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310281019210.6436-100000@studcom.urz.uni-halle.de>
References: <20031027165933.2307acfe.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20031027165933.2307acfe.rpav@mephle.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@mephle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ryan Pavlik wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
>
> > Ryan Pavlik wrote:
> > > Shouldn't I get numbers in ev->time.time.tv_*?  I'm just getting
> > > zeros... what did I miss? ;)
> >
> > (snip)
>
> OK, I've attached some code to show what I'm doing exactly.

The event timestamps are set yo the current time of the queue. Your
queue isn't running, so its current time is zero.

Call snd_seq_start_queue(seq, queue, NULL) (and snd_seq_drain_output).


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
