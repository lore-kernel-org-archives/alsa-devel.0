From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH=5D_ASoC=3A_TWL4030=3A_PM_fix?=
 =?iso-8859-1?q?_for_output=09amplifiers?=
Date: Tue, 23 Mar 2010 14:29:26 +0200
Message-ID: <201003231429.26268.peter.ujfalusi@nokia.com>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003230959.14186.peter.ujfalusi@nokia.com>
	<20100323100209.GA7100@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A37024498
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 13:29:40 +0100 (CET)
In-Reply-To: <20100323100209.GA7100@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 23 March 2010 12:02:10 ext Mark Brown wrote:
> On Tue, Mar 23, 2010 at 09:59:13AM +0200, Peter Ujfalusi wrote:
> > /*
> > =

> >  * Gain controls tied to outputs
> >  * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
> >  */
> > =

> > static const unsigned int output_tlv[] =3D {
> > =

> > 	TLV_DB_RANGE_HEAD(4),
> > 	0, 0, TLV_DB_SCALE_ITEM(-1200, 0,  1),
> > 	3, 3, TLV_DB_SCALE_ITEM(-600, 0, 0),
> > 	2, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
> > 	1, 1, TLV_DB_SCALE_ITEM(600, 0, 0),
> > =

> > };
> > =

> > I'm not sure about the tlv declaration, but is there a way to actually
> > map the gain/power control in the TWL in a standard way?
> =

> I'd expect that to work in that userspace will see the various values
> with the expected gains but I'd not expect that applications would
> reorder the values so it'll look odd in the UI.  But I've not actually
> tried it.

Indeed it look odd at the end:

amixer sset 'PreDriv' 0
  Front Left: Playback 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB]

amixer sset 'PreDriv' 1
  Front Left: Playback 1 [33%] [6.00dB]
  Front Right: Playback 1 [33%] [6.00dB]

amixer sset 'PreDriv' 2
  Front Left: Playback 2 [67%] [0.00dB]
  Front Right: Playback 2 [67%] [0.00dB]

amixer sset 'PreDriv' 3
  Front Left: Playback 3 [100%] [-6.00dB]
  Front Right: Playback 3 [100%] [-6.00dB

It worth a try anyway.

-- =

P=E9ter
