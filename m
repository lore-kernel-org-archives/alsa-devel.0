From: Steffen Schulz <pepe_ml@gmx.net>
Subject: Re: hda-intel on macbook: unknown model for ACL882
Date: Sat, 7 Jul 2007 20:48:57 +0200
Message-ID: <20070707184857.GA9729@cbg.dyndns.org>
References: <20070701132728.GA5827@cbg.dyndns.org>
	<20070704165022.GA8783@cbg.dyndns.org>
	<s5hmyyc6r71.wl%tiwai@suse.de>
	<20070704174328.GB15995@cbg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.rz.ruhr-uni-bochum.de (mx2.rz.ruhr-uni-bochum.de
	[134.147.64.30]) by alsa0.perex.cz (Postfix) with SMTP id C8686103822
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2007 20:48:58 +0200 (CEST)
Received: from cbg.dyndns.org (knox_zi408.hm.ruhr-uni-bochum.de [10.0.52.70])
	by mulch.hm.ruhr-uni-bochum.de (Postfix) with ESMTP id 7E0A0F522
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2007 20:49:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070704174328.GB15995@cbg.dyndns.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all, hi Takashi


someone at Ubuntuforums found some more effects with model=3Dw2jc, I
thought the info might help you to provide an update.


When I switch from 2ch to 6ch, the mic is ignored as input and I can
hear whatever is playing through the front speakers also through the
headphones when plugged to the *input*. Headphone output is still mute
(or very VERY quiet).

It is however not possible to mute or lower the speaker output without
affecting the headphone volume at the input plug.

Switching Input sources has no effect and I can't speak for SPDIF,
except the output plug's light goes on..

I can't produce any of this behaviour with model=3Dmacpro or auto.


Please ask if you need more information.


/Steffen

On 070704 at 19:47, Steffen Schulz wrote:
> On 070704 at 19:00, Takashi Iwai wrote:
> > Which ALSA version did you try?  Did you try model=3Dmacpro with the
> > latest version?
> I tried alsa from vanilla 2.6.22-rc6 as well as the drivers from recent
> rsync/svn. I compiled alsa-driver with cards=3Dhda-intel and got the same
> results as with the stock kernel drivers.
> =

> I just rsync'ed again in case something changed the last 1-2 days.
> =

> I tried all the 882-models listet in the Documentation, including
> macpro. Only with w2jc the volume levels are okay.
> =

> I get a working mic and headphones but both VERY quiet with model=3Dauto.
> PCM and Front have to be at 100% for me to actually hear something.
> =

> I get nothing from the speakers, but maybe it's to quiet.
> =

> Same with model=3Dmacpro.
> =

> With model=3Dw2jc, PCM and Front control the Speakers 'correctly', Mic
> Boost and Mic work too, but there are headphones for this model.
> =

> =

> > If it still doesn't work, attach the contents of
> > /proc/asound/card0/codec#* files, please.
> =

> Attached is codec#0 for model=3Dmacpro and w2jc.
> =

> =

> /steffen





-- =

       _----------------
 (o< =B7-_    Less CO2    |  _o)                          +49/1781384223
 //\    | for more ice! |  /\\  .o) .o)        gpg --recv-key A04D7875
 V_/_    ---------------  _\_V _(\)_(\)    mailto: pepe@cbg.dyndns.org
