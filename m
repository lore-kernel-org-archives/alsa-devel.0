From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
 while	changing clock
Date: Thu, 02 Apr 2009 12:45:03 +0200
Message-ID: <49D4972F.7040607@emlix.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk>
	<bd7b27490904020039y4616f611l53a96ef12edcf486@mail.gmail.com>
	<20090402103455.GA4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id DA37410383A
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 12:45:05 +0200 (CEST)
In-Reply-To: <20090402103455.GA4527@sirena.org.uk>
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

On 04/02/2009 12:34 PM, Mark Brown wrote:
> On Thu, Apr 02, 2009 at 10:39:12AM +0300, Jarkko Nikula wrote:
>> My two cents: It supports different sampling rates for ADC and DAC but
>> I don't believe there is practical use or HW doing this. In this setup
>> there is separate word clock signal on GPIO1 for ADC.
> =

> Hrm, that's fairly common for hardware - even with shared LRCLK many
> devices will be able to support asymmetric rates providing there are
> enough BCLKs to drive the data.  Presumably the only limit in the codec
> itself is going to be that whatever the PLL is set for will be the
> maximum.

It's only the tlv320aic33 that has GPIO pins.
On the other supported devices the datasheet says on register 98:
"Reserved. Write only 0 to these bits"

While we're at it, there are other registers where we are already writing
values !=3D 0 which are not allowed on aic31 and aic32.

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
