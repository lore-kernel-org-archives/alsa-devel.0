From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: (AT91RM2000 - ARM) Driver that puts data over SSC
 to FPGA
Date: Tue, 22 Sep 2009 08:54:12 -0700
Message-ID: <20090922155254.GA5425@sirena.org.uk>
References: <4AB8CB73.7060708@stud.fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl01-sjpop.stsn.net (s-utl01-sjpop.stsn.net [72.254.0.201])
	by alsa0.perex.cz (Postfix) with SMTP id 50D9510382B
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 17:55:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AB8CB73.7060708@stud.fh-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michel =?iso-8859-1?Q?M=FCller?= <mimu0006@stud.fh-kl.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2009 at 03:04:51PM +0200, Michel M=FCller wrote:

> I tried to figure out how I can do this with the ASoC Interfaces but I =

> am currently stuck. Currently there is an Atmel SSC and PCM Interface =

> that I can probably use. If I want to use the ASoC API I need to have a =

> Codec Driver. But I don't have direct access to the codec.

> How should I proceed? I have 2 possibilities I think: Writing a Codec =

> Driver / Writing an Alsa Driver as described in the guide of Takashi Iwai.

In this system your FPGA is doing the job of the CODEC as far as the CPU
is concerned so the most natural thing would probably be to implement a
CODEC driver for it.  This should be fairly straightforward, especially
if there's not much software control of the FPGA.
