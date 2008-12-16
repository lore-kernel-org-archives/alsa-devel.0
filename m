From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: ASoC: help needed for capture DAPM (twl4030)
Date: Tue, 16 Dec 2008 11:17:49 +0200
Message-ID: <200812161117.49928.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 532C32458A
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 10:18:50 +0100 (CET)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mBG9IQq3022551
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 11:18:48 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I need some help/advice on how to implement the DAPM routings for twl4030 =

capture path.
There are at least two issues which I'm wondering at the moment.

[1] Mux for the analog paths
As with other parts, this is implemented as a bitfield, where only one bit =
can =

be enabled at the time (0x0 being no routed inputs).
ADCL <-|- Main Mix (0x1)
       |- Headset mic (0x2)
       |- AUXL, LineL (0x4)
       |- Carkit mic (0x8)
Invalid values: 0x3, 0x5, 0x6, 0x7

ADCR <-|- Sub mic (0x1)
       |- AUXR, LineR (0x4)
Invalid values: 0x2, 0x3

Since the playback path also has similar 'mux as not enum but bitfield' typ=
es, =

I'm thinking of creating a new type for soc based on the soc_enum. This new =

type would store the valid enum texts and the corresponding value in the =

register (with mask). This could be used in very flexible way. It can be al=
so =

be used instead of the normal enum types (altrough it does not make sense).
But this can wait for now.

[2] ADC versus digital microphone
TWL has two ADCs (ADCL, ADCR), the routing looks something like this, when =
the =

ADCs are in use:

InputL mux -> AmpliL -> ADCL |-> ATXL1_PGA -> Mic channel1 (I2S, TDM)
                             |-> ATXL2_PGA -> Mic channel2 (TDM)

InputR mux -> AmpliR -> ADCR |-> ATXR1_PGA -> Mic channel3 (I2S, TDM)
                             |-> ATXR2_PGA -> Mic channel4 (TDM)

When the digital microphones are in use:
Digimic0 Left  -> ATXL1_PGA -> Mic channel1 (I2S, TDM)
Digimic0 Right -> ATXR1_PGA -> Mic channel3 (I2S, TDM)

Digimic1 Left  -> ATXL2_PGA -> Mic channel2 (TDM)
Digimic1 Right -> ATXR2_PGA -> Mic channel4 (TDM)

There is a single point of selection for Mic channel1,3 and for channel2,4.
So ATXL1_PGA and ATXR1_PGA receives the data either from the ADCs or from t=
he =

digimic0, ATXL2_PGA and ATXR2_PGA receives the data either from the ADCs or =

from the digimic1.

As you can see, if the digital mic is selected the ADC can be powered off, =

since they are not needed.
How to map this with DAPM?
Is it mandatory to have the SND_SOC_DAPM_INPUT(digimic) to be connected to =

SND_SOC_DAPM_ADC?
I have been thinking to create four 'ghost ADC' for the four channel. Than =

when building the route the real ADCs can receive switches to handle the =

power management. =


Thank you,
-- =

P=E9ter
