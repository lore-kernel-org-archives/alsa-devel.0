From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: ATI IXP Modem driver
Date: Thu, 29 Jul 2004 18:37:16 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040729183716.5e9f7229@sashak.lan>
References: <1083465072.1639.8.camel@server.gowanlea.net>
	<20040503163657.668357a9@sashak.lan>
	<1087962001.4844.0.camel@server.gowanlea.net>
	<20040711191833.462a0b4b@sashak.lan>
	<s5hr7rhcztt.wl@alsa2.suse.de>
	<20040712162839.2c58e1c3@sashak.lan>
	<s5hd631cq5v.wl@alsa2.suse.de>
	<20040712195450.04494434@sashak.lan>
	<s5hr7rhb1tx.wl@alsa2.suse.de>
	<20040725182154.3317e5d8@sashak.lan>
	<s5hbri014jy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbri014jy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: unixtricks@btinternet.com, alsa-devel@lists.sourceforge.net, Antonis Tsolomitis <atsol@aegean.gr>, Jacques Goldberg <Jacques.Goldberg@cern.ch>
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Jul 2004 18:26:25 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> 
> Well, this will be still a problem when the audio driver is loaded
> after the modem driver.  We'll need a way to avoid the double reset on
> codecs.
> 
> How about adding a new flag to ac97 struct to indicate the shared chip
> type? 

Basically ac97 (or even ac97_bus) 'sharing' is good idea - it better
represents the real configuration.


> ac97_codec.c holds a static array, such as
> 
> 	static ac97_t *ac97_shared_codec[AC97_NUM_SHARED_CHIPS][4];
> 
> and when ac97->shared is non-zero, check the existence of the
> already-initialized codec first,
> 	if (ac97->shared && ac97_shared_codec[ac97->shared][ac97->num])
> 	{
> 		if (modem_only)
> 			...
> 		if (audio_only)
> 			...
> 	}
> 
> and set it when ready
> 	if (ac97->shared)
> 		ac97_shared_codec[ac97->shared][ac97->num] = ac97;
> 
> release it in snd_ac97_free(),
> 	if (ac97->shared)
> 		ac97_shared_codec[ac97->shared][ac97->num] = NULL;
> 
> Most likely we'll need to protect the above with mutex.

But one question about such implementation. What non-zero
'ac97-shared' should mean as index: How many shared chips will be
possible? If more that one (AC97_NUM_SHARED_CHIPS > 1), which initial
value should be used by driver? I mean how driver will know how much
'shared' buses are already in use?

Sasha.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
