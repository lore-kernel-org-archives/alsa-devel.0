From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  [PATCH 1.0.13 1/2] M-Audio USB
Date: Fri, 24 Nov 2006 16:55:45 +0100
Message-ID: <004801c70fe1$038e8ac0$161ce4a0@supelec.fr>
References: <45667692.8090600@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45667692.8090600@inbox.ru>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Pavel Polischouk' <pavelvp@inbox.ru>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> -----Message d'origine-----
> De : alsa-devel-bounces@lists.sourceforge.net =

> [mailto:alsa-devel-bounces@lists.sourceforge.net] De la part =

> de Pavel Polischouk
> Envoy=E9 : vendredi 24 novembre 2006 05:36
> =C0 : alsa-devel@lists.sourceforge.net
> Objet : [Alsa-devel] [PATCH 1.0.13 1/2] M-Audio USB
> =

> =

> This patch adds the following capabilities to usbaudio.c:
> - Merges support for M-Audio FastTrack USB
> - Adds proper support for M-Audio Quattro USB
> - Adds hot-reload support for all Audiophile, FastTrack and Quattro. =


This sounds great and I've had a quick look at the patches which look ok for
me (at least it shouldn't break anything ;-) ).

> This works quite well on Quattro;
> Thibault, could you please verify that it works for Audiophile?

I'll check as soon as possible.
Maybe this Week-end, but I can't promise.

>  static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
>                       int iface, int altno)
>  {
> -    if (device_setup[chip->index] & AUDIOPHILE_SET) {
> -        if ((device_setup[chip->index] & AUDIOPHILE_SET_DTS)
> +    /* Reset ALL ifaces to 0 altsetting.
> +       Call it for every possible altsetting of every interface. */
> +    usb_set_interface(chip->dev, iface, 0);
> +    if (device_setup[chip->index] & MAUDIO_SET) {

Interresting, it seems to be enough to reset each interface just before
setting it again. As far as I remember, the windows driver first reset all
interfaces in a row before resetting the ones that correspond to the user
mode selected.

I'm longing to test it ;-)

Thanks,
Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
