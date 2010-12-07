From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Questions regarding ASoC
Date: Tue, 7 Dec 2010 15:30:30 +0200
Message-ID: <201012071530.30789.peter.ujfalusi@nokia.com>
References: <2A84145621092446B6659B8A0F28E26F47003D6535@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 38B69103A8C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:30:32 +0100 (CET)
In-Reply-To: <2A84145621092446B6659B8A0F28E26F47003D6535@irsmsx501.ger.corp.intel.com>
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
Cc: "ext Bensaid, Selma" <selma.bensaid@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 07 December 2010 13:05:28 ext Bensaid, Selma wrote:
> Hi,
> =

> I'm studying the transition of my ALSA Driver for TI WL1273 BT/FM into
> ASoC, and I have a question.

Take a look at sound/soc/codecs/wl1273.c
You might need the v4l2 and the MFD parts for the wl1273.
 =

> The ALSA driver already developped provided one sound card with 2 PCM
> devices: - PCM devices: BT (capture + playback)
> - FM (capture).
> These 2 devices are exclusive.

The driver in upstream at the moment handle only one DAI from the wl1273 (t=
he =

shared BT/FM dai). wl1273 actually have 2 DAI, but the dedicated FM DAI =

support is not implemented.
The codec driver can handle:
BT playback/capture (full duplex)
FM playback/capture (half duplex)
Since it is using the same DAI, BT and FM (audio) can not be used at the sa=
me =

time.

-- =

P=E9ter
