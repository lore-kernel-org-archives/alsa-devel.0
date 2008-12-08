From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/8] ASoC: TWL4030: DAPM mapping of the
	PreDriv outputs
Date: Mon, 8 Dec 2008 13:40:05 +0200
Message-ID: <200812081340.05602.peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
	<20081208112847.GE5159@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 42F64103836
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:41:56 +0100 (CET)
In-Reply-To: <20081208112847.GE5159@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Monday 08 December 2008 13:28:48 ext Mark Brown wrote:
> On Mon, Dec 08, 2008 at 10:09:05AM +0200, Peter Ujfalusi wrote:
> > +static const char *twl4030_predrivel_texts[] =3D
> > +		{"Off", "DACL1 Switch", "DACL2 Switch", "Invalid",
> > +		"DACR2 Switch"};
>
> Why the "Switch" in the option names - I'd expect to see it omitted.

They will be gone.

> Does the "Invalid" option work well in applications like alsamixer?

Not quite well, the outmixer_event will just plain forbits the Invalid =

combination (returns -1, which should have been -EINVAL). In alsamixer you =

can not really select the "DACR2". With amixer you can.
I have been wondering about this for a while but could not find a better =

solution, yet.

-- =

P=E9ter
