From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] USB MIDI bugs
Date: Mon, 11 Nov 2002 09:53:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021111085310.GA10197@tuba.home>
References: <20021108100427.GA502@tuba.home> <Pine.HPX.4.33n.0211110905510.16551-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211110905510.16551-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 11, 2002 at 09:15:14AM +0100, Clemens Ladisch wrote:
> 
> This fixes sequencer input from USB MIDI. Both usbmidi.c and seq_midi.c
> thought they could use substream->runtime->private_data for themselves.
> 
> Additionally, interrupt transfer resubmissions for kernels before 2.5.45
> are removed again.
> 

Thanks, Clemens! MK-249C is running fine again.

martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
