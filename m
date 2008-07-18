From: linux@audioscience.com
Subject: [PATCH - asihpi 2/5] add control-specific query
	functions
Date: Fri, 18 Jul 2008 18:00:16 +1200
Message-ID: <1216360819-1847-2-git-send-email-linux@audioscience.com>
References: <1216360819-1847-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1216360819-1847-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 89e8143..92232f4 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -1,5 +1,5 @@
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpimsginit.h"
 
 struct hpi_handle {
@@ -493,7 +493,7 @@ u16 HPI_AdapterGetAssert(
 
 			*wAssertPresent = 1;
 
-			for (i = 0; i < STR_SIZE(HPI_STRING_LEN); i++) {
+			for (i = 0; i < HPI_STRING_LEN; i++) {
 				char c;
 				c = *Src++;
 				*Dst++ = c;
@@ -542,7 +542,7 @@ u16 HPI_AdapterGetAssertEx(
 			char *Src = (char *)hr.u.a.szAdapterAssert;
 			char *Dst = pszAssert;
 
-			for (i = 0; i < STR_SIZE(HPI_STRING_LEN); i++) {
+			for (i = 0; i < HPI_STRING_LEN; i++) {
 				char c;
 				c = *Src++;
 				*Dst++ = c;
@@ -1643,6 +1643,7 @@ u16 HPI_MixerStore(
 	return (hr.wError);
 }
 
+static
 u16 HPI_ControlParamSet(
 	const struct hpi_hsubsys *phSubSys,
 	const u32 hControl,
@@ -1662,6 +1663,7 @@ u16 HPI_ControlParamSet(
 	return (hr.wError);
 }
 
+static
 u16 HPI_ControlParamGet(
 	const struct hpi_hsubsys *phSubSys,
 	const u32 hControl,
@@ -1696,6 +1698,8 @@ u16 HPI_ControlParamGet(
 		HPI_ControlExParamGet(s, h, a, 0, 0, p1, NULL)
 #define HPI_ControlExParam2Get(s, h, a, p1, p2) \
 		HPI_ControlExParamGet(s, h, a, 0, 0, p1, p2)
+
+static
 u16 HPI_ControlQuery(
 	const struct hpi_hsubsys *phSubSys,
 	const u32 hControl,
@@ -1769,42 +1773,33 @@ static u16 HPI_Control_GetString(
 			if (c == 0)
 				break;
 		}
+
+		if ((hr.u.cu.chars8.dwRemainingChars == 0) &&
+			((subStringIndex + j) < wStringLength) && (c != 0)) {
+			c = 0;
+			pszString[subStringIndex + j] = c;
+		}
 		if (c == 0)
 			break;
 	}
 	return wHE;
 }
 
-#if 0
-
-u16 HPI_Tuner_QueryFrequency(
-	const struct hpi_hsubsys *phSubSys,
-	const u32 hTuner,
-	const u32 dwIndex,
-	const u16 band,
-	u32 *pdwFreq
-)
-{
-	return HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_FREQ,
-		dwIndex, band, pdwFreq);
-}
-
-u16 HPI_Tuner_QueryBand(
+u16 HPI_AESEBU_Receiver_QueryFormat(
 	const struct hpi_hsubsys *phSubSys,
-	const u32 hTuner,
+	const u32 hAesRx,
 	const u32 dwIndex,
-	u16 *pwBand
+	u16 *pwFormat
 )
 {
 	u32 qr;
 	u16 err;
 
-	err = HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_BAND,
+	err = HPI_ControlQuery(phSubSys, hAesRx, HPI_AESEBURX_FORMAT,
 		dwIndex, 0, &qr);
-	*pwBand = qr;
+	*pwFormat = (u16)qr;
 	return err;
 }
-#endif
 
 u16 HPI_AESEBU_Receiver_SetFormat(
 	struct hpi_hsubsys *phSubSys,
@@ -1943,6 +1938,22 @@ u16 HPI_AESEBU_Transmitter_GetChannelStatus(
 	return HPI_ERROR_INVALID_OPERATION;
 }
 
+u16 HPI_AESEBU_Transmitter_QueryFormat(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hAesTx,
+	const u32 dwIndex,
+	u16 *pwFormat
+)
+{
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hAesTx, HPI_AESEBUTX_FORMAT,
+		dwIndex, 0, &qr);
+	*pwFormat = (u16)qr;
+	return err;
+}
+
 u16 HPI_AESEBU_Transmitter_SetFormat(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2010,6 +2021,22 @@ u16 HPI_Bitstream_GetActivity(
 	return (hr.wError);
 }
 
+u16 HPI_ChannelMode_QueryMode(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hMode,
+	const u32 dwIndex,
+	u16 *pwMode
+)
+{
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hMode, HPI_CHANNEL_MODE_MODE,
+		dwIndex, 0, &qr);
+	*pwMode = (u16)qr;
+	return err;
+}
+
 u16 HPI_ChannelModeSet(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2319,6 +2346,35 @@ u16 HPI_Compander_Get(
 	return (hr.wError);
 }
 
+u16 HPI_LevelQueryRange(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	short *nMinGain_01dB,
+	short *nMaxGain_01dB,
+	short *nStepGain_01dB
+)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+	HPI_InitMessage(&hm, HPI_OBJ_CONTROL, HPI_CONTROL_GET_STATE);
+	u32TOINDEXES(hControl, &hm.wAdapterIndex, &hm.u.c.wControlIndex);
+	hm.u.c.wAttribute = HPI_LEVEL_RANGE;
+
+	HPI_Message(&hm, &hr);
+	if (hr.wError) {
+		hr.u.c.anLogValue[0] = 0;
+		hr.u.c.anLogValue[1] = 0;
+		hr.u.c.dwParam1 = 0;
+	}
+	if (nMinGain_01dB)
+		*nMinGain_01dB = hr.u.c.anLogValue[0];
+	if (nMaxGain_01dB)
+		*nMaxGain_01dB = hr.u.c.anLogValue[1];
+	if (nStepGain_01dB)
+		*nStepGain_01dB = (short)hr.u.c.dwParam1;
+	return (hr.wError);
+}
+
 u16 HPI_LevelSetGain(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2327,6 +2383,7 @@ u16 HPI_LevelSetGain(
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
+
 	HPI_InitMessage(&hm, HPI_OBJ_CONTROL, HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(hControl, &hm.wAdapterIndex, &hm.u.c.wControlIndex);
 	memcpy(hm.u.c.anLogValue, anGain0_01dB,
@@ -2357,6 +2414,16 @@ u16 HPI_LevelGetGain(
 	return (hr.wError);
 }
 
+u16 HPI_Meter_QueryChannels(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hMeter,
+	u32 *pChannels
+)
+{
+	return HPI_ControlQuery(phSubSys, hMeter, HPI_METER_NUM_CHANNELS,
+		0, 0, pChannels);
+}
+
 u16 HPI_MeterGetPeak(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2666,24 +2733,30 @@ u16 HPI_ParametricEQ_GetCoeffs(
 	return (hr.wError);
 }
 
-u16 HPI_SampleClock_SetSource(
-	struct hpi_hsubsys *phSubSys,
-	u32 hControl,
-	u16 wSource
+u16 HPI_SampleClock_QuerySource(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hClock,
+	const u32 dwIndex,
+	u16 *pwSource
 )
 {
-	return HPI_ControlParamSet(phSubSys, hControl,
-		HPI_SAMPLECLOCK_SOURCE, wSource, 0);
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hClock, HPI_SAMPLECLOCK_SOURCE,
+		dwIndex, 0, &qr);
+	*pwSource = (u16)qr;
+	return err;
 }
 
-u16 HPI_SampleClock_SetSourceIndex(
+u16 HPI_SampleClock_SetSource(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
-	u16 wSourceIndex
+	u16 wSource
 )
 {
 	return HPI_ControlParamSet(phSubSys, hControl,
-		HPI_SAMPLECLOCK_SOURCE_INDEX, wSourceIndex, 0);
+		HPI_SAMPLECLOCK_SOURCE, wSource, 0);
 }
 
 u16 HPI_SampleClock_GetSource(
@@ -2702,6 +2775,33 @@ u16 HPI_SampleClock_GetSource(
 	return (wError);
 }
 
+u16 HPI_SampleClock_QuerySourceIndex(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hClock,
+	const u32 dwIndex,
+	const u32 dwSource,
+	u16 *pwSourceIndex
+)
+{
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hClock, HPI_SAMPLECLOCK_SOURCE_INDEX,
+		dwIndex, dwSource, &qr);
+	*pwSourceIndex = (u16)qr;
+	return err;
+}
+
+u16 HPI_SampleClock_SetSourceIndex(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u16 wSourceIndex
+)
+{
+	return HPI_ControlParamSet(phSubSys, hControl,
+		HPI_SAMPLECLOCK_SOURCE_INDEX, wSourceIndex, 0);
+}
+
 u16 HPI_SampleClock_GetSourceIndex(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2718,6 +2818,20 @@ u16 HPI_SampleClock_GetSourceIndex(
 	return (wError);
 }
 
+u16 HPI_SampleClock_QueryLocalRate(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hClock,
+	const u32 dwIndex,
+	u32 *pdwRate
+)
+{
+	u16 err;
+	err = HPI_ControlQuery(phSubSys, hClock,
+		HPI_SAMPLECLOCK_LOCAL_SAMPLERATE, dwIndex, 0, pdwRate);
+
+	return err;
+}
+
 u16 HPI_SampleClock_SetLocalRate(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2760,6 +2874,26 @@ u16 HPI_SampleClock_GetSampleRate(
 	return (wError);
 }
 
+u16 HPI_SampleClock_SetAuto(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 dwAuto
+)
+{
+	return HPI_ControlParamSet(phSubSys, hControl,
+		HPI_SAMPLECLOCK_AUTO, dwAuto, 0);
+}
+
+u16 HPI_SampleClock_GetAuto(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	u32 *pdwAuto
+)
+{
+	return HPI_ControlParam1Get(phSubSys, hControl,
+		HPI_SAMPLECLOCK_AUTO, pdwAuto);
+}
+
 u16 HPI_ToneDetector_GetFrequency(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2931,6 +3065,22 @@ u16 HPI_SilenceDetector_GetThreshold(
 		HPI_SILENCEDETECTOR_THRESHOLD, 0, 0, (u32 *)Threshold, NULL);
 }
 
+u16 HPI_Tuner_QueryBand(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hTuner,
+	const u32 dwIndex,
+	u16 *pwBand
+)
+{
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_BAND,
+		dwIndex, 0, &qr);
+	*pwBand = (u16)qr;
+	return err;
+}
+
 u16 HPI_Tuner_SetBand(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -2941,14 +3091,32 @@ u16 HPI_Tuner_SetBand(
 		wBand, 0);
 }
 
-u16 HPI_Tuner_SetGain(
+u16 HPI_Tuner_GetBand(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
-	short nGain
+	u16 *pwBand
 )
 {
-	return HPI_ControlParamSet(phSubSys, hControl, HPI_TUNER_GAIN,
-		nGain, 0);
+	u32 dwBand = 0;
+	u16 nError = 0;
+
+	nError = HPI_ControlParam1Get(phSubSys, hControl,
+		HPI_TUNER_BAND, &dwBand);
+	if (pwBand)
+		*pwBand = (u16)dwBand;
+	return nError;
+}
+
+u16 HPI_Tuner_QueryFrequency(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hTuner,
+	const u32 dwIndex,
+	const u16 band,
+	u32 *pdwFreq
+)
+{
+	return HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_FREQ,
+		dwIndex, band, pdwFreq);
 }
 
 u16 HPI_Tuner_SetFrequency(
@@ -2961,20 +3129,40 @@ u16 HPI_Tuner_SetFrequency(
 		wFreqInkHz, 0);
 }
 
-u16 HPI_Tuner_GetBand(
+u16 HPI_Tuner_GetFrequency(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
-	u16 *pwBand
+	u32 *pwFreqInkHz
 )
 {
-	u32 dwBand = 0;
-	u16 nError = 0;
+	return HPI_ControlParam1Get(phSubSys, hControl, HPI_TUNER_FREQ,
+		pwFreqInkHz);
+}
 
-	nError = HPI_ControlParam1Get(phSubSys, hControl,
-		HPI_TUNER_BAND, &dwBand);
-	if (pwBand)
-		*pwBand = (u16)dwBand;
-	return nError;
+u16 HPI_Tuner_QueryGain(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hTuner,
+	const u32 dwIndex,
+	u16 *pwGain
+)
+{
+	u32 qr;
+	u16 err;
+
+	err = HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_BAND,
+		dwIndex, 0, &qr);
+	*pwGain = (u16)qr;
+	return err;
+}
+
+u16 HPI_Tuner_SetGain(
+	struct hpi_hsubsys *phSubSys,
+	u32 hControl,
+	short nGain
+)
+{
+	return HPI_ControlParamSet(phSubSys, hControl, HPI_TUNER_GAIN,
+		nGain, 0);
 }
 
 u16 HPI_Tuner_GetGain(
@@ -2993,16 +3181,6 @@ u16 HPI_Tuner_GetGain(
 	return nError;
 }
 
-u16 HPI_Tuner_GetFrequency(
-	struct hpi_hsubsys *phSubSys,
-	u32 hControl,
-	u32 *pwFreqInkHz
-)
-{
-	return HPI_ControlParam1Get(phSubSys, hControl, HPI_TUNER_FREQ,
-		pwFreqInkHz);
-}
-
 u16 HPI_Tuner_GetRFLevel(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3039,6 +3217,18 @@ u16 HPI_Tuner_GetRawRFLevel(
 	return (hr.wError);
 }
 
+u16 HPI_Tuner_QueryDeemphasis(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hTuner,
+	const u32 dwIndex,
+	const u16 band,
+	u32 *pdwDeemphasis
+)
+{
+	return HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_DEEMPHASIS,
+		dwIndex, band, pdwDeemphasis);
+}
+
 u16 HPI_Tuner_SetDeemphasis(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3059,6 +3249,16 @@ u16 HPI_Tuner_GetDeemphasis(
 		pdwDeemphasis);
 }
 
+u16 HPI_Tuner_QueryProgram(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hTuner,
+	u32 *pbitmapProgram
+)
+{
+	return HPI_ControlQuery(phSubSys, hTuner, HPI_TUNER_PROGRAM,
+		0, 0, pbitmapProgram);
+}
+
 u16 HPI_Tuner_SetProgram(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3243,6 +3443,16 @@ u16 HPI_PAD_GetRdsPI(
 		0, 0, pdwPI, NULL);
 }
 
+u16 HPI_Volume_QueryChannels(
+	const struct hpi_hsubsys *phSubSys,
+	const u32 hVolume,
+	u32 *pChannels
+)
+{
+	return HPI_ControlQuery(phSubSys, hVolume, HPI_VOLUME_NUM_CHANNELS,
+		0, 0, pChannels);
+}
+
 u16 HPI_VolumeSetGain(
 	struct hpi_hsubsys *phSubSys,
 	u32 hControl,
@@ -3322,14 +3532,13 @@ u16 HPI_VolumeAutoFadeProfile(
 	struct hpi_response hr;
 	HPI_InitMessage(&hm, HPI_OBJ_CONTROL, HPI_CONTROL_SET_STATE);
 	u32TOINDEXES(hControl, &hm.wAdapterIndex, &hm.u.c.wControlIndex);
+
 	memcpy(hm.u.c.anLogValue, anStopGain0_01dB,
 		sizeof(short) * HPI_MAX_CHANNELS);
 
-	if (wProfile < HPI_VOLUME_AUTOFADE)
-		wProfile = HPI_VOLUME_AUTOFADE;
-
-	hm.u.c.wAttribute = wProfile;
+	hm.u.c.wAttribute = HPI_VOLUME_AUTOFADE;
 	hm.u.c.dwParam1 = dwDurationMs;
+	hm.u.c.dwParam2 = wProfile;
 
 	HPI_Message(&hm, &hr);
 
@@ -3345,7 +3554,7 @@ u16 HPI_VolumeAutoFade(
 {
 	return HPI_VolumeAutoFadeProfile(phSubSys,
 		hControl,
-		anStopGain0_01dB, dwDurationMs, HPI_VOLUME_AUTOFADE);
+		anStopGain0_01dB, dwDurationMs, HPI_VOLUME_AUTOFADE_LINEAR);
 }
 
 u16 HPI_VoxSetThreshold(
@@ -3429,7 +3638,7 @@ u16 HPI_GpioReadBit(
 
 	HPI_Message(&hm, &hr);
 
-	*pwBitData = hr.u.l.wBitData;
+	*pwBitData = hr.u.l.wBitData[0];
 	return (hr.wError);
 }
 
@@ -3446,7 +3655,12 @@ u16 HPI_GpioReadAllBits(
 
 	HPI_Message(&hm, &hr);
 
-	*pwBitData = hr.u.l.wBitData;
+	if (pwBitData) {
+		pwBitData[0] = hr.u.l.wBitData[0];
+		pwBitData[1] = hr.u.l.wBitData[1];
+		pwBitData[2] = hr.u.l.wBitData[2];
+		pwBitData[3] = hr.u.l.wBitData[3];
+	}
 	return (hr.wError);
 }
 
@@ -3469,6 +3683,28 @@ u16 HPI_GpioWriteBit(
 	return (hr.wError);
 }
 
+u16 HPI_GpioWriteStatus(
+	struct hpi_hsubsys *phSubSys,
+	u32 hGpio,
+	u16 *pwBitData
+)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+	HPI_InitMessage(&hm, HPI_OBJ_GPIO, HPI_GPIO_WRITE_STATUS);
+	u32TOINDEX(hGpio, &hm.wAdapterIndex);
+
+	HPI_Message(&hm, &hr);
+
+	if (pwBitData) {
+		pwBitData[0] = hr.u.l.wBitData[0];
+		pwBitData[1] = hr.u.l.wBitData[1];
+		pwBitData[2] = hr.u.l.wBitData[2];
+		pwBitData[3] = hr.u.l.wBitData[3];
+	}
+	return (hr.wError);
+}
+
 u16 HPI_AsyncEventOpen(
 	struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
-- 
1.5.4.3
