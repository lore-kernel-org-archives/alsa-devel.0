From: Tobias Kaefer <Tobias.Kaefer@abas.de>
Subject: Re: sound-problems with ALC262
Date: Fri, 15 Aug 2008 09:19:09 +0200
Message-ID: <48A52DED.4090300@abas.de>
References: <48A27A29.4010604@abas.de>
	<s5hvdy5i6rk.wl%tiwai@suse.de>	<48A3BE15.6020403@abas.de>
	<s5hd4kc2koz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.abas.de (gate.abas.de [212.202.226.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 062D324497
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 09:19:17 +0200 (CEST)
Received: from gate.abas.de (localhost [127.0.0.1])
	by gate.abas.de (8.14.0/8.14.0) with ESMTP id m7F7JH3I000894
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 09:19:17 +0200 (CEST)
In-Reply-To: <s5hd4kc2koz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Takashi Iwai schrieb:
| At Thu, 14 Aug 2008 07:09:41 +0200,
| Tobias Kaefer wrote:
|> -----BEGIN PGP SIGNED MESSAGE-----
|> Hash: SHA1
|>
|>
|>
|> Takashi Iwai schrieb:
|> | At Wed, 13 Aug 2008 08:07:37 +0200,
|> | Tobias Kaefer wrote:
|> |> ...
|> |> "stan" told me to use this script
|> |> http://www.alsa-project.org/alsa-info.sh  to create more information
|> |> about my system. Here is the pastebin link of the output of that
script:
|> |> http://pastebin.ca/1169153
|> |
|> | At a quick glance, I see no problem in the configuration.
|> |
|> | Does the problem exist even if you play via PCM "hw" device, such as
|> |
|> | 	% aplay -Dhw foo.wav
|> |
|> | ??
|> | If your WAV file isn't with the supported format/rate, use plughw:
|> |
|> | 	% aplay -Dplughw foo.wav
|>
|> Yes. The problem still exists when using the PCM "hw" or "plughw" device.
|
| What happens when you load the driver with bdl_pos_adj=0 option?

The reverberation increases a little.
Tobias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIpS3tdJJ1JNEzpd0RAg7SAJ9CbNMKbh+TpAC7WBNzrkGDgaGxSwCfaFgh
JFhzo/0V3txO0JwWYCRahyM=
=o9ue
-----END PGP SIGNATURE-----
