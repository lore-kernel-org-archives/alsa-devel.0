From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: snd-rme9652 fails
Date: 18 Dec 2003 10:09:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071738574.2020.24.camel@localhost.localdomain>
References: <3FE02BA2.8020900@emt.iis.fhg.de>  <3FE1676C.40806@ifrance.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FE1676C.40806@ifrance.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benouille <benouille@ifrance.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-12-18 at 09:38, Benouille wrote:
> Hi
> 
> I confirm this fact:
> with kernel 2.4.23 and alsa 1.0rc2, the module snd-rme9652 can't be loaded
> althought the "old"  rme digi 9652 is perfectly working with alsa 0.9.6
> 

Hi,

I have found after a lot of printk that if I comment lines 1645 to 1648
of rme9652.c, the driver could be load and I can play music with jMax ;)

Here are the part to comment:
if (rme9652->ss_channels == RME9652_NCHANNELS)
  if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_rme9652_adat3_check, rme9652))) < 0)
     return err;

Please note that I have only test the first ADAT with playback.

# lspci output
$ /sbin/lspci -s 00:0e.0
00:0e.0 Multimedia audio controller: Xilinx Corporation RME Digi9652 (Hammerfall) (rev 03)
$ /sbin/lspci -n -s 00:0e.0
00:0e.0 Class 0401: 10ee:3fc4 (rev 03)

Bye,
Patrice.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
