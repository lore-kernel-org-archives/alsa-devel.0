From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 21:44:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302172130470.30013-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.44.0302172038300.15268-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302172038300.15268-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "abramo.bagnara@libero.it" <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Feb 2003, Jaroslav Kysela wrote:

> Note that your all nice ideas go to some blind alley. Who will silence the 
> sum buffer? Driver silences only hardware buffer which will not be used 
> for the calculation in your algorithm.

Silencing is not time critical, if buffer is big enough it does not matter
whether is it done 1 ms or 100 ms after the card has played the data. Therefore
it may be done by a separate thread/process/kernel task without any
interference with other processes writing to the buffer.

Anyway, I strongly support writing/adding directly to DMA buffer - lowest
latency possible. Precise information about current position of HW pointer
should be available to each application so it may tune the delay (synchronize
the data coming from the source with slightly different clock frequency!) by
adding/deleting single samples (with interpolation). Mutexes optional.

Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
