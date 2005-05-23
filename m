From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: ali5451.c: M5451 info needed
Date: Mon, 23 May 2005 22:37:02 +0300
Message-ID: <20050523193702.GB16150@sashak.softier.local>
References: <20050522001953.GG27978@tecr> <s5hu0ku2qmq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hu0ku2qmq.wl@alsa2.suse.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 12:17 Mon 23 May     , Takashi Iwai wrote:
> 
> I don't know of the datasheet of this chipset.  IIRC, we got a source
> code from Acer, but not a datasheet.
> 
> Anyway, ali5451 looks pretty similar with Trident 4D DX/NX.
> The chip supports only 2 fixed periods.  If you need more periods,
> allocate an extra voice with the period size and let it generating
> interrupts but not producing sounds.

Yes, it is done so with audio playback, but not with capture. I've
tried something like this with modem playback, but output is going to
regular pcm channel (to speacker) and not to phone line. Seems some
bit setting is necessary.

Well, I'll try to work with 2 periods - aplay and arecord are ok.

Thanks, Takashi.

Sasha.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
