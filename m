From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Error with snd_pc_sw_params in pcm.c
Date: Mon, 8 Nov 2004 18:44:39 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081841120.16893-100000@studcom.urz.uni-halle.de>
References: <20041105215534.GA28584@fargo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041105215534.GA28584@fargo>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Gómez wrote:
> madplay-0.15.2b
>
> ALSA lib pcm.c:826:(snd_pcm_sw_params) snd_pcm_sw_params:
> params->avail_min problem for start_threshold

This is a bug in madplay, it has tried to set inconsistent parameters.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
