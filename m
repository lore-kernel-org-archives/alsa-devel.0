From: Ken McMillan <mcmillan@cadence.com>
Subject: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 18:25:41 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203241810400.9245-100000@mcmillan.cadence.com>
References: <Pine.LNX.4.33.0203220915160.711-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0203220915160.711-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I'm having a few problems with the 0.9beta11 drivers. Perhaps
someone has seen these before:

1) The device "pcm.hw:0" seems to work fine, but when I use
"pcm.plughw:0", I get "Broken pipe" from snd_pcm_writei. This happens
even with stop_threshold set to UINT_MAX (i.e., this shouldn't
be caused by underruns). 

2) I tried "snd_pcm_drain" (using the direct hw interface, not
the "plugin"), but I always get "I/O error" from this, after a few
seconds delay. On the other hand, "snd_pcm_drop" seems to work fine.

I'm using the ice1712 driver on RH 7.2, with am M-Audio Delta 44 card.

Any thoughts?

Finally, an API question: if I set stop_threshold to UINT_MAX, can I
still find out after stoping the device if there have been any
underruns?  Or do I need to monitor for this during the run?

	Thanks for any help -- Ken
