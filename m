From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: DMIX and capture stream
Date: Wed, 07 Jan 2004 16:47:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFC2A29.4080401@tin.it>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>	<200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>	<s5h1xqe2rjp.wl@alsa2.suse.de>	<Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>	<20040106223828.39d2c233.mista.tapas@gmx.net>	<s5hvfno10r5.wl@alsa2.suse.de>	<3FFBFF51.1030002@tin.it>	<s5hptdv27pz.wl@alsa2.suse.de>	<3FFC1A12.7020901@tin.it>	<s5hd69v245x.wl@alsa2.suse.de>	<3FFC229C.2020200@tin.it> <s5hbrpf22u3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrpf22u3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> 
> if i understand the code correctly, for defining a pcmp or pcmc as a
> slave pcm, such as,
> 
> 	pcm.foo {
> 		type plug
> 		slave {
> 			pcmp bar_playback
> 			pcmc bar_capture
> 		}
> 	}
> 
> snd_pcm_slave_conf() needs to know which one to be used, so that the
> config subtree (of either pcmp, pcmc or pcm) is passed to
> snd_pcm_open_slave().
> 
> otherwise, you have to define slave pcms always separetly, such as,
> 
> 	pcm.foo {
> 		type plug
> 		slave {
> 			pcm bar
> 		}
> 	}
> 	pcmp.bar bar_playback
> 	pcmc.bar bar_capture
> 
> i think it's a big restriction.

As a matter of personal preference I very much prefer this latter form 
(as it leave capture and playback definition clearly separated as 
directions are in ALSA API).

Under an "objective" point of view: would you really derive from the 
comparison of the two equivalent alternative syntaxes the feeling of "a 
big restriction"?

Technically they're quite the same.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
