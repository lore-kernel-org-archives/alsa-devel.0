From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: Re: via82xx calc_linear_pos bug
Date: Tue, 27 Jul 2004 17:53:37 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090940018.3300.16.camel@onion.home.net>
References: <1090597651.3258.3.camel@onion.home.net>
	 <s5hekmx603j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekmx603j.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-07-27 at 15:39 +0200, Takashi Iwai wrote:
> At Fri, 23 Jul 2004 18:47:30 +0300,
> Timo Hirvonen wrote:
> > 
> > After playing about 10-20 seconds snd_pcm_status_get_avail returns too
> > large value (1972895704, 1972895664 ..).
> 
> Grrr, the empire strikes again.
> 
> The change in the recent version was a workaround to fix the similar
> bug on many buggy mobos.
> Could you try the attached patch?

That patch works.  snd_pcm_status_get_avail returns now sane values
again.  I don't see any "invalid via82xx_cur_ptr" messages so the code
seems to be correct now.

thanks




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
