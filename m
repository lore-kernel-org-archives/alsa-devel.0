From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC while
 changing clock
Date: Wed, 01 Apr 2009 19:16:15 +0200
Message-ID: <49D3A15F.7070105@emlix.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk> <49D374CD.20401@emlix.com>
	<20090401152421.GC21294@sirena.org.uk> <49D3947F.3010805@emlix.com>
	<20090401164847.GE21294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB701037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 19:16:15 +0200 (CEST)
In-Reply-To: <20090401164847.GE21294@sirena.org.uk>
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

On 04/01/2009 06:48 PM, Mark Brown wrote:
> On Wed, Apr 01, 2009 at 06:21:19PM +0200, Daniel Gl=F6ckner wrote:
>> It was my impression that it is up to the pcm part to install these
>> constraints as this is where SNDRV_PCM_INFO_JOINT_DUPLEX can be put into
>> the snd_pcm_hardware structure.
> =

> JOINT_DUPLEX is just a hint to the application about how the card will
> behave - you still need to enforce the actual constraints you have in
> the driver.  In any case, the PCM driver shouldn't be setting that
> unless it has such a constraint itself since it should work with the
> widest possible range of systems.

Then there needs to be a way for codecs and machines to force this bit if
the PCM driver didn't set it.

IMHO joint duplex is a hack that works only by chance.
Constraints that depend on the configuration of the first stream on open of=
 the
second stream are no longer valid when the first stream is closed.
It is also not possible to add constraints when the first stream has been o=
pened
but not yet configured.

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
