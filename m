From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH2/2] hda: Add support for IDT codecs to
 report jack presence
Date: Tue, 21 Oct 2008 11:20:35 -0400
Message-ID: <48FDF343.6080907@embeddedalley.com>
References: <48FCFAC6.8090407@embeddedalley.com>
	<20081021085543.GD10841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 7AF19247A0
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 17:21:01 +0200 (CEST)
In-Reply-To: <20081021085543.GD10841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Brown wrote:
> On Mon, Oct 20, 2008 at 05:40:22PM -0400, Matthew Ranostay wrote:
>> Add support for reporting line out, headphone, and microphone jack insertions
>> via the jack abstraction layer for the Sigmatel/IDT codec family.
> 
> The jack detection side of this looks good - I've not really reviewed
> the HDA side of things.  One comment:
> 
>> +				if (type == SND_JACK_SWITCH)
>> +					type = (pin_ctl & AC_PINCTL_HP_EN)
>> +					? SND_JACK_HEADPHONE : SND_JACK_LINEOUT;
> 
> So SND_JACK_SWITCH is just a jack that can be either headphone or
> lineout - like I said previously, you should not define a new jack type
> for this but just set both jack types when registering the jack.
> 

Ok point taken :).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj980MACgkQ7s2wy7nhBHWK0QCfThegngknAyJTiaFFFFC44ID/
qiIAn1cy4PrHYl0VAhBkyjPpQ7i710lr
=F4Hs
-----END PGP SIGNATURE-----
