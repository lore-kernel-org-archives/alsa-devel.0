From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/5] ASoC: tlv320dac33: Safety check for
	codec slave mode
Date: Mon, 4 Jan 2010 09:03:23 +0200
Message-ID: <201001040903.23159.peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-6-git-send-email-peter.ujfalusi@nokia.com>
	<20091231115218.GA4110@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BE0741037F1
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 08:03:54 +0100 (CET)
In-Reply-To: <20091231115218.GA4110@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Thursday 31 December 2009 13:52:19 ext Mark Brown wrote:
> On Thu, Dec 31, 2009 at 10:30:23AM +0200, Peter Ujfalusi wrote:
> > The currently available FIFO modes (mode1 and mode7) require master
> > mode from the codec.
> > Do not allow the slave configuration when the FIFO is in use.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> Ideally the mode configuration control ought to have a corresponding
> limit in it too, so that these modes can't be enabled when the device
> is configured as a slave and is active.

Well, the FIFO mode can not be changed runtime (while the playback is runni=
ng) =

for various reasons.
The control is protected against changes while the playback is running.
Since at the moment the driver only supports master mode FIFO scenarios (ex=
pect =

for the FIFO bypass mode, which should work in slave mode as well) I think =
this =

check is sufficient to ensure that the codec/cpu dai is configured correctl=
y.
As far as I know the set_dai_fmt is the place where the machine driver =

configures the codec to master/slave, so this must be the correct place for=
 a =

safety check.

-- =

P=E9ter
