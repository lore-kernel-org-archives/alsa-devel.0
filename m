From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME Hammerfall HDSP 9652: no configurations available
Date: Sat, 19 Jul 2003 09:25:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085.62.39.221.155.1058599502.squirrel@www.undata.org>
References: <200307182118.27990.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307182118.27990.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: torger@ludd.luth.se
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> I'm trying out the HDSP driver from CVS (checked out today), on a RME
> HDSP 9652 PCI card, but I don't manage to get it to run, with my basic
> test
>
> # aplay -D hw -f S32_LE -c 26 -r 48000 /dev/zero
>
> Playing raw data '/dev/zero' : Signed 32 bit Little Endian, Rate 48000
> Hz, Channels 26
> aplay: set_params:787: Broken configuration for this PCM: no
> configurations available
>
> The firmware is loaded using hdsploader. Running aplay on another sound
> card on the machine works.
>

Note you don't need to run hdsploader with hdsp9652 cards.

> Any ideas why this happens? It seems like snd_pcm_hw_params_any returns
> no parameters at all. That is strange, since when I put in some debug
> logs in the driver it seems like the driver returns a proper
> parameters.
>
> /Anders Torger
>

There was a problem with the number of channels in a recent driver version
for hdsp9652 cards. It was fixed in cvs yesterday. Unfortunately
sourceforge's cvs has a 24 hours delay for anonymous checkout. You can
check the number of channels using alsamixer or amixer. If the number
reported is 14 instead of 26, then you need to update your tree or
manually apply the patch I posted on this list 2 days ago.

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
