From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: DMIX and capture stream
Date: Thu, 8 Jan 2004 09:33:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401080931050.1871@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
 <200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com> <s5h1xqe2rjp.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>
 <20040106223828.39d2c233.mista.tapas@gmx.net> <s5hvfno10r5.wl@alsa2.suse.de>
 <3FFBFF51.1030002@tin.it> <s5hptdv27pz.wl@alsa2.suse.de> <3FFC1A12.7020901@tin.it>
 <s5hd69v245x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd69v245x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Abramo Bagnara <abramo.bagnara@tin.it>, Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Jan 2004, Takashi Iwai wrote:

> there are two parts to be modified, snd_pcm_open_noupdate() and
> snd_pcm_slave_conf().  they are the parts which look up "pcm"
> directive in the configuration.
> the former is easy.  but the latter function doesn't have stream
> argument, so it cannot check whether "pcmp" or "pcmc" to check.  and,
> changing this function will need rewriting all callers...

I agree with Takashi. The configuration scheme will be probably changed in
the future in favor of the integrated lisp interpreter which allows us to
better describe the plugin connections and handle the runtime stuff much
better. So, please, keep things simple. The standalone plugin looks as the 
best solution for the moment.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
