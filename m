From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi question.
Date: Mon, 4 Mar 2002 10:51:09 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203041044120.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3C80EC6D.A3D4E482@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2 Mar 2002, Peter Enderborg wrote:

> I have a snd_rawmidi_t. And I want to know what client Id it will have
> in the other end. For example my first rawmidi is card 2 device 0. And
> that is client id 80:0 but how do I look that up in the rigth way?

The best way is look for clients 'External MIDI C' where C is number of 
card and ports 'MIDI C-D' or 'MIDI C-D-S' where C is number of card, D is 
number of device and S is number of rawmidi subdevice.

I'm refering card names and port names.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
