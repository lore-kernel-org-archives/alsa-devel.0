From: "Jack O'Quin" <joq@io.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: 17 Nov 2004 11:32:15 -0600
Message-ID: <87oehwv0tc.fsf@sulphur.joq.us>
References: <20041111144152.GA12443@stud.ntnu.no>
	<87mzxozahr.fsf@sulphur.joq.us> <20041112090416.GA3167@stud.ntnu.no>
	<87oei3xbly.fsf@sulphur.joq.us> <s5hpt2jdmsr.wl@alsa2.suse.de>
	<87k6srx9wi.fsf@sulphur.joq.us> <s5hd5ycsexu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5ycsexu.wl@alsa2.suse.de>
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


> > Takashi Iwai <tiwai@suse.de> writes:
> > > I'm asking this because some boards (e.g. RME32/96) have the fixed
> > > buffer size, and can't take the configuration as two periods per
> > > buffer.  IIRC, JACK fills all the buffer at the first sequence, and
> > > this results in the higher latency than necessary.
> > > 
> > > Correct me if I'm wrong.

> At 12 Nov 2004 11:19:25 -0600,
> Jack O'Quin wrote:
> > I believe you are correct about this.  You probably understand it
> > better than I do.  :-)
> > 
> > Is this something we could fix in JACK's ALSA driver backend?

Takashi Iwai <tiwai@suse.de> writes:
> We can set different values to avail_min for playback and capture
> directions.  For getting the minimal latency, set
> (nperiods - 1) * period_size for playback and period_size for
> capture.
> 
> The patch attached adds a new option -f to specify the filling
> periods.  As default (= 0), it's identical with nperiods, so the old
> behavior is kept.

Thanks for the patch!

Not sure I completely understand how to document this.  Is -f
effectively setting the output latency, with -n as the default?

Is there some way users could just set the desired latency directly,
or even request the minimum number of periods?  Is the minimum always
2?  What happens if the user specifies -f1?
-- 
  joq


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
