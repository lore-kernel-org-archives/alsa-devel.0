From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_hardware_t NOT pre-initialized
Date: Mon, 9 Sep 2002 16:22:37 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209091619550.10104-100000@gate.perex.cz>
References: <20020906162801.82599.qmail@web11504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07198
	for <alsa-devel@alsa-project.org>; Mon, 9 Sep 2002 16:22:44 +0200
In-Reply-To: <20020906162801.82599.qmail@web11504.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Sep 2002, Guilhem Tardy wrote:

> Hi,
> 
> snd_pcm_hardware_t is NOT pre-initialized, and drivers are responsible to
> define ALL fields necessary. This is too bad, because it essentially means that
> a new constraint (i.e. period_size_min + period_size_max) will need to be
> supported by all drivers.
> 
> I have tested successfully such a new constraint (patch in attachment), and
> hope that you'll incorporate it in the cvs anyway.

I don't think that we need such contraint in the midlevel code. Please,
add it only to your driver to open() callback. Anyway, it's not too good
to change numbers for formats. BTW: Can compression algorithms be used
only for specific sample rates? Otherwise, I don't see any reason to put
KBPS to format name.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA project  http://www.alsa-project.org




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
