From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Dmix using more CPU than plug:hw
Date: Thu, 12 May 2005 20:08:48 +1000
Message-ID: <20050512200848.1fe02c01.erikd-alsa@mega-nerd.com>
References: <20050507095346.37b16e6a.erikd-alsa@mega-nerd.com>
	<s5hmzr128wy.wl@alsa2.suse.de>
	<m2wtq5lv0q.fsf@vador.mandrakesoft.com>
	<s5hekcd26ky.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekcd26ky.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Note : I am now subscribed to the list. Please reply to the list
       and do not CC me. Thanks.

Takashi Iwai wrote:

> > > Does it still happen with 1.0.9rc3?

I haven't tried this yet. Whats involved with installing the alsa 
drivers under a 2.6 kernel?

> That's bad.  I hope it got fixed now.
> 
> Anyway, this high CPU usage is usually solved when you run without
> rate conversion in alsa-lib.  Specify 48000Hz for artsd or polyaudio.

With polypaudio I have tried forcing the rate to both 48000 and 44100
(which is the only rate my iBook/Tumbler hardware actually accepts).
In both cases, polypaudio chews up 100% if CPU time and gets killed
within about 10 seconds.

Is this something that 1.0.9rc3 is likely to fix?

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
" ... new TV ad for Microsoft's Internet Explorer e-mail program which
uses the musical theme of the "Confutatis Maledictis" from Mozart's
Requiem. "Where do you want to go today?" is the cheery line on the
screen, while the chorus sings "Confutatis maledictis, flammis acribus
addictis,". This translates to "The damned and accursed are convicted
to the flames of hell."


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
