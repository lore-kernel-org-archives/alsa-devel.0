From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
Subject: Re: Error with snd_pc_sw_params in pcm.c
Date: Mon, 8 Nov 2004 21:25:08 +0100
Message-ID: <20041108202508.GA3365@fargo>
References: <20041105215534.GA28584@fargo> <Pine.HPX.4.33n.0411081841120.16893-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0411081841120.16893-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens ;),

On Nov 08 at 06:44:39, Clemens Ladisch wrote:
> David Gómez wrote:
> > madplay-0.15.2b
> >
> > ALSA lib pcm.c:826:(snd_pcm_sw_params) snd_pcm_sw_params:
> > params->avail_min problem for start_threshold
> 
> This is a bug in madplay, it has tried to set inconsistent parameters.

I'll report it then to madplay authors, thanks for your help ;)

-- 
David Gómez                                      Jabber ID: davidge@jabber.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
