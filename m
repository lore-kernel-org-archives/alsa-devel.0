From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Tue, 7 Sep 2004 10:23:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409071022180.1723@linux.local>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
  <1094254221.6575.94.camel@krustophenia.net>  <1094260793.3727.19.camel@localhost>
  <1094408916.4445.13.camel@krustophenia.net>  <Pine.LNX.4.58.0409061347340.8854@linux.local>
  <1094503299.29921.78.camel@krustophenia.net>  <1094519360.3727.13.camel@localhost>
 <1094532469.16954.15.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094532469.16954.15.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: mjander@users.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2004, Lee Revell wrote:

> The interval timer seems to be intended exactly for this use; I am a bit
> baffled as to why was the channel loop interrupt, a relatively obscure
> feature, was chosen as the playback interrupt source.

No, in this case you don't get exact interrupt at period boundary.
It seems bigger problem (wrapping) than having an extra voice.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
