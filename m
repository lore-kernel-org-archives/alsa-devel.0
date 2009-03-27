From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [patch 1/2] alsa: ASoC driver for s6000 I2S
	interface
Date: Fri, 27 Mar 2009 17:49:33 +0100
Message-ID: <49CD039D.8070302@emlix.com>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>	<20090326141503.GD3771@sirena.org.uk>
	<49CCFA24.3020203@emlix.com> <20090327162048.GA7542@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 88A3B1037EB
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:49:33 +0100 (CET)
In-Reply-To: <20090327162048.GA7542@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/27/2009 05:20 PM, Mark Brown wrote:
>>> Any reason to expose these to users? =

> =

>> This was an attempt to avoid symbol exports..
>> I'll move everything to s6000-i2s.c and export the three necessary
>> functions.
> =

> Which functions are you exporting?  None of this looked like anything
> that I'd expect to see used outside of the driver.

s6000_i2s_start and s6000_i2s_stop are called in s6000_pcm_trigger and
s6000_i2s_int_sources is called in the interrupt handler.

s6000_i2s_start can't be called from the dai's trigger callback on playback=
 as
the data sheet is very explicit about the order of enabling dma and i2s.

s6000_i2s_stop is called there for consistency. The order on disabling is
uncritical.

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
