From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME96 driver patch
Date: Fri, 10 Jan 2003 16:13:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301101613.07818.torger@ludd.luth.se>
References: <200301051646.47991.torger@ludd.luth.se> <20030110145314.GF20015@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailg.telia.com (mailg.telia.com [194.22.194.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA25866
	for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2003 16:13:21 +0100
In-Reply-To: <20030110145314.GF20015@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 10 January 2003 15.53, Martin Langer wrote:
> On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> > Here is a patch against rme96.c
>
> snd_rme96_capture_spdif_open(snd_pcm_substream_t *substream)
>
> [...]
>
> +       runtime->hw = snd_rme96_capture_spdif_info;
> +        if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0)
> { +                if (isadat) {
> +                        return -EIO;
> +                }
> +                runtime->hw.rates = snd_rme96_ratecode(rate);
> +                runtime->hw.rate_min = rate;
> +                runtime->hw.rate_max = rate;
> +        }
>
>
> You were changing sample rates in snd_rme96_capture_spdif_open. Isn't
> it too late there? Looks like capturing with wrong sample rates is
> now possible? Wouldn't this be better placed in the
> snd_rme96_capture_hw_params?

It is done both in open (show capabilities to the user) and hw params 
(the user picks a setting from the available capabilities).

That is, open is performed before hw params, so theoretically it would 
only be necessary to do it in open, but it is placed in hw params as 
well if the input signal has changed between open and hw params (not 
likely).

As mentioned before, this driver does not yet handle the cases when 
sample rate and other properties is changed in runtime (I don't know if 
ALSA is complete in that respect either). Nothing will break though, 
but the user will not be notified of the change, and -EIO may be 
delivered (changing from SPDIF to ADAT input signal in runtime for 
example).

/Anders Torger


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
