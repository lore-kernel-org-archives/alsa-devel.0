From: "Jack O'Quin" <joq@io.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: 12 Nov 2004 11:19:25 -0600
Message-ID: <87k6srx9wi.fsf@sulphur.joq.us>
References: <20041111144152.GA12443@stud.ntnu.no>
	<87mzxozahr.fsf@sulphur.joq.us> <20041112090416.GA3167@stud.ntnu.no>
	<87oei3xbly.fsf@sulphur.joq.us> <s5hpt2jdmsr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt2jdmsr.wl@alsa2.suse.de>
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
Cc: =?iso-8859-1?q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At 12 Nov 2004 10:42:33 -0600,
> Jack O'Quin wrote:
> > The sound card generates an interrupt at the end of each period.  This
> > determines the input latency.  The hardware buffer holds multiple
> > periods (you need at least two).  Its size determines the maximum
> > output latency.  With JACK, there's not much reason to use more than
> > two or three periods, unless you're running without realtime
> > privileges.
> 
> Regarding JACK's latency:  can JACK handle more than two periods with
> the minimal latency?  That is, keeping only two periods active (the
> current playing and the next periods), you can achieve the same
> latency even if the buffer consists of more than two periods.
> 
> I'm asking this because some boards (e.g. RME32/96) have the fixed
> buffer size, and can't take the configuration as two periods per
> buffer.  IIRC, JACK fills all the buffer at the first sequence, and
> this results in the higher latency than necessary.
> 
> Correct me if I'm wrong.

I believe you are correct about this.  You probably understand it
better than I do.  :-)

Is this something we could fix in JACK's ALSA driver backend?
-- 
  joq


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
