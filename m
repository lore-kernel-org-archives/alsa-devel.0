From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: HDSP -- linux CardBus issue: PCMCIA driver works!
Date: Sat, 22 Jun 2002 00:29:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D13A8AE.F4855D88@folkwang-hochschule.de>
References: <20020621190320.GA1029@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Orm Finnendahl wrote:
> =

> Hi all,
> =

> I just wanted to tell you that the PCMCIA card bus interface works
> with the hdsp driver and a multiface (I only tested it with aplay and
> 2 channels so far, but think it should be possible to get the other
> channels to play as well). I first had seemingly similar problems to
> the ones posted on this list with my SuSE 7.3 distribution, but
> changed to Debian this week.
> =

> I use the unstable distribution and first had some problems getting
> PCMCIA to work. I finally succeeded in the combination of the
> kernel-pcmcia-modules-2.4.18-686 and the pcmcia-cs package (It didn't
> work with the package pcmcia-modules-2.4.18-686 which gets installed
> automatically if you install pcmcia-cs directly, so both packages had
> to be purge-removed and then reinstalled with
> kernel-pcmcia-modules... first and then the pcmcia-cs package).
> =

> I had to remove all references to my built-in soundcard from
> /etc/modules.conf (and from /etc/modules as I made an entry there as
> well) and just did a modprobe snd-hdsp right after system bootup with
> all interfaces connected and powered. The red led flashes and turns
> off and alsamixer shows the 18 outchannels of the Multiface (I don't
> know how to access the input channels yet).

you should probably pull in snd-hammerfall-mem as well. do that as early
as possible after bootup, to be sure there's still a large enough chunk
of memory available. having a second soundcard installed should not be a
problem, i've had up to three cards without any hassle:

#alsa native
options snd-emu10k1 snd_enable=3D1 snd_index=3D0
options snd-ens1371 snd_enable=3D1 snd_index=3D1
options snd snd_cards_limit=3D2 snd_major=3D116
alias snd-card-0 snd-emu10k1
alias snd-card-1 snd-ens1371

post-install snd /usr/sbin/alsactl restore
pre-remove snd /usr/sbin/alsactl store

post-install snd-seq /usr/bin/sfxload /usr/share/sounds/sf2/8MBGMSFX.SF2

#oss emulation
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-11 snd-mixer-oss
alias sound-service-0-12 snd-pcm-oss
alias sound-slot-1 snd-card-1
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-11 snd-mixer-oss
alias sound-service-1-12 snd-pcm-oss

best,

j=F6rn


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
