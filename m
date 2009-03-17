From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: twl4030 - Add VDL path support
Date: Tue, 17 Mar 2009 12:52:58 +0200
Message-ID: <200903171252.58984.peter.ujfalusi@nokia.com>
References: <49BF5F40.3020000@samsung.com>
	<200903171122.22136.peter.ujfalusi@nokia.com>
	<20090317104152.GA25698@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 456D310389B
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 11:53:30 +0100 (CET)
In-Reply-To: <20090317104152.GA25698@sirena.org.uk>
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
Cc: '?????????' <kyungmin.park@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Joonyoung Shim <jy0922.shim@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 March 2009 12:42:00 ext Mark Brown wrote:
> On Tue, Mar 17, 2009 at 11:22:21AM +0200, Peter Ujfalusi wrote:
> > Probably than it makes sense to rename the "Earpice Mux" and friends to
> > something like "Earpiece aduio Mux"...
> > So we would have two controls per outputs:
> > "Earpiece aduio Mux" (Off, DACL1, DACL2, DACR1)
> > "Earpiece voice Switch" (on, off)
> > and internally we can have "Earpiece output mixer", which mixes them
> > together.
>
> I'd suggest "HiFi" rather than "aduio" - it's all audio, it's the
> quality of the audio that's the difference here.  This naming is used
> for some other codecs.

Agree, "HiFi" is much better than "aduio" and better than "audio" also ;)

-- =

P=E9ter
