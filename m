From: linux@audioscience.com
Subject: [PATCH 2/7] - const correct pointer parameters. - add
 a new stream state wait and function
Date: Tue, 23 Mar 2010 21:14:22 +1300
Message-ID: <1269332067-25959-3-git-send-email-linux@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1269332067-25959-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h          |  505 +++++++++++++++++++++++----------------------
 pci/asihpi/hpi_internal.h |   22 +-
 pci/asihpi/hpidebug.h     |    6 +-
 pci/asihpi/hpifunc.c      |  469 +++++++++++++++++++++++-------------------
 pci/asihpi/hpimsginit.c   |    2 +-
 5 files changed, 531 insertions(+), 473 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index fc45dc1..61b3565 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -32,7 +32,7 @@
  HPI_OS_WDM                       Windows WDM kernel driver
  HPI_OS_LINUX             Linux kernel driver
 
-(C) Copyright AudioScience Inc. 1998-2009
+(C) Copyright AudioScience Inc. 1998-2010
 ******************************************************************************/
 #ifndef _HPI_H_
 #define _HPI_H_
@@ -49,7 +49,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 4)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 10)
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(3, 5, 0)
@@ -199,7 +199,10 @@ enum HPI_STREAM_STATES {
 	/** State drained - playing stream ran out of data to play. */
 	HPI_STATE_DRAINED = 4,
 	/** State generate sine - to be implemented. */
-	HPI_STATE_SINEGEN = 5
+	HPI_STATE_SINEGEN = 5,
+	/** State wait - used for inter-card sync to mean waiting for all
+		cards to be ready. */
+	HPI_STATE_WAIT = 6
 };
 /******************************************* mixer source node types */
 /** Source node types
@@ -355,8 +358,7 @@ This property returns in the input and output latency in samples.
 Property 1 is the estimated input latency
 in samples, while Property 2 is that output latency in  samples.
 */
-	HPI_ADAPTER_PROPERTY_LATENCY =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 0),
+	HPI_ADAPTER_PROPERTY_LATENCY = 256,
 
 /** Readonly adapter granularity property.
 The granulariy is the smallest size chunk of stereo samples that is processed by
@@ -364,37 +366,32 @@ the adapter.
 This property returns the record granularity in samples in Property 1.
 Property 2 returns the play granularity.
 */
-	HPI_ADAPTER_PROPERTY_GRANULARITY =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 1),
+	HPI_ADAPTER_PROPERTY_GRANULARITY = 257,
 
 /** Readonly adapter number of current channels property.
 Property 1 is the number of record channels per record device.
 Property 2 is the number of play channels per playback device.*/
-	HPI_ADAPTER_PROPERTY_CURCHANNELS =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 2),
+	HPI_ADAPTER_PROPERTY_CURCHANNELS = 258,
 
 /** Readonly adapter software version.
 The SOFTWARE_VERSION property returns the version of the software running
 on the adapter as Major.Minor.Release.
 Property 1 contains Major in bits 15..8 and Minor in bits 7..0.
 Property 2 contains Release in bits 7..0. */
-	HPI_ADAPTER_PROPERTY_SOFTWARE_VERSION =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 3),
+	HPI_ADAPTER_PROPERTY_SOFTWARE_VERSION = 259,
 
 /** Readonly adapter MAC address MSBs.
 The MAC_ADDRESS_MSB property returns
 the most significant 32 bits of the MAC address.
 Property 1 contains bits 47..32 of the MAC address.
 Property 2 contains bits 31..16 of the MAC address. */
-	HPI_ADAPTER_PROPERTY_MAC_ADDRESS_MSB =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 4),
+	HPI_ADAPTER_PROPERTY_MAC_ADDRESS_MSB = 260,
 
 /** Readonly adapter MAC address LSBs
 The MAC_ADDRESS_LSB property returns
 the least significant 16 bits of the MAC address.
 Property 1 contains bits 15..0 of the MAC address. */
-	HPI_ADAPTER_PROPERTY_MAC_ADDRESS_LSB =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 5),
+	HPI_ADAPTER_PROPERTY_MAC_ADDRESS_LSB = 261,
 
 /** Readonly extended adapter type number
 The EXTENDED_ADAPTER_TYPE property returns the 4 digits of an extended
@@ -404,30 +401,49 @@ are returned for the main type
 Property 1 returns the 1st two (left most) digits, i.e "00"
 in the example above, the upper byte being the left most digit.
 Property 2 returns the 2nd two digits, i.e "22" in the example above*/
-	HPI_ADAPTER_PROPERTY_EXTENDED_ADAPTER_TYPE =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 6),
+	HPI_ADAPTER_PROPERTY_EXTENDED_ADAPTER_TYPE = 262,
 
 /** Readonly debug log buffer information */
-	HPI_ADAPTER_PROPERTY_LOGTABLEN =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 7),
-	HPI_ADAPTER_PROPERTY_LOGTABBEG =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 8),
+	HPI_ADAPTER_PROPERTY_LOGTABLEN = 263,
+	HPI_ADAPTER_PROPERTY_LOGTABBEG = 264,
 
 /** Readonly adapter IP address
 For 192.168.1.101
 Property 1 returns the 1st two (left most) digits, i.e 192*256 + 168
 in the example above, the upper byte being the left most digit.
 Property 2 returns the 2nd two digits, i.e 1*256 + 101 in the example above, */
-	HPI_ADAPTER_PROPERTY_IP_ADDRESS =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 9),
+	HPI_ADAPTER_PROPERTY_IP_ADDRESS = 265,
 
 /** Readonly adapter buffer processed count. Returns a buffer processed count
 that is incremented every time all buffers for all streams are updated. This
 is useful for checking completion of all stream operations across the adapter
 when using grouped streams.
 */
-	HPI_ADAPTER_PROPERTY_BUFFER_UPDATE_COUNT =
-		(HPI_ADAPTER_PROPERTY_READONLYBASE + 10)
+	HPI_ADAPTER_PROPERTY_BUFFER_UPDATE_COUNT = 266,
+
+/** Readonly mixer and stream intervals
+
+These intervals are  measured in mixer frames.
+To convert to time, divide  by the adapter samplerate.
+
+The mixer interval is the number of frames processed in one mixer iteration.
+The stream update interval is the interval at which streams check for and
+process data, and BBM host buffer counters are updated.
+
+Property 1 is the mixer interval in mixer frames.
+Property 2 is the stream update interval in mixer frames.
+*/
+	HPI_ADAPTER_PROPERTY_INTERVAL = 267,
+/** Adapter capabilities 1
+Property 1 - adapter can do multichannel (SSX1)
+Property 2 - adapter can do stream grouping (supports SSX2)
+*/
+	HPI_ADAPTER_PROPERTY_CAPS1 = 268,
+/** Adapter capabilities 2
+Property 1 - adapter can do samplerate conversion (MRX)
+Property 2 - adapter can do timestretch (TSX)
+*/
+	HPI_ADAPTER_PROPERTY_CAPS2 = 269
 };
 
 /** Adapter mode commands
@@ -1187,72 +1203,71 @@ struct hpi_hsubsys *HPI_SubSysCreate(
 );
 
 void HPI_SubSysFree(
-	struct hpi_hsubsys *phSubSys
+	const struct hpi_hsubsys *phSubSys
 );
 
 u16 HPI_SubSysGetVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersion
 );
 
 u16 HPI_SubSysGetVersionEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersionEx
 );
 
 u16 HPI_SubSysGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersion,
 	u16 *pwNumAdapters,
 	u16 awAdapterList[],
 	u16 wListLength
 );
 
-/* SGT added 3-2-97 */
 u16 HPI_SubSysFindAdapters(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 *pwNumAdapters,
 	u16 awAdapterList[],
 	u16 wListLength
 );
 
 u16 HPI_SubSysGetNumAdapters(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	int *pnNumAdapters
 );
 
 u16 HPI_SubSysGetAdapter(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	int nIterator,
 	u32 *pdwAdapterIndex,
 	u16 *pwAdapterType
 );
 
 u16 HPI_SubSysSsx2Bypass(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wBypass
 );
 
 u16 HPI_SubSysSetHostNetworkInterface(
-	struct hpi_hsubsys *phSubSys,
-	char *szInterface
+	const struct hpi_hsubsys *phSubSys,
+	const char *szInterface
 );
 
 /*///////// */
 /* ADAPTER */
 
 u16 HPI_AdapterOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 );
 
 u16 HPI_AdapterClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 );
 
 u16 HPI_AdapterGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *pwNumOutStreams,
 	u16 *pwNumInStreams,
@@ -1262,7 +1277,7 @@ u16 HPI_AdapterGetInfo(
 );
 
 u16 HPI_AdapterGetModuleByIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wModuleIndex,
 	u16 *pwNumOutputs,
@@ -1274,25 +1289,25 @@ u16 HPI_AdapterGetModuleByIndex(
 );
 
 u16 HPI_AdapterSetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwAdapterMode
 );
 u16 HPI_AdapterSetModeEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwAdapterMode,
 	u16 wQueryOrSet
 );
 
 u16 HPI_AdapterGetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *pdwAdapterMode
 );
 
 u16 HPI_AdapterGetAssert(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *wAssertPresent,
 	char *pszAssert,
@@ -1300,7 +1315,7 @@ u16 HPI_AdapterGetAssert(
 );
 
 u16 HPI_AdapterGetAssertEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *wAssertPresent,
 	char *pszAssert,
@@ -1309,25 +1324,25 @@ u16 HPI_AdapterGetAssertEx(
 );
 
 u16 HPI_AdapterTestAssert(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wAssertId
 );
 
 u16 HPI_AdapterEnableCapability(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wCapability,
 	u32 dwKey
 );
 
 u16 HPI_AdapterSelfTest(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 );
 
 u16 HPI_AdapterDebugRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwDspAddress,
 	char *pBytes,
@@ -1335,7 +1350,7 @@ u16 HPI_AdapterDebugRead(
 );
 
 u16 HPI_AdapterSetProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProperty,
 	u16 wParamter1,
@@ -1343,23 +1358,15 @@ u16 HPI_AdapterSetProperty(
 );
 
 u16 HPI_AdapterGetProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProperty,
 	u16 *pwParamter1,
 	u16 *pwParamter2
 );
 
-u16 HPI_AdapterFindObject(
-	const struct hpi_hsubsys *phSubSys,
-	u16 wAdapterIndex,
-	u16 wObjectType,
-	u16 wObjectIndex,
-	u16 *pDspIndex
-);
-
 u16 HPI_AdapterEnumerateProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wIndex,
 	u16 wWhatToEnumerate,
@@ -1370,21 +1377,21 @@ u16 HPI_AdapterEnumerateProperty(
 /*////////////// */
 /* NonVol Memory */
 u16 HPI_NvMemoryOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phNvMemory,
 	u16 *pwSizeInBytes
 );
 
 u16 HPI_NvMemoryReadByte(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hNvMemory,
 	u16 wIndex,
 	u16 *pwData
 );
 
 u16 HPI_NvMemoryWriteByte(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hNvMemory,
 	u16 wIndex,
 	u16 wData
@@ -1393,7 +1400,7 @@ u16 HPI_NvMemoryWriteByte(
 /*////////////// */
 /* Digital I/O */
 u16 HPI_GpioOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phGpio,
 	u16 *pwNumberInputBits,
@@ -1401,27 +1408,27 @@ u16 HPI_GpioOpen(
 );
 
 u16 HPI_GpioReadBit(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 wBitIndex,
 	u16 *pwBitData
 );
 
 u16 HPI_GpioReadAllBits(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 awAllBitData[4]
 );
 
 u16 HPI_GpioWriteBit(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 wBitIndex,
 	u16 wBitData
 );
 
 u16 HPI_GpioWriteStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 awAllBitData[4]
 );
@@ -1430,18 +1437,18 @@ u16 HPI_GpioWriteStatus(
 /* Async Event Object */
 /**********************/
 u16 HPI_AsyncEventOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phAsync
 );
 
 u16 HPI_AsyncEventClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync
 );
 
 u16 HPI_AsyncEventWait(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 wMaximumEvents,
 	struct hpi_async_event *pEvents,
@@ -1449,13 +1456,13 @@ u16 HPI_AsyncEventWait(
 );
 
 u16 HPI_AsyncEventGetCount(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 *pwCount
 );
 
 u16 HPI_AsyncEventGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 wMaximumEvents,
 	struct hpi_async_event *pEvents,
@@ -1465,19 +1472,19 @@ u16 HPI_AsyncEventGet(
 /*/////////// */
 /* WATCH-DOG  */
 u16 HPI_WatchdogOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phWatchdog
 );
 
 u16 HPI_WatchdogSetTime(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hWatchdog,
 	u32 dwTimeMillisec
 );
 
 u16 HPI_WatchdogPing(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hWatchdog
 );
 
@@ -1485,19 +1492,19 @@ u16 HPI_WatchdogPing(
 /* OUT STREAM */
 /**************/
 u16 HPI_OutStreamOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wOutStreamIndex,
 	u32 *phOutStream
 );
 
 u16 HPI_OutStreamClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamGetInfoEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u16 *pwState,
 	u32 *pdwBufferSize,
@@ -1507,72 +1514,77 @@ u16 HPI_OutStreamGetInfoEx(
 );
 
 u16 HPI_OutStreamWriteBuf(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
-	u8 *pbWriteBuf,
+	const u8 *pbWriteBuf,
 	u32 dwBytesToWrite,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 );
 
 u16 HPI_OutStreamStart(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
+	u32 hOutStream
+);
+
+u16 HPI_OutStreamWaitStart(
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamStop(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamSinegen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamQueryFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_format *pFormat
 );
 
 u16 HPI_OutStreamSetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_format *pFormat
 );
 
 u16 HPI_OutStreamSetPunchInOut(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwPunchInSample,
 	u32 dwPunchOutSample
 );
 
 u16 HPI_OutStreamSetVelocity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	short nVelocity
 );
 
 u16 HPI_OutStreamAncillaryReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u16 wMode
 );
 
 u16 HPI_OutStreamAncillaryGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 *pdwFramesAvailable
 );
 
 u16 HPI_OutStreamAncillaryRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_anc_frame *pAncFrameBuffer,
 	u32 dwAncFrameBufferSizeInBytes,
@@ -1580,90 +1592,95 @@ u16 HPI_OutStreamAncillaryRead(
 );
 
 u16 HPI_OutStreamSetTimeScale(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwTimeScaleX10000
 );
 
 u16 HPI_OutStreamHostBufferAllocate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwSizeInBytes
 );
 
 u16 HPI_OutStreamHostBufferFree(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 u16 HPI_OutStreamGroupAdd(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 hStream
 );
 
 u16 HPI_OutStreamGroupGetMap(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 *pdwOutStreamMap,
 	u32 *pdwInStreamMap
 );
 
 u16 HPI_OutStreamGroupReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 );
 
 /*////////// */
 /* IN_STREAM */
 u16 HPI_InStreamOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wInStreamIndex,
 	u32 *phInStream
 );
 
 u16 HPI_InStreamClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
 u16 HPI_InStreamQueryFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 );
 
 u16 HPI_InStreamSetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 );
 
 u16 HPI_InStreamReadBuf(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u8 *pbReadBuf,
 	u32 dwBytesToRead
 );
 
 u16 HPI_InStreamStart(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
+	u32 hInStream
+);
+
+u16 HPI_InStreamWaitStart(
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
 u16 HPI_InStreamStop(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
 u16 HPI_InStreamReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
 u16 HPI_InStreamGetInfoEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u16 *pwState,
 	u32 *pdwBufferSize,
@@ -1673,7 +1690,7 @@ u16 HPI_InStreamGetInfoEx(
 );
 
 u16 HPI_InStreamAncillaryReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u16 wBytesPerFrame,
 	u16 wMode,
@@ -1682,45 +1699,45 @@ u16 HPI_InStreamAncillaryReset(
 );
 
 u16 HPI_InStreamAncillaryGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 *pdwFrameSpace
 );
 
 u16 HPI_InStreamAncillaryWrite(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_anc_frame *pAncFrameBuffer,
+	const struct hpi_anc_frame *pAncFrameBuffer,
 	u32 dwAncFrameBufferSizeInBytes,
 	u32 dwNumberOfAncillaryFramesToWrite
 );
 
 u16 HPI_InStreamHostBufferAllocate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 dwSizeInBytes
 );
 
 u16 HPI_InStreamHostBufferFree(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
 u16 HPI_InStreamGroupAdd(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 hStream
 );
 
 u16 HPI_InStreamGroupGetMap(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 *pdwOutStreamMap,
 	u32 *pdwInStreamMap
 );
 
 u16 HPI_InStreamGroupReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 );
 
@@ -1728,18 +1745,18 @@ u16 HPI_InStreamGroupReset(
 /* MIXER */
 /*********/
 u16 HPI_MixerOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phMixer
 );
 
 u16 HPI_MixerClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer
 );
 
 u16 HPI_MixerGetControl(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	u16 wSrcNodeType,
 	u16 wSrcNodeTypeIndex,
@@ -1750,7 +1767,7 @@ u16 HPI_MixerGetControl(
 );
 
 u16 HPI_MixerGetControlByIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	u16 wControlIndex,
 	u16 *pwSrcNodeType,
@@ -1762,7 +1779,7 @@ u16 HPI_MixerGetControlByIndex(
 );
 
 u16 HPI_MixerStore(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	enum HPI_MIXER_STORE_COMMAND Command,
 	u16 wIndex
@@ -1774,20 +1791,20 @@ u16 HPI_MixerStore(
 /* volume control                */
 /*************************/
 u16 HPI_VolumeSetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB[HPI_MAX_CHANNELS]
 );
 
 u16 HPI_VolumeGetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB_out[HPI_MAX_CHANNELS]
 );
 
 #define HPI_VolumeGetRange HPI_VolumeQueryRange
 u16 HPI_VolumeQueryRange(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *nMinGain_01dB,
 	short *nMaxGain_01dB,
@@ -1801,14 +1818,14 @@ u16 HPI_Volume_QueryChannels(
 );
 
 u16 HPI_VolumeAutoFade(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anStopGain0_01dB[HPI_MAX_CHANNELS],
 	u32 wDurationMs
 );
 
 u16 HPI_VolumeAutoFadeProfile(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anStopGain0_01dB[HPI_MAX_CHANNELS],
 	u32 dwDurationMs,
@@ -1819,7 +1836,7 @@ u16 HPI_VolumeAutoFadeProfile(
 /* level control         */
 /*************************/
 u16 HPI_LevelQueryRange(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *nMinGain_01dB,
 	short *nMaxGain_01dB,
@@ -1827,13 +1844,13 @@ u16 HPI_LevelQueryRange(
 );
 
 u16 HPI_LevelSetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB[HPI_MAX_CHANNELS]
 );
 
 u16 HPI_LevelGetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB_out[HPI_MAX_CHANNELS]
 );
@@ -1848,40 +1865,40 @@ u16 HPI_Meter_QueryChannels(
 );
 
 u16 HPI_MeterGetPeak(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anPeak0_01dB_out[HPI_MAX_CHANNELS]
 );
 
 u16 HPI_MeterGetRms(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anPeak0_01dB_out[HPI_MAX_CHANNELS]
 );
 
 u16 HPI_MeterSetPeakBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 nAttack,
 	u16 nDecay
 );
 
 u16 HPI_MeterSetRmsBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 nAttack,
 	u16 nDecay
 );
 
 u16 HPI_MeterGetPeakBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *nAttack,
 	u16 *nDecay
 );
 
 u16 HPI_MeterGetRmsBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *nAttack,
 	u16 *nDecay
@@ -1898,13 +1915,13 @@ u16 HPI_ChannelMode_QueryMode(
 );
 
 u16 HPI_ChannelModeSet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wMode
 );
 
 u16 HPI_ChannelModeGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *wMode
 );
@@ -1920,13 +1937,13 @@ u16 HPI_Tuner_QueryBand(
 );
 
 u16 HPI_Tuner_SetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wBand
 );
 
 u16 HPI_Tuner_GetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwBand
 );
@@ -1940,25 +1957,25 @@ u16 HPI_Tuner_QueryFrequency(
 );
 
 u16 HPI_Tuner_SetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 wFreqInkHz
 );
 
 u16 HPI_Tuner_GetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pwFreqInkHz
 );
 
 u16 HPI_Tuner_GetRFLevel(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pwLevel
 );
 
 u16 HPI_Tuner_GetRawRFLevel(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pwLevel
 );
@@ -1971,40 +1988,40 @@ u16 HPI_Tuner_QueryGain(
 );
 
 u16 HPI_Tuner_SetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short nGain
 );
 
 u16 HPI_Tuner_GetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pnGain
 );
 
 u16 HPI_Tuner_GetStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwStatusMask,
 	u16 *pwStatus
 );
 
 u16 HPI_Tuner_SetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 nMode,
 	u32 nValue
 );
 
 u16 HPI_Tuner_GetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 nMode,
 	u32 *pnValue
 );
 
 u16 HPI_Tuner_GetRDS(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pRdsData
 );
@@ -2018,12 +2035,12 @@ u16 HPI_Tuner_QueryDeemphasis(
 );
 
 u16 HPI_Tuner_SetDeemphasis(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwDeemphasis
 );
 u16 HPI_Tuner_GetDeemphasis(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwDeemphasis
 );
@@ -2035,33 +2052,33 @@ u16 HPI_Tuner_QueryProgram(
 );
 
 u16 HPI_Tuner_SetProgram(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwProgram
 );
 
 u16 HPI_Tuner_GetProgram(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwProgram
 );
 
 u16 HPI_Tuner_GetHdRadioDspVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszDspVersion,
 	const u32 dwStringSize
 );
 
 u16 HPI_Tuner_GetHdRadioSdkVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszSdkVersion,
 	const u32 dwStringSize
 );
 
 u16 HPI_Tuner_GetHdRadioSignalQuality(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwQuality
 );
@@ -2071,47 +2088,47 @@ u16 HPI_Tuner_GetHdRadioSignalQuality(
 /****************************/
 
 u16 HPI_PAD_GetChannelName(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwStringLength
 );
 
 u16 HPI_PAD_GetArtist(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwStringLength
 );
 
 u16 HPI_PAD_GetTitle(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwStringLength
 );
 
 u16 HPI_PAD_GetComment(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwStringLength
 );
 
 u16 HPI_PAD_GetProgramType(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwPTY
 );
 
 u16 HPI_PAD_GetRdsPI(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwPI
 );
 
 u16 HPI_PAD_GetProgramTypeString(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	const u32 dwDataType,
 	const u32 nPTY,
@@ -2130,39 +2147,39 @@ u16 HPI_AESEBU_Receiver_QueryFormat(
 );
 
 u16 HPI_AESEBU_Receiver_SetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSource
 );
 
 u16 HPI_AESEBU_Receiver_GetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwSource
 );
 
 u16 HPI_AESEBU_Receiver_GetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 );
 
 u16 HPI_AESEBU_Receiver_GetUserData(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
 );
 
 u16 HPI_AESEBU_Receiver_GetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
 );
 
 u16 HPI_AESEBU_Receiver_GetErrorStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwErrorData
 );
@@ -2171,27 +2188,27 @@ u16 HPI_AESEBU_Receiver_GetErrorStatus(
 /* AES/EBU Transmitter control */
 /*******************************/
 u16 HPI_AESEBU_Transmitter_SetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwSampleRate
 );
 
 u16 HPI_AESEBU_Transmitter_SetUserData(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 wData
 );
 
 u16 HPI_AESEBU_Transmitter_SetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 wData
 );
 
 u16 HPI_AESEBU_Transmitter_GetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
@@ -2205,13 +2222,13 @@ u16 HPI_AESEBU_Transmitter_QueryFormat(
 );
 
 u16 HPI_AESEBU_Transmitter_SetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOutputFormat
 );
 
 u16 HPI_AESEBU_Transmitter_GetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwOutputFormat
 );
@@ -2220,21 +2237,21 @@ u16 HPI_AESEBU_Transmitter_GetFormat(
 /* multiplexer control */
 /***********************/
 u16 HPI_Multiplexer_SetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSourceNodeType,
 	u16 wSourceNodeIndex
 );
 
 u16 HPI_Multiplexer_GetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *wSourceNodeType,
 	u16 *wSourceNodeIndex
 );
 
 u16 HPI_Multiplexer_QuerySource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 nIndex,
 	u16 *wSourceNodeType,
@@ -2245,13 +2262,13 @@ u16 HPI_Multiplexer_QuerySource(
 /* VOX control */
 /***************/
 u16 HPI_VoxSetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB
 );
 
 u16 HPI_VoxGetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *anGain0_01dB
 );
@@ -2260,19 +2277,19 @@ u16 HPI_VoxGetThreshold(
 /* Bitstream control */
 /*********************/
 u16 HPI_Bitstream_SetClockEdge(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wEdgeType
 );
 
 u16 HPI_Bitstream_SetDataPolarity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wPolarity
 );
 
 u16 HPI_Bitstream_GetActivity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwClkActivity,
 	u16 *pwDataActivity
@@ -2290,13 +2307,13 @@ u16 HPI_SampleClock_QuerySource(
 );
 
 u16 HPI_SampleClock_SetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSource
 );
 
 u16 HPI_SampleClock_GetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwSource
 );
@@ -2310,19 +2327,19 @@ u16 HPI_SampleClock_QuerySourceIndex(
 );
 
 u16 HPI_SampleClock_SetSourceIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSourceIndex
 );
 
 u16 HPI_SampleClock_GetSourceIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwSourceIndex
 );
 
 u16 HPI_SampleClock_GetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 );
@@ -2335,37 +2352,37 @@ u16 HPI_SampleClock_QueryLocalRate(
 );
 
 u16 HPI_SampleClock_SetLocalRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwSampleRate
 );
 
 u16 HPI_SampleClock_GetLocalRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 );
 
 u16 HPI_SampleClock_SetAuto(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwAuto
 );
 
 u16 HPI_SampleClock_GetAuto(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwAuto
 );
 
 u16 HPI_SampleClock_SetLocalRateLock(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwLock
 );
 
 u16 HPI_SampleClock_GetLocalRateLock(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwLock
 );
@@ -2374,13 +2391,13 @@ u16 HPI_SampleClock_GetLocalRateLock(
 /* Microphone control */
 /***********************/
 u16 HPI_Microphone_SetPhantomPower(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOnOff
 );
 
 u16 HPI_Microphone_GetPhantomPower(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwOnOff
 );
@@ -2389,20 +2406,20 @@ u16 HPI_Microphone_GetPhantomPower(
   Parametric Equalizer control
 *******************************/
 u16 HPI_ParametricEQ_GetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwNumberOfBands,
 	u16 *pwEnabled
 );
 
 u16 HPI_ParametricEQ_SetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOnOff
 );
 
 u16 HPI_ParametricEQ_SetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 nType,
@@ -2412,7 +2429,7 @@ u16 HPI_ParametricEQ_SetBand(
 );
 
 u16 HPI_ParametricEQ_GetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pnType,
@@ -2422,7 +2439,7 @@ u16 HPI_ParametricEQ_GetBand(
 );
 
 u16 HPI_ParametricEQ_GetCoeffs(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	short coeffs[5]
@@ -2433,7 +2450,7 @@ u16 HPI_ParametricEQ_GetCoeffs(
 *******************************/
 
 u16 HPI_Compander_Set(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wAttack,
 	u16 wDecay,
@@ -2443,7 +2460,7 @@ u16 HPI_Compander_Set(
 );
 
 u16 HPI_Compander_Get(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwAttack,
 	u16 *pwDecay,
@@ -2456,7 +2473,7 @@ u16 HPI_Compander_Get(
   Cobranet HMI control
 *******************************/
 u16 HPI_Cobranet_HmiWrite(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwHmiAddress,
 	u32 dwByteCount,
@@ -2464,7 +2481,7 @@ u16 HPI_Cobranet_HmiWrite(
 );
 
 u16 HPI_Cobranet_HmiRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwHmiAddress,
 	u32 dwMaxByteCount,
@@ -2473,7 +2490,7 @@ u16 HPI_Cobranet_HmiRead(
 );
 
 u16 HPI_Cobranet_HmiGetStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwStatus,
 	u32 *pdwReadableSize,
@@ -2483,35 +2500,35 @@ u16 HPI_Cobranet_HmiGetStatus(
 /*Read the current IP address
 */
 u16 HPI_Cobranet_GetIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwIPaddress
 );
 /* Write the current IP address
 */
 u16 HPI_Cobranet_SetIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwIPaddress
 );
 /* Read the static IP address
 */
 u16 HPI_Cobranet_GetStaticIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwIPaddress
 );
 /* Write the static IP address
 */
 u16 HPI_Cobranet_SetStaticIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwIPaddress
 );
 /* Read the MAC address
 */
 u16 HPI_Cobranet_GetMACaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwMAC_MSBs,
 	u32 *pdwMAC_LSBs
@@ -2520,49 +2537,49 @@ u16 HPI_Cobranet_GetMACaddress(
   Tone Detector control
 *******************************/
 u16 HPI_ToneDetector_GetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *State
 );
 
 u16 HPI_ToneDetector_SetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 Enable
 );
 
 u16 HPI_ToneDetector_GetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *Enable
 );
 
 u16 HPI_ToneDetector_SetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 EventEnable
 );
 
 u16 HPI_ToneDetector_GetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *EventEnable
 );
 
 u16 HPI_ToneDetector_SetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	int Threshold
 );
 
 u16 HPI_ToneDetector_GetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	int *Threshold
 );
 
 u16 HPI_ToneDetector_GetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 nIndex,
 	u32 *dwFrequency
@@ -2572,57 +2589,55 @@ u16 HPI_ToneDetector_GetFrequency(
   Silence Detector control
 *******************************/
 u16 HPI_SilenceDetector_GetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *State
 );
 
 u16 HPI_SilenceDetector_SetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 Enable
 );
 
 u16 HPI_SilenceDetector_GetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *Enable
 );
 
 u16 HPI_SilenceDetector_SetEventEnable(
-	struct hpi_hsubsys
-	*phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 EventEnable
 );
 
 u16 HPI_SilenceDetector_GetEventEnable(
-	struct hpi_hsubsys
-	*phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *EventEnable
 );
 
 u16 HPI_SilenceDetector_SetDelay(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 Delay
 );
 
 u16 HPI_SilenceDetector_GetDelay(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	u32 *Delay
 );
 
 u16 HPI_SilenceDetector_SetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	int Threshold
 );
 
 u16 HPI_SilenceDetector_GetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	int *Threshold
 );
@@ -2666,19 +2681,19 @@ void HPI_Entity_Free(
 );
 
 u16 HPI_Universal_Info(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity **info
 );
 
 u16 HPI_Universal_Get(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity **value
 );
 
 u16 HPI_Universal_Set(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity *value
 );
@@ -2687,13 +2702,13 @@ u16 HPI_Universal_Set(
 /* DSP CLOCK  */
 /*/////////// */
 u16 HPI_ClockOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phDspClock
 );
 
 u16 HPI_ClockSetTime(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hClock,
 	u16 wHour,
 	u16 wMinute,
@@ -2702,7 +2717,7 @@ u16 HPI_ClockSetTime(
 );
 
 u16 HPI_ClockGetTime(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hClock,
 	u16 *pwHour,
 	u16 *pwMinute,
@@ -2714,7 +2729,7 @@ u16 HPI_ClockGetTime(
 /* PROFILE        */
 /*/////////// */
 u16 HPI_ProfileOpenAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProfileIndex,
 	u32 *phProfile,
@@ -2722,7 +2737,7 @@ u16 HPI_ProfileOpenAll(
 );
 
 u16 HPI_ProfileGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u16 wIndex,
 	u16 *pwSeconds,
@@ -2733,17 +2748,17 @@ u16 HPI_ProfileGet(
 );
 
 u16 HPI_ProfileStartAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile
 );
 
 u16 HPI_ProfileStopAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile
 );
 
 u16 HPI_ProfileGetName(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u16 wIndex,
 	char *szProfileName,
@@ -2751,7 +2766,7 @@ u16 HPI_ProfileGetName(
 );
 
 u16 HPI_ProfileGetUtilization(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u32 *pdwUtilization
 );
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 77d9464..77b85e4 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -607,7 +607,8 @@ Threshold is a -ve number in units of dB/100,
 #define HPI_OSTREAM_GROUP_GETMAP        HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 21)
 #define HPI_OSTREAM_GROUP_RESET         HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 22)
 #define HPI_OSTREAM_HOSTBUFFER_GET_INFO HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 23)
-#define HPI_OSTREAM_FUNCTION_COUNT              23
+#define HPI_OSTREAM_WAIT_START          HPI_MAKE_INDEX(HPI_OBJ_OSTREAM, 24)
+#define HPI_OSTREAM_FUNCTION_COUNT              24
 /* INPUT STREAM */
 #define HPI_ISTREAM_OPEN                HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 1)
 #define HPI_ISTREAM_CLOSE               HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 2)
@@ -627,7 +628,8 @@ Threshold is a -ve number in units of dB/100,
 #define HPI_ISTREAM_GROUP_GETMAP        HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 16)
 #define HPI_ISTREAM_GROUP_RESET         HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 17)
 #define HPI_ISTREAM_HOSTBUFFER_GET_INFO HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 18)
-#define HPI_ISTREAM_FUNCTION_COUNT              18
+#define HPI_ISTREAM_WAIT_START          HPI_MAKE_INDEX(HPI_OBJ_ISTREAM, 19)
+#define HPI_ISTREAM_FUNCTION_COUNT              19
 /* MIXER */
 /* NOTE:
    GET_NODE_INFO, SET_CONNECTION, GET_CONNECTIONS are not currently used */
@@ -713,8 +715,8 @@ struct hpi_pci {
 
 struct hpi_resource {
 	union {
-		struct hpi_pci *Pci;
-		char *net_if;
+		const struct hpi_pci *Pci;
+		const char *net_if;
 	} r;
 #ifndef HPI64BIT		/* keep structure size constant */
 	u32 dwPadTo64;
@@ -1646,25 +1648,25 @@ void HPI_MessageUDP(
 
 /* used in PnP OS/driver */
 u16 HPI_SubSysCreateAdapter(
-	struct hpi_hsubsys *phSubSys,
-	struct hpi_resource *pResource,
+	const struct hpi_hsubsys *phSubSys,
+	const struct hpi_resource *pResource,
 	u16 *pwAdapterIndex
 );
 
 u16 HPI_SubSysDeleteAdapter(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 );
 
 u16 HPI_OutStreamHostBufferGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u8 **ppBuffer,
 	struct hpi_hostbuffer_status **ppStatus
 );
 
 u16 HPI_InStreamHostBufferGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u8 **ppBuffer,
 	struct hpi_hostbuffer_status **ppStatus
@@ -1683,7 +1685,7 @@ compatibility.
 
 void HPI_FormatToMsg(
 	struct hpi_msg_format *pMF,
-	struct hpi_format *pF
+	const struct hpi_format *pF
 );
 void HPI_StreamResponseToLegacy(
 	struct hpi_stream_res *pSR
diff --git a/pci/asihpi/hpidebug.h b/pci/asihpi/hpidebug.h
index a280105..b20ec06 100644
--- a/pci/asihpi/hpidebug.h
+++ b/pci/asihpi/hpidebug.h
@@ -217,8 +217,9 @@ function_count_check(HPI_ADAPTER, 18);
   "HPI_OSTREAM_GROUP_GETMAP", \
   "HPI_OSTREAM_GROUP_RESET", \
   "HPI_OSTREAM_HOSTBUFFER_GET_INFO", \
+  "HPI_OSTREAM_WAIT_START", \
 }
-function_count_check(HPI_OSTREAM, 23);
+function_count_check(HPI_OSTREAM, 24);
 
 #define HPI_ISTREAM_STRINGS     \
 {                               \
@@ -240,8 +241,9 @@ function_count_check(HPI_OSTREAM, 23);
   "HPI_ISTREAM_GROUP_GETMAP", \
   "HPI_ISTREAM_GROUP_RESET", \
   "HPI_ISTREAM_HOSTBUFFER_GET_INFO", \
+  "HPI_ISTREAM_WAIT_START", \
 }
-function_count_check(HPI_ISTREAM, 18);
+function_count_check(HPI_ISTREAM, 19);
 
 #define HPI_MIXER_STRINGS       \
 {                               \
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 183496a..805618f 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -75,7 +75,7 @@ do {\
 
 void HPI_FormatToMsg(
 	struct hpi_msg_format *pMF,
-	struct hpi_format *pF
+	const struct hpi_format *pF
 )
 {
 	pMF->dwSampleRate = pF->dwSampleRate;
@@ -132,7 +132,7 @@ struct hpi_hsubsys *HPI_SubSysCreate(
 }
 
 void HPI_SubSysFree(
-	struct hpi_hsubsys *phSubSys
+	const struct hpi_hsubsys *phSubSys
 )
 {
 	struct hpi_message hm;
@@ -145,7 +145,7 @@ void HPI_SubSysFree(
 }
 
 u16 HPI_SubSysGetVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersion
 )
 {
@@ -160,7 +160,7 @@ u16 HPI_SubSysGetVersion(
 }
 
 u16 HPI_SubSysGetVersionEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersionEx
 )
 {
@@ -175,7 +175,7 @@ u16 HPI_SubSysGetVersionEx(
 }
 
 u16 HPI_SubSysGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 *pdwVersion,
 	u16 *pwNumAdapters,
 	u16 awAdapterList[],
@@ -200,7 +200,7 @@ u16 HPI_SubSysGetInfo(
 }
 
 u16 HPI_SubSysFindAdapters(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 *pwNumAdapters,
 	u16 awAdapterList[],
 	u16 wListLength
@@ -227,8 +227,8 @@ u16 HPI_SubSysFindAdapters(
 }
 
 u16 HPI_SubSysCreateAdapter(
-	struct hpi_hsubsys *phSubSys,
-	struct hpi_resource *pResource,
+	const struct hpi_hsubsys *phSubSys,
+	const struct hpi_resource *pResource,
 	u16 *pwAdapterIndex
 )
 {
@@ -246,7 +246,7 @@ u16 HPI_SubSysCreateAdapter(
 }
 
 u16 HPI_SubSysDeleteAdapter(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 )
 {
@@ -260,7 +260,7 @@ u16 HPI_SubSysDeleteAdapter(
 }
 
 u16 HPI_SubSysGetNumAdapters(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	int *pnNumAdapters
 )
 {
@@ -274,7 +274,7 @@ u16 HPI_SubSysGetNumAdapters(
 }
 
 u16 HPI_SubSysGetAdapter(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	int nIterator,
 	u32 *pdwAdapterIndex,
 	u16 *pwAdapterType
@@ -292,8 +292,8 @@ u16 HPI_SubSysGetAdapter(
 }
 
 u16 HPI_SubSysSetHostNetworkInterface(
-	struct hpi_hsubsys *phSubSys,
-	char *szInterface
+	const struct hpi_hsubsys *phSubSys,
+	const char *szInterface
 )
 {
 	struct hpi_message hm;
@@ -308,7 +308,7 @@ u16 HPI_SubSysSetHostNetworkInterface(
 }
 
 u16 HPI_AdapterOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 )
 {
@@ -324,7 +324,7 @@ u16 HPI_AdapterOpen(
 }
 
 u16 HPI_AdapterClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 )
 {
@@ -350,7 +350,7 @@ u16 HPI_AdapterFindObject(
 }
 
 u16 HPI_AdapterSetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwAdapterMode
 )
@@ -360,7 +360,7 @@ u16 HPI_AdapterSetMode(
 }
 
 u16 HPI_AdapterSetModeEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwAdapterMode,
 	u16 wQueryOrSet
@@ -378,7 +378,7 @@ u16 HPI_AdapterSetModeEx(
 }
 
 u16 HPI_AdapterGetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *pdwAdapterMode
 )
@@ -395,7 +395,7 @@ u16 HPI_AdapterGetMode(
 }
 
 u16 HPI_AdapterGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *pwNumOutStreams,
 	u16 *pwNumInStreams,
@@ -421,7 +421,7 @@ u16 HPI_AdapterGetInfo(
 }
 
 u16 HPI_AdapterGetModuleByIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wModuleIndex,
 	u16 *pwNumOutputs,
@@ -453,7 +453,7 @@ u16 HPI_AdapterGetModuleByIndex(
 }
 
 u16 HPI_AdapterGetAssert(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *wAssertPresent,
 	char *pszAssert,
@@ -494,7 +494,7 @@ u16 HPI_AdapterGetAssert(
 }
 
 u16 HPI_AdapterGetAssertEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 *wAssertPresent,
 	char *pszAssert,
@@ -546,7 +546,7 @@ u16 HPI_AdapterGetAssertEx(
 }
 
 u16 HPI_AdapterTestAssert(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wAssertId
 )
@@ -564,7 +564,7 @@ u16 HPI_AdapterTestAssert(
 }
 
 u16 HPI_AdapterEnableCapability(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wCapability,
 	u32 dwKey
@@ -584,7 +584,7 @@ u16 HPI_AdapterEnableCapability(
 }
 
 u16 HPI_AdapterSelfTest(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex
 )
 {
@@ -598,7 +598,7 @@ u16 HPI_AdapterSelfTest(
 }
 
 u16 HPI_AdapterDebugRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 dwDspAddress,
 	char *pBuffer,
@@ -631,7 +631,7 @@ u16 HPI_AdapterDebugRead(
 }
 
 u16 HPI_AdapterSetProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProperty,
 	u16 wParameter1,
@@ -653,7 +653,7 @@ u16 HPI_AdapterSetProperty(
 }
 
 u16 HPI_AdapterGetProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProperty,
 	u16 *pwParameter1,
@@ -679,7 +679,7 @@ u16 HPI_AdapterGetProperty(
 }
 
 u16 HPI_AdapterEnumerateProperty(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wIndex,
 	u16 wWhatToEnumerate,
@@ -834,7 +834,7 @@ u16 HPI_StreamEstimateBufferSize(
 }
 
 u16 HPI_OutStreamOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wOutStreamIndex,
 	u32 *phOutStream
@@ -858,7 +858,7 @@ u16 HPI_OutStreamOpen(
 }
 
 u16 HPI_OutStreamClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -870,17 +870,20 @@ u16 HPI_OutStreamClose(
 	u32TOINDEXES(hOutStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
-	hm.wFunction = HPI_OSTREAM_GROUP_RESET;
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM,
+		HPI_OSTREAM_GROUP_RESET);
+	u32TOINDEXES(hOutStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
-	hm.wFunction = HPI_OSTREAM_CLOSE;
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM, HPI_OSTREAM_CLOSE);
+	u32TOINDEXES(hOutStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
 	return hr.wError;
 }
 
 u16 HPI_OutStreamGetInfoEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u16 *pwState,
 	u32 *pdwBufferSize,
@@ -912,18 +915,18 @@ u16 HPI_OutStreamGetInfoEx(
 }
 
 u16 HPI_OutStreamWriteBuf(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
-	u8 *pbData,
+	const u8 *pbData,
 	u32 dwBytesToWrite,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 )
 {
 	struct hpi_message hm;
 	struct hpi_response hr;
 	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM, HPI_OSTREAM_WRITE);
 	u32TOINDEXES(hOutStream, &hm.wAdapterIndex, &hm.wObjIndex);
-	hm.u.d.u.Data.pbData = pbData;
+	hm.u.d.u.Data.pbData = (u8 *)pbData;
 	hm.u.d.u.Data.dwDataSize = dwBytesToWrite;
 
 	HPI_FormatToMsg(&hm.u.d.u.Data.Format, pFormat);
@@ -934,7 +937,7 @@ u16 HPI_OutStreamWriteBuf(
 }
 
 u16 HPI_OutStreamStart(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -948,8 +951,24 @@ u16 HPI_OutStreamStart(
 	return hr.wError;
 }
 
+u16 HPI_OutStreamWaitStart(
+	const struct hpi_hsubsys *phSubSys,
+	u32 hOutStream
+)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_OSTREAM,
+		HPI_OSTREAM_WAIT_START);
+	u32TOINDEXES(hOutStream, &hm.wAdapterIndex, &hm.wObjIndex);
+
+	HPI_Message(&hm, &hr);
+
+	return hr.wError;
+}
+
 u16 HPI_OutStreamStop(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -964,7 +983,7 @@ u16 HPI_OutStreamStop(
 }
 
 u16 HPI_OutStreamSinegen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -980,7 +999,7 @@ u16 HPI_OutStreamSinegen(
 }
 
 u16 HPI_OutStreamReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -995,7 +1014,7 @@ u16 HPI_OutStreamReset(
 }
 
 u16 HPI_OutStreamQueryFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_format *pFormat
 )
@@ -1015,7 +1034,7 @@ u16 HPI_OutStreamQueryFormat(
 }
 
 u16 HPI_OutStreamSetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_format *pFormat
 )
@@ -1035,7 +1054,7 @@ u16 HPI_OutStreamSetFormat(
 }
 
 u16 HPI_OutStreamSetVelocity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	short nVelocity
 )
@@ -1054,7 +1073,7 @@ u16 HPI_OutStreamSetVelocity(
 }
 
 u16 HPI_OutStreamSetPunchInOut(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwPunchInSample,
 	u32 dwPunchOutSample
@@ -1076,7 +1095,7 @@ u16 HPI_OutStreamSetPunchInOut(
 }
 
 u16 HPI_OutStreamAncillaryReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u16 wMode
 )
@@ -1093,7 +1112,7 @@ u16 HPI_OutStreamAncillaryReset(
 }
 
 u16 HPI_OutStreamAncillaryGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 *pdwFramesAvailable
 )
@@ -1115,7 +1134,7 @@ u16 HPI_OutStreamAncillaryGetInfo(
 }
 
 u16 HPI_OutStreamAncillaryRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	struct hpi_anc_frame *pAncFrameBuffer,
 	u32 dwAncFrameBufferSizeInBytes,
@@ -1139,7 +1158,7 @@ u16 HPI_OutStreamAncillaryRead(
 }
 
 u16 HPI_OutStreamSetTimeScale(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwTimeScale
 )
@@ -1159,7 +1178,7 @@ u16 HPI_OutStreamSetTimeScale(
 }
 
 u16 HPI_OutStreamHostBufferAllocate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 dwSizeInBytes
 )
@@ -1176,7 +1195,7 @@ u16 HPI_OutStreamHostBufferAllocate(
 }
 
 u16 HPI_OutStreamHostBufferGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u8 **ppBuffer,
 	struct hpi_hostbuffer_status **ppStatus
@@ -1200,7 +1219,7 @@ u16 HPI_OutStreamHostBufferGetInfo(
 }
 
 u16 HPI_OutStreamHostBufferFree(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -1215,7 +1234,7 @@ u16 HPI_OutStreamHostBufferFree(
 }
 
 u16 HPI_OutStreamGroupAdd(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 hStream
 )
@@ -1252,7 +1271,7 @@ u16 HPI_OutStreamGroupAdd(
 }
 
 u16 HPI_OutStreamGroupGetMap(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream,
 	u32 *pdwOutStreamMap,
 	u32 *pdwInStreamMap
@@ -1275,7 +1294,7 @@ u16 HPI_OutStreamGroupGetMap(
 }
 
 u16 HPI_OutStreamGroupReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hOutStream
 )
 {
@@ -1290,7 +1309,7 @@ u16 HPI_OutStreamGroupReset(
 }
 
 u16 HPI_InStreamOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wInStreamIndex,
 	u32 *phInStream
@@ -1316,7 +1335,7 @@ u16 HPI_InStreamOpen(
 }
 
 u16 HPI_InStreamClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1328,19 +1347,22 @@ u16 HPI_InStreamClose(
 	u32TOINDEXES(hInStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
-	hm.wFunction = HPI_ISTREAM_GROUP_RESET;
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_ISTREAM,
+		HPI_ISTREAM_GROUP_RESET);
+	u32TOINDEXES(hInStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
-	hm.wFunction = HPI_ISTREAM_CLOSE;
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_ISTREAM, HPI_ISTREAM_CLOSE);
+	u32TOINDEXES(hInStream, &hm.wAdapterIndex, &hm.wObjIndex);
 	HPI_Message(&hm, &hr);
 
 	return hr.wError;
 }
 
 u16 HPI_InStreamQueryFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 )
 {
 	struct hpi_message hm;
@@ -1357,9 +1379,9 @@ u16 HPI_InStreamQueryFormat(
 }
 
 u16 HPI_InStreamSetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_format *pFormat
+	const struct hpi_format *pFormat
 )
 {
 	struct hpi_message hm;
@@ -1376,7 +1398,7 @@ u16 HPI_InStreamSetFormat(
 }
 
 u16 HPI_InStreamReadBuf(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u8 *pbData,
 	u32 dwBytesToRead
@@ -1396,7 +1418,7 @@ u16 HPI_InStreamReadBuf(
 }
 
 u16 HPI_InStreamStart(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1411,8 +1433,25 @@ u16 HPI_InStreamStart(
 	return hr.wError;
 }
 
+u16 HPI_InStreamWaitStart(
+	const struct hpi_hsubsys *phSubSys,
+	u32 hInStream
+)
+{
+	struct hpi_message hm;
+	struct hpi_response hr;
+
+	HPI_InitMessageResponse(&hm, &hr, HPI_OBJ_ISTREAM,
+		HPI_ISTREAM_WAIT_START);
+	u32TOINDEXES(hInStream, &hm.wAdapterIndex, &hm.wObjIndex);
+
+	HPI_Message(&hm, &hr);
+
+	return hr.wError;
+}
+
 u16 HPI_InStreamStop(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1428,7 +1467,7 @@ u16 HPI_InStreamStop(
 }
 
 u16 HPI_InStreamReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1444,7 +1483,7 @@ u16 HPI_InStreamReset(
 }
 
 u16 HPI_InStreamGetInfoEx(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u16 *pwState,
 	u32 *pdwBufferSize,
@@ -1477,7 +1516,7 @@ u16 HPI_InStreamGetInfoEx(
 }
 
 u16 HPI_InStreamAncillaryReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u16 wBytesPerFrame,
 	u16 wMode,
@@ -1498,7 +1537,7 @@ u16 HPI_InStreamAncillaryReset(
 }
 
 u16 HPI_InStreamAncillaryGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 *pdwFrameSpace
 )
@@ -1518,9 +1557,9 @@ u16 HPI_InStreamAncillaryGetInfo(
 }
 
 u16 HPI_InStreamAncillaryWrite(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
-	struct hpi_anc_frame *pAncFrameBuffer,
+	const struct hpi_anc_frame *pAncFrameBuffer,
 	u32 dwAncFrameBufferSizeInBytes,
 	u32 dwNumberOfAncillaryFramesToWrite
 )
@@ -1543,7 +1582,7 @@ u16 HPI_InStreamAncillaryWrite(
 }
 
 u16 HPI_InStreamHostBufferAllocate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 dwSizeInBytes
 )
@@ -1561,7 +1600,7 @@ u16 HPI_InStreamHostBufferAllocate(
 }
 
 u16 HPI_InStreamHostBufferGetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u8 **ppBuffer,
 	struct hpi_hostbuffer_status **ppStatus
@@ -1585,7 +1624,7 @@ u16 HPI_InStreamHostBufferGetInfo(
 }
 
 u16 HPI_InStreamHostBufferFree(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1601,7 +1640,7 @@ u16 HPI_InStreamHostBufferFree(
 }
 
 u16 HPI_InStreamGroupAdd(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 hStream
 )
@@ -1640,7 +1679,7 @@ u16 HPI_InStreamGroupAdd(
 }
 
 u16 HPI_InStreamGroupGetMap(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream,
 	u32 *pdwOutStreamMap,
 	u32 *pdwInStreamMap
@@ -1663,7 +1702,7 @@ u16 HPI_InStreamGroupGetMap(
 }
 
 u16 HPI_InStreamGroupReset(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hInStream
 )
 {
@@ -1678,7 +1717,7 @@ u16 HPI_InStreamGroupReset(
 }
 
 u16 HPI_MixerOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phMixer
 )
@@ -1699,7 +1738,7 @@ u16 HPI_MixerOpen(
 }
 
 u16 HPI_MixerClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer
 )
 {
@@ -1712,7 +1751,7 @@ u16 HPI_MixerClose(
 }
 
 u16 HPI_MixerGetControl(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	u16 wSrcNodeType,
 	u16 wSrcNodeTypeIndex,
@@ -1745,7 +1784,7 @@ u16 HPI_MixerGetControl(
 }
 
 u16 HPI_MixerGetControlByIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	u16 wControlIndex,
 	u16 *pwSrcNodeType,
@@ -1785,7 +1824,7 @@ u16 HPI_MixerGetControlByIndex(
 }
 
 u16 HPI_MixerStore(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hMixer,
 	enum HPI_MIXER_STORE_COMMAND command,
 	u16 wIndex
@@ -1963,7 +2002,7 @@ u16 HPI_AESEBU_Receiver_QueryFormat(
 }
 
 u16 HPI_AESEBU_Receiver_SetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wFormat
 )
@@ -1973,7 +2012,7 @@ u16 HPI_AESEBU_Receiver_SetFormat(
 }
 
 u16 HPI_AESEBU_Receiver_GetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwFormat
 )
@@ -1990,7 +2029,7 @@ u16 HPI_AESEBU_Receiver_GetFormat(
 }
 
 u16 HPI_AESEBU_Receiver_GetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 )
@@ -2000,7 +2039,7 @@ u16 HPI_AESEBU_Receiver_GetSampleRate(
 }
 
 u16 HPI_AESEBU_Receiver_GetUserData(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
@@ -2022,7 +2061,7 @@ u16 HPI_AESEBU_Receiver_GetUserData(
 }
 
 u16 HPI_AESEBU_Receiver_GetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
@@ -2044,7 +2083,7 @@ u16 HPI_AESEBU_Receiver_GetChannelStatus(
 }
 
 u16 HPI_AESEBU_Receiver_GetErrorStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwErrorData
 )
@@ -2060,7 +2099,7 @@ u16 HPI_AESEBU_Receiver_GetErrorStatus(
 }
 
 u16 HPI_AESEBU_Transmitter_SetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwSampleRate
 )
@@ -2070,7 +2109,7 @@ u16 HPI_AESEBU_Transmitter_SetSampleRate(
 }
 
 u16 HPI_AESEBU_Transmitter_SetUserData(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 wData
@@ -2081,7 +2120,7 @@ u16 HPI_AESEBU_Transmitter_SetUserData(
 }
 
 u16 HPI_AESEBU_Transmitter_SetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 wData
@@ -2092,7 +2131,7 @@ u16 HPI_AESEBU_Transmitter_SetChannelStatus(
 }
 
 u16 HPI_AESEBU_Transmitter_GetChannelStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pwData
@@ -2118,7 +2157,7 @@ u16 HPI_AESEBU_Transmitter_QueryFormat(
 }
 
 u16 HPI_AESEBU_Transmitter_SetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOutputFormat
 )
@@ -2128,7 +2167,7 @@ u16 HPI_AESEBU_Transmitter_SetFormat(
 }
 
 u16 HPI_AESEBU_Transmitter_GetFormat(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwOutputFormat
 )
@@ -2145,7 +2184,7 @@ u16 HPI_AESEBU_Transmitter_GetFormat(
 }
 
 u16 HPI_Bitstream_SetClockEdge(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wEdgeType
 )
@@ -2155,7 +2194,7 @@ u16 HPI_Bitstream_SetClockEdge(
 }
 
 u16 HPI_Bitstream_SetDataPolarity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wPolarity
 )
@@ -2165,7 +2204,7 @@ u16 HPI_Bitstream_SetDataPolarity(
 }
 
 u16 HPI_Bitstream_GetActivity(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwClkActivity,
 	u16 *pwDataActivity
@@ -2202,7 +2241,7 @@ u16 HPI_ChannelMode_QueryMode(
 }
 
 u16 HPI_ChannelModeSet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wMode
 )
@@ -2212,7 +2251,7 @@ u16 HPI_ChannelModeSet(
 }
 
 u16 HPI_ChannelModeGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *wMode
 )
@@ -2226,7 +2265,7 @@ u16 HPI_ChannelModeGet(
 }
 
 u16 HPI_Cobranet_HmiWrite(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwHmiAddress,
 	u32 dwByteCount,
@@ -2256,7 +2295,7 @@ u16 HPI_Cobranet_HmiWrite(
 }
 
 u16 HPI_Cobranet_HmiRead(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwHmiAddress,
 	u32 dwMaxByteCount,
@@ -2300,7 +2339,7 @@ u16 HPI_Cobranet_HmiRead(
 }
 
 u16 HPI_Cobranet_HmiGetStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwStatus,
 	u32 *pdwReadableSize,
@@ -2330,7 +2369,7 @@ u16 HPI_Cobranet_HmiGetStatus(
 }
 
 u16 HPI_Cobranet_GetIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwIPaddress
 )
@@ -2355,7 +2394,7 @@ u16 HPI_Cobranet_GetIPaddress(
 }
 
 u16 HPI_Cobranet_SetIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwIPaddress
 )
@@ -2376,7 +2415,7 @@ u16 HPI_Cobranet_SetIPaddress(
 }
 
 u16 HPI_Cobranet_GetStaticIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwIPaddress
 )
@@ -2401,7 +2440,7 @@ u16 HPI_Cobranet_GetStaticIPaddress(
 }
 
 u16 HPI_Cobranet_SetStaticIPaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwIPaddress
 )
@@ -2422,7 +2461,7 @@ u16 HPI_Cobranet_SetStaticIPaddress(
 }
 
 u16 HPI_Cobranet_GetMACaddress(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwMAC_MSBs,
 	u32 *pdwMAC_LSBs
@@ -2455,7 +2494,7 @@ u16 HPI_Cobranet_GetMACaddress(
 }
 
 u16 HPI_Compander_Set(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wAttack,
 	u16 wDecay,
@@ -2482,7 +2521,7 @@ u16 HPI_Compander_Set(
 }
 
 u16 HPI_Compander_Get(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwAttack,
 	u16 *pwDecay,
@@ -2516,7 +2555,7 @@ u16 HPI_Compander_Get(
 }
 
 u16 HPI_LevelQueryRange(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *nMinGain_01dB,
 	short *nMaxGain_01dB,
@@ -2546,7 +2585,7 @@ u16 HPI_LevelQueryRange(
 }
 
 u16 HPI_LevelSetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB[HPI_MAX_CHANNELS]
 )
@@ -2567,7 +2606,7 @@ u16 HPI_LevelSetGain(
 }
 
 u16 HPI_LevelGetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB[HPI_MAX_CHANNELS]
 )
@@ -2597,7 +2636,7 @@ u16 HPI_Meter_QueryChannels(
 }
 
 u16 HPI_MeterGetPeak(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anPeakdB[HPI_MAX_CHANNELS]
 )
@@ -2625,7 +2664,7 @@ u16 HPI_MeterGetPeak(
 }
 
 u16 HPI_MeterGetRms(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anRmsdB[HPI_MAX_CHANNELS]
 )
@@ -2653,7 +2692,7 @@ u16 HPI_MeterGetRms(
 }
 
 u16 HPI_MeterSetRmsBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 nAttack,
 	u16 nDecay
@@ -2664,7 +2703,7 @@ u16 HPI_MeterSetRmsBallistics(
 }
 
 u16 HPI_MeterGetRmsBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pnAttack,
 	u16 *pnDecay
@@ -2686,7 +2725,7 @@ u16 HPI_MeterGetRmsBallistics(
 }
 
 u16 HPI_MeterSetPeakBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 nAttack,
 	u16 nDecay
@@ -2697,7 +2736,7 @@ u16 HPI_MeterSetPeakBallistics(
 }
 
 u16 HPI_MeterGetPeakBallistics(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pnAttack,
 	u16 *pnDecay
@@ -2719,7 +2758,7 @@ u16 HPI_MeterGetPeakBallistics(
 }
 
 u16 HPI_Microphone_SetPhantomPower(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOnOff
 )
@@ -2729,7 +2768,7 @@ u16 HPI_Microphone_SetPhantomPower(
 }
 
 u16 HPI_Microphone_GetPhantomPower(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwOnOff
 )
@@ -2744,7 +2783,7 @@ u16 HPI_Microphone_GetPhantomPower(
 }
 
 u16 HPI_Multiplexer_SetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSourceNodeType,
 	u16 wSourceNodeIndex
@@ -2755,7 +2794,7 @@ u16 HPI_Multiplexer_SetSource(
 }
 
 u16 HPI_Multiplexer_GetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *wSourceNodeType,
 	u16 *wSourceNodeIndex
@@ -2773,7 +2812,7 @@ u16 HPI_Multiplexer_GetSource(
 }
 
 u16 HPI_Multiplexer_QuerySource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *wSourceNodeType,
@@ -2798,7 +2837,7 @@ u16 HPI_Multiplexer_QuerySource(
 }
 
 u16 HPI_ParametricEQ_GetInfo(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwNumberOfBands,
 	u16 *pwOnOff
@@ -2818,7 +2857,7 @@ u16 HPI_ParametricEQ_GetInfo(
 }
 
 u16 HPI_ParametricEQ_SetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wOnOff
 )
@@ -2828,7 +2867,7 @@ u16 HPI_ParametricEQ_SetState(
 }
 
 u16 HPI_ParametricEQ_GetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 *pnType,
@@ -2860,7 +2899,7 @@ u16 HPI_ParametricEQ_GetBand(
 }
 
 u16 HPI_ParametricEQ_SetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	u16 nType,
@@ -2887,7 +2926,7 @@ u16 HPI_ParametricEQ_SetBand(
 }
 
 u16 HPI_ParametricEQ_GetCoeffs(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wIndex,
 	short coeffs[5]
@@ -2929,7 +2968,7 @@ u16 HPI_SampleClock_QuerySource(
 }
 
 u16 HPI_SampleClock_SetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSource
 )
@@ -2939,7 +2978,7 @@ u16 HPI_SampleClock_SetSource(
 }
 
 u16 HPI_SampleClock_GetSource(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwSource
 )
@@ -2972,7 +3011,7 @@ u16 HPI_SampleClock_QuerySourceIndex(
 }
 
 u16 HPI_SampleClock_SetSourceIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wSourceIndex
 )
@@ -2982,7 +3021,7 @@ u16 HPI_SampleClock_SetSourceIndex(
 }
 
 u16 HPI_SampleClock_GetSourceIndex(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwSourceIndex
 )
@@ -3012,7 +3051,7 @@ u16 HPI_SampleClock_QueryLocalRate(
 }
 
 u16 HPI_SampleClock_SetLocalRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwSampleRate
 )
@@ -3022,7 +3061,7 @@ u16 HPI_SampleClock_SetLocalRate(
 }
 
 u16 HPI_SampleClock_GetLocalRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 )
@@ -3038,7 +3077,7 @@ u16 HPI_SampleClock_GetLocalRate(
 }
 
 u16 HPI_SampleClock_GetSampleRate(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwSampleRate
 )
@@ -3054,7 +3093,7 @@ u16 HPI_SampleClock_GetSampleRate(
 }
 
 u16 HPI_SampleClock_SetAuto(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwAuto
 )
@@ -3064,7 +3103,7 @@ u16 HPI_SampleClock_SetAuto(
 }
 
 u16 HPI_SampleClock_GetAuto(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwAuto
 )
@@ -3074,7 +3113,7 @@ u16 HPI_SampleClock_GetAuto(
 }
 
 u16 HPI_SampleClock_SetLocalRateLock(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwLock
 )
@@ -3084,7 +3123,7 @@ u16 HPI_SampleClock_SetLocalRateLock(
 }
 
 u16 HPI_SampleClock_GetLocalRateLock(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwLock
 )
@@ -3094,7 +3133,7 @@ u16 HPI_SampleClock_GetLocalRateLock(
 }
 
 u16 HPI_ToneDetector_GetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 nIndex,
 	u32 *dwFrequency
@@ -3105,7 +3144,7 @@ u16 HPI_ToneDetector_GetFrequency(
 }
 
 u16 HPI_ToneDetector_GetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *State
 )
@@ -3115,7 +3154,7 @@ u16 HPI_ToneDetector_GetState(
 }
 
 u16 HPI_ToneDetector_SetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 Enable
 )
@@ -3125,7 +3164,7 @@ u16 HPI_ToneDetector_SetEnable(
 }
 
 u16 HPI_ToneDetector_GetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *Enable
 )
@@ -3135,7 +3174,7 @@ u16 HPI_ToneDetector_GetEnable(
 }
 
 u16 HPI_ToneDetector_SetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 EventEnable
 )
@@ -3145,7 +3184,7 @@ u16 HPI_ToneDetector_SetEventEnable(
 }
 
 u16 HPI_ToneDetector_GetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *EventEnable
 )
@@ -3155,7 +3194,7 @@ u16 HPI_ToneDetector_GetEventEnable(
 }
 
 u16 HPI_ToneDetector_SetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	int Threshold
 )
@@ -3165,7 +3204,7 @@ u16 HPI_ToneDetector_SetThreshold(
 }
 
 u16 HPI_ToneDetector_GetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	int *Threshold
 )
@@ -3175,7 +3214,7 @@ u16 HPI_ToneDetector_GetThreshold(
 }
 
 u16 HPI_SilenceDetector_GetState(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *State
 )
@@ -3185,7 +3224,7 @@ u16 HPI_SilenceDetector_GetState(
 }
 
 u16 HPI_SilenceDetector_SetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 Enable
 )
@@ -3195,7 +3234,7 @@ u16 HPI_SilenceDetector_SetEnable(
 }
 
 u16 HPI_SilenceDetector_GetEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *Enable
 )
@@ -3205,7 +3244,7 @@ u16 HPI_SilenceDetector_GetEnable(
 }
 
 u16 HPI_SilenceDetector_SetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 EventEnable
 )
@@ -3215,7 +3254,7 @@ u16 HPI_SilenceDetector_SetEventEnable(
 }
 
 u16 HPI_SilenceDetector_GetEventEnable(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *EventEnable
 )
@@ -3225,7 +3264,7 @@ u16 HPI_SilenceDetector_GetEventEnable(
 }
 
 u16 HPI_SilenceDetector_SetDelay(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 Delay
 )
@@ -3235,7 +3274,7 @@ u16 HPI_SilenceDetector_SetDelay(
 }
 
 u16 HPI_SilenceDetector_GetDelay(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *Delay
 )
@@ -3245,7 +3284,7 @@ u16 HPI_SilenceDetector_GetDelay(
 }
 
 u16 HPI_SilenceDetector_SetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	int Threshold
 )
@@ -3255,7 +3294,7 @@ u16 HPI_SilenceDetector_SetThreshold(
 }
 
 u16 HPI_SilenceDetector_GetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	int *Threshold
 )
@@ -3281,7 +3320,7 @@ u16 HPI_Tuner_QueryBand(
 }
 
 u16 HPI_Tuner_SetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 wBand
 )
@@ -3291,7 +3330,7 @@ u16 HPI_Tuner_SetBand(
 }
 
 u16 HPI_Tuner_GetBand(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwBand
 )
@@ -3319,7 +3358,7 @@ u16 HPI_Tuner_QueryFrequency(
 }
 
 u16 HPI_Tuner_SetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 wFreqInkHz
 )
@@ -3329,7 +3368,7 @@ u16 HPI_Tuner_SetFrequency(
 }
 
 u16 HPI_Tuner_GetFrequency(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pwFreqInkHz
 )
@@ -3355,7 +3394,7 @@ u16 HPI_Tuner_QueryGain(
 }
 
 u16 HPI_Tuner_SetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short nGain
 )
@@ -3365,7 +3404,7 @@ u16 HPI_Tuner_SetGain(
 }
 
 u16 HPI_Tuner_GetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pnGain
 )
@@ -3381,7 +3420,7 @@ u16 HPI_Tuner_GetGain(
 }
 
 u16 HPI_Tuner_GetRFLevel(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pwLevel
 )
@@ -3400,7 +3439,7 @@ u16 HPI_Tuner_GetRFLevel(
 }
 
 u16 HPI_Tuner_GetRawRFLevel(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *pwLevel
 )
@@ -3431,7 +3470,7 @@ u16 HPI_Tuner_QueryDeemphasis(
 }
 
 u16 HPI_Tuner_SetDeemphasis(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwDeemphasis
 )
@@ -3441,7 +3480,7 @@ u16 HPI_Tuner_SetDeemphasis(
 }
 
 u16 HPI_Tuner_GetDeemphasis(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwDeemphasis
 )
@@ -3461,7 +3500,7 @@ u16 HPI_Tuner_QueryProgram(
 }
 
 u16 HPI_Tuner_SetProgram(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 dwProgram
 )
@@ -3471,7 +3510,7 @@ u16 HPI_Tuner_SetProgram(
 }
 
 u16 HPI_Tuner_GetProgram(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwProgram
 )
@@ -3481,7 +3520,7 @@ u16 HPI_Tuner_GetProgram(
 }
 
 u16 HPI_Tuner_GetHdRadioDspVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszDspVersion,
 	const u32 dwStringSize
@@ -3493,7 +3532,7 @@ u16 HPI_Tuner_GetHdRadioDspVersion(
 }
 
 u16 HPI_Tuner_GetHdRadioSdkVersion(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszSdkVersion,
 	const u32 dwStringSize
@@ -3505,7 +3544,7 @@ u16 HPI_Tuner_GetHdRadioSdkVersion(
 }
 
 u16 HPI_Tuner_GetStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u16 *pwStatusMask,
 	u16 *pwStatus
@@ -3529,7 +3568,7 @@ u16 HPI_Tuner_GetStatus(
 }
 
 u16 HPI_Tuner_SetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 nMode,
 	u32 nValue
@@ -3540,7 +3579,7 @@ u16 HPI_Tuner_SetMode(
 }
 
 u16 HPI_Tuner_GetMode(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 nMode,
 	u32 *pnValue
@@ -3551,7 +3590,7 @@ u16 HPI_Tuner_GetMode(
 }
 
 u16 HPI_Tuner_GetHdRadioSignalQuality(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwQuality
 )
@@ -3561,7 +3600,7 @@ u16 HPI_Tuner_GetHdRadioSignalQuality(
 }
 
 u16 HPI_Tuner_GetRDS(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pData
 )
@@ -3582,7 +3621,7 @@ u16 HPI_Tuner_GetRDS(
 }
 
 u16 HPI_PAD_GetChannelName(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwDataLength
@@ -3593,7 +3632,7 @@ u16 HPI_PAD_GetChannelName(
 }
 
 u16 HPI_PAD_GetArtist(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwDataLength
@@ -3604,7 +3643,7 @@ u16 HPI_PAD_GetArtist(
 }
 
 u16 HPI_PAD_GetTitle(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwDataLength
@@ -3615,7 +3654,7 @@ u16 HPI_PAD_GetTitle(
 }
 
 u16 HPI_PAD_GetComment(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	char *pszString,
 	const u32 dwDataLength
@@ -3626,7 +3665,7 @@ u16 HPI_PAD_GetComment(
 }
 
 u16 HPI_PAD_GetProgramType(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwPTY
 )
@@ -3636,7 +3675,7 @@ u16 HPI_PAD_GetProgramType(
 }
 
 u16 HPI_PAD_GetRdsPI(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	u32 *pdwPI
 )
@@ -3656,7 +3695,7 @@ u16 HPI_Volume_QueryChannels(
 }
 
 u16 HPI_VolumeSetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anLogGain[HPI_MAX_CHANNELS]
 )
@@ -3676,7 +3715,7 @@ u16 HPI_VolumeSetGain(
 }
 
 u16 HPI_VolumeGetGain(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anLogGain[HPI_MAX_CHANNELS]
 )
@@ -3696,7 +3735,7 @@ u16 HPI_VolumeGetGain(
 }
 
 u16 HPI_VolumeQueryRange(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *nMinGain_01dB,
 	short *nMaxGain_01dB,
@@ -3726,7 +3765,7 @@ u16 HPI_VolumeQueryRange(
 }
 
 u16 HPI_VolumeAutoFadeProfile(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anStopGain0_01dB[HPI_MAX_CHANNELS],
 	u32 dwDurationMs,
@@ -3752,7 +3791,7 @@ u16 HPI_VolumeAutoFadeProfile(
 }
 
 u16 HPI_VolumeAutoFade(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anStopGain0_01dB[HPI_MAX_CHANNELS],
 	u32 dwDurationMs
@@ -3764,7 +3803,7 @@ u16 HPI_VolumeAutoFade(
 }
 
 u16 HPI_VoxSetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short anGain0_01dB
 )
@@ -3784,7 +3823,7 @@ u16 HPI_VoxSetThreshold(
 }
 
 u16 HPI_VoxGetThreshold(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hControl,
 	short *anGain0_01dB
 )
@@ -3977,7 +4016,7 @@ u16 HPI_Entity_AllocAndCopy(
 }
 
 u16 HPI_Universal_Info(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity **info
 )
@@ -4024,7 +4063,7 @@ u16 HPI_Universal_Info(
 }
 
 u16 HPI_Universal_Get(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity **value
 )
@@ -4071,7 +4110,7 @@ u16 HPI_Universal_Get(
 }
 
 u16 HPI_Universal_Set(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hC,
 	struct hpi_entity *value
 )
@@ -4193,7 +4232,7 @@ u16 HPI_Entity_Unpack(
 }
 
 u16 HPI_GpioOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phGpio,
 	u16 *pwNumberInputBits,
@@ -4219,7 +4258,7 @@ u16 HPI_GpioOpen(
 }
 
 u16 HPI_GpioReadBit(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 wBitIndex,
 	u16 *pwBitData
@@ -4238,7 +4277,7 @@ u16 HPI_GpioReadBit(
 }
 
 u16 HPI_GpioReadAllBits(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 awAllBitData[4]
 )
@@ -4260,7 +4299,7 @@ u16 HPI_GpioReadAllBits(
 }
 
 u16 HPI_GpioWriteBit(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 wBitIndex,
 	u16 wBitData
@@ -4279,7 +4318,7 @@ u16 HPI_GpioWriteBit(
 }
 
 u16 HPI_GpioWriteStatus(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hGpio,
 	u16 awAllBitData[4]
 )
@@ -4302,7 +4341,7 @@ u16 HPI_GpioWriteStatus(
 }
 
 u16 HPI_AsyncEventOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phAsync
 )
@@ -4327,7 +4366,7 @@ u16 HPI_AsyncEventOpen(
 }
 
 u16 HPI_AsyncEventClose(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync
 )
 {
@@ -4343,7 +4382,7 @@ u16 HPI_AsyncEventClose(
 }
 
 u16 HPI_AsyncEventWait(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 wMaximumEvents,
 	struct hpi_async_event *pEvents,
@@ -4354,7 +4393,7 @@ u16 HPI_AsyncEventWait(
 }
 
 u16 HPI_AsyncEventGetCount(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 *pwCount
 )
@@ -4375,7 +4414,7 @@ u16 HPI_AsyncEventGetCount(
 }
 
 u16 HPI_AsyncEventGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hAsync,
 	u16 wMaximumEvents,
 	struct hpi_async_event *pEvents,
@@ -4399,7 +4438,7 @@ u16 HPI_AsyncEventGet(
 }
 
 u16 HPI_NvMemoryOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phNvMemory,
 	u16 *pwSizeInBytes
@@ -4425,7 +4464,7 @@ u16 HPI_NvMemoryOpen(
 }
 
 u16 HPI_NvMemoryReadByte(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hNvMemory,
 	u16 wIndex,
 	u16 *pwData
@@ -4445,7 +4484,7 @@ u16 HPI_NvMemoryReadByte(
 }
 
 u16 HPI_NvMemoryWriteByte(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hNvMemory,
 	u16 wIndex,
 	u16 wData
@@ -4465,7 +4504,7 @@ u16 HPI_NvMemoryWriteByte(
 }
 
 u16 HPI_ProfileOpenAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u16 wProfileIndex,
 	u32 *phProfile,
@@ -4491,7 +4530,7 @@ u16 HPI_ProfileOpenAll(
 }
 
 u16 HPI_ProfileGet(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u16 wBinIndex,
 	u16 *pwSeconds,
@@ -4521,7 +4560,7 @@ u16 HPI_ProfileGet(
 }
 
 u16 HPI_ProfileGetUtilization(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u32 *pdwUtilization
 )
@@ -4543,7 +4582,7 @@ u16 HPI_ProfileGetUtilization(
 }
 
 u16 HPI_ProfileGetName(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile,
 	u16 wBinIndex,
 	char *szName,
@@ -4569,7 +4608,7 @@ u16 HPI_ProfileGetName(
 }
 
 u16 HPI_ProfileStartAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile
 )
 {
@@ -4584,7 +4623,7 @@ u16 HPI_ProfileStartAll(
 }
 
 u16 HPI_ProfileStopAll(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hProfile
 )
 {
@@ -4599,7 +4638,7 @@ u16 HPI_ProfileStopAll(
 }
 
 u16 HPI_WatchdogOpen(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wAdapterIndex,
 	u32 *phWatchdog
 )
@@ -4622,7 +4661,7 @@ u16 HPI_WatchdogOpen(
 }
 
 u16 HPI_WatchdogSetTime(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hWatchdog,
 	u32 dwTimeMillisec
 )
@@ -4640,7 +4679,7 @@ u16 HPI_WatchdogSetTime(
 }
 
 u16 HPI_WatchdogPing(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u32 hWatchdog
 )
 {
diff --git a/pci/asihpi/hpimsginit.c b/pci/asihpi/hpimsginit.c
index a13fd0f..6e14c49 100644
--- a/pci/asihpi/hpimsginit.c
+++ b/pci/asihpi/hpimsginit.c
@@ -38,7 +38,7 @@ static u16 gwSSX2Bypass;
   * \return Previous bypass setting.
   */
 u16 HPI_SubSysSsx2Bypass(
-	struct hpi_hsubsys *phSubSys,
+	const struct hpi_hsubsys *phSubSys,
 	u16 wBypass
 )
 {
-- 
1.7.0.rc0.8.ge3f67d
