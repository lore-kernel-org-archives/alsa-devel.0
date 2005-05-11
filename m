From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: Dmix using more CPU than plug:hw
Date: Wed, 11 May 2005 16:03:33 +0200
Message-ID: <m2wtq5lv0q.fsf@vador.mandrakesoft.com>
References: <20050507095346.37b16e6a.erikd-alsa@mega-nerd.com>
	<s5hmzr128wy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzr128wy.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
	11 May 2005 15:23:41 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > I'm playing around with Polypaudio (an EsoundD replacement) and
> > find that it works really well when I connect it to the plug:hw
> > and the CPU usage is as I would expect.
> > 
> > If on the other hand I connect Polypaudio to the plug:dmix1
> > (defined as below) device it attempts to chew up 100% of CPU and
> > then dies.
> > 
> > The ALSA version is whatever is in the 2.6.11 kernel. I have also
> > seen this problem on two different systems (iBook/Tumbler and
> > ia32/CMI8738) so its not hardware specific.
> > 
> > Does anyone have any ideas as to why a dmix device behaves so
> > differently to plug:hw?
> 
> Does it still happen with 1.0.9rc3?

afaic artsd with alsa-lib-1.0.9rc3 eats quite lots cpu time. i've got
similar reports from people that previously reported that artsd was
using too much cpu time.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
