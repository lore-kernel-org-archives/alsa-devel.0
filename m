From: Stefan Gartner <stefang@aon.at>
Subject: Re: Request for test of powermac driver
Date: Thu, 16 May 2002 15:56:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E178LqI-000395-00@usw-sf-list1.sourceforge.net>
References: <s5hn0v15p95.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0v15p95.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
the driver seems to work on my ibook2 (tumbler). However, I noticed a few odd 
things:

* If I unplug the headphones, the speakers stay muted.
* When muting/unmuting "Auto Mute", the speakers get silent, but don't appear 
as muted in alsamixer. After muting/unmuting "PC Speaker" the speakers work 
again.
* "Headphone Detection" doesn't appear to have any effect.
* "Headphone" doesn't get muted/unmuted automatically (if it's muted and I 
plug in the headphones, it stays muted and the speakers don't get muted - 
maybe this is intended).

I'm not sure if points 2, 3 and 4 are bugs or errors on my side, but point 1 
most certainly is a bug.

Oh, and I had to change line 1353 of alsa-kernel/ppc/pmac.c from

        if (chip->mode <= PMAC_BURGUNDY)

to

        if (chip->model <= PMAC_BURGUNDY)

(rcs version 1.9)

hope this helps,
stefang

p.s:  is there a way to get the built-in microphone on the ibook working?

On Wednesday 15 May 2002 18:50, Takashi Iwai wrote:
> Hi,
>
> i've updated snd-powermac driver on cvs.
> so far, a G3 desktop (with screamer) was confirmed to work, but the
> others are not tested.
> thus i'd like to ask you powermac users to update and test the driver,
> and give me the feedback whether it works or not.
>
> a new feature of the driver is "automatic muting".
> it's supported on awacs/screamer, burgundy and tumbler chips.
> when the headphone is plugged/unplugged, then the mute switch is
> changed automatically.
> this feature is disabled by turning "Auto Mute Switch" control off.
>
> also, screamer driver has now more controls, bass/treble and
> amp. master volume, headphone volume/mutes.
>
> the tumber was improved at the last update, supporting bass/treble and
> DRC (dynamic-range compression) controls.
>
>
> Takashi
>
> _______________________________________________________________
>
> Have big pipes? SourceForge.net is looking for download mirrors. We supply
> the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Homer:	Okay, okay, don't panic.  To find Flanders, I
	just have to think like Flanders!

Homers Brain:
	I'm a big four-eyed lame-o and I wear the same
	stupid sweater everyday, and --

Homer:	The Springfield River!

		   Home Sweet Homediddly-Dum-Doodily

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
