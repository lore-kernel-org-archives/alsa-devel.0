From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Question about underruns in 0.9
Date: Fri, 22 Mar 2002 09:18:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203220915160.711-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33.0203212306090.9245-100000@mcmillan.cadence.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0203212306090.9245-100000@mcmillan.cadence.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ken McMillan <mcmillan@cadence.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Mar 2002, Ken McMillan wrote:

> I have an application that is running a capture and playback
> simultaneously, with a fixed latency between them. In case of an
> underrun on the playback channel, I'd like the driver to keep running,
> without a short gap in the sound, but without losing synchronization
> between catpure and playback (i.e., keeping the same latency).
> 
> Can anyone suggest a way to do this? If the playback channel just stops,
> there seems to be no way to resynchronize the playback and capture
> without restarting the capture, which would result in lost samples.
> Is it possible to prevent the playback from stopping on an underrun?

Set stop_threshold from sw_params to UINT_MAX. The xrun check will 
be never activated in the case.

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
