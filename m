From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] try to load seq drivers multiple times
Date: Mon, 14 Oct 2002 12:31:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210141228540.521-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0210141144250.3103-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210141144250.3103-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Oct 2002, Clemens Ladisch wrote:

> If the sequencer device for a card is requested unsuccessfully (e.g.
> "pmidi -l" when a USB MIDI device isn't yet connected), the device is
> plugged in, and then the device is accessed, ALSA doesn't load the
> sequencer driver.
> 
> The reason for this is that snd_seq_client_use_ptr() assumes that the
> sequencer driver cannot be loaded when the card driver has failed to load
> before.
> 
> This patch removes the "!card_requested" protection from the call to
> snd_seq_device_load_drivers().

It's a bad idea. The better solution is to configure usbmgr to load usb 
driver when hardware is plugged in. We definitely don't want to see 
thousands of failure messages in /var/log/messages.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
