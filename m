From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: Fwd: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Wed, 16 Oct 2002 18:39:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210161839.51651.styx@gentoo.org>
References: <200210161628.19666.styx@gentoo.org> <200210161826.12753.styx@gentoo.org> <s5hfzv65opd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzv65opd.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 October 2002 18:32, Takashi Iwai wrote:
> At Wed, 16 Oct 2002 18:26:12 +0200,
>
> Joachim Blaabjerg wrote:
> > On Wednesday 16 October 2002 18:12, you wrote:
> > > 8235 has the same pci id with 8233, so it's ok.
> > >
> > >
> > > Takashi
> >
> > As far as I know, though, the 8235 south bridge uses a different sound
> > chip. VT8233 uses ALC650, while VT8235 uses ALC201. Or am I wrong?
>
> yes, you are confused among two things.
>
> ALC650 and ALC201 are AC97 codecs, which corresponds to ADC/DAC and
> mixer parts.  it has nothing to do with the sound engine.
> the sound core of VT8235 is almost identical with 8233, thus via82xx
> driver is the one you need.

Ah, I see. I guess this is an alsa-user issue, then. Sorry :)

> > And no, I still can't get sound. :)
>
> please elaborate the phenomenon __on the latest driver__.
>
> * totally silent  --> check the mixer configuration?
>
> * playback produces repeated sounds --> irq problem?

That might be it. Thanks for the assistance!

Best Regards,



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
