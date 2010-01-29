From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Modify codec default
	settings
Date: Fri, 29 Jan 2010 09:01:30 +0200
Message-ID: <201001290901.30102.peter.ujfalusi@nokia.com>
References: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100128143424.GA10637@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 6901810380F
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 08:01:42 +0100 (CET)
In-Reply-To: <20100128143424.GA10637@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 January 2010 16:34:24 ext Mark Brown wrote:
> On Thu, Jan 28, 2010 at 03:57:04PM +0200, Peter Ujfalusi wrote:
> > Change the legacy default register configuration, which left some
> > internal components on.
> > Now we have either DAPM, or other ways to control these bits,
> > so there is no need to enable them by default.
> =

> Applied, thanks.  Though if they're regular DAPM controls then they
> should get turned off again during startup if they're not used.

What I have found out is that after boot these bits were set (obviously), a=
fter =

the audio activity, they were cleared (not all, since if the given DAPM con=
trol =

was not in the path, it was left enabled either way).
Now these bits are 0 after boot, and only enabled, when a certain path need=
s it.
In short: the overall power consumption was higher after boot, than what wa=
s =

after for example the playback was stopped...

-- =

P=E9ter
