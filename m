From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Syncronous start and stop
Date: Tue, 18 Nov 2003 10:02:54 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20031118100254.pochini@shiny.it>
References: <Pine.LNX.4.53.0311151929540.1259@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311151929540.1259@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 15-Nov-2003 Jaroslav Kysela wrote:
> On Sat, 15 Nov 2003, Giuliano Pochini wrote:
>
>> My hardware can start/stop multiple indipendent substreams at the same time.
>> Does the ALSA driver API support that feature ?
>
> Yes, use snd_pcm_set_sync() function in open() callback and add necessary
> code to the trigger() callback. See to alsa-kernel/pci/ens1370.c code for
> more details (this hardware has three streams which can be controlled
> simultaneously) as a good example.

Fine.
Is that feature used by the upper ALSA driver to create multichannel
substreams when the hw hasn't this capability ?  Older Echoaudio
soundcards can only do mono and stereo operation, while newer series can
manage mono and any even number of channels. Since all cards can run any
number of substreams at the same time, I can emulate large substream on
older cards by starting several mono substream simultaneously
(MMAP_NONINTERLEAVED in this case). If the upper layer already has this
feature, I can avoid wasteing my time :)


--
Giuliano.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
