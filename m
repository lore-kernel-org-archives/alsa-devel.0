From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi fix 64 bit compile error.
Date: Tue, 30 Jan 2007 13:29:28 +1300
Message-ID: <200701301329.28960.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oFpvF1Y+OMapXf2"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_oFpvF1Y+OMapXf2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Changes:
Add missed conditional compilation in hpi.h for 64 bit build.
Tweak struct HPI_RESOURCE so size is constant for 32/64 bit.  Update size 
check to reflect this.
-- 
--
Eliot Blennerhassett
AudioScience Inc.

--Boundary-00=_oFpvF1Y+OMapXf2
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-driver-hg3232_asihpi30510-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alsa-driver-hg3232_asihpi30510-1.patch"

diff -r 7306cb0ea4fa pci/asihpi/hpi.h
=2D-- a/pci/asihpi/hpi.h	Mon Jan 29 14:23:31 2007
+++ b/pci/asihpi/hpi.h	Tue Jan 30 13:21:54 2007
@@ -47,7 +47,7 @@
 #define HPI_VER_MINOR(v) (((v)>>8) & 0xFF )
 #define HPI_VER_RELEASE(v) ((v) & 0xFF )
=20
=2D#define HPI_VER HPI_VERSION_CONSTRUCTOR( 3, 05, 07 )
+#define HPI_VER HPI_VERSION_CONSTRUCTOR( 3, 5, 10 )
=20
 /** Define HPI_WITHOUT_HPI_DATA to remove public definition and use of HPI=
_DATA struct */
 /* #define HPI_WITHOUT_HPI_DATA */
@@ -723,8 +723,7 @@
 #define HPI_ETHERNET_PACKET_HOSTED_VIA_HPI 0x40	/*!< This packet must make=
 its way to the host across the HPI interface */
 #define HPI_ETHERNET_PACKET_HOSTED_VIA_HPI_V1 0x41	/*!< This packet must m=
ake its way to the host across the HPI interface */
=20
=2D#define HPI_ETHERNET_UDP_PORT (5151)	/*!< UDP messaging port */
=2D#define HPI_ETHERNET_UDP_PORT_BROADCAST_RESPONSE (5152)	/*!< UDP message=
 port for returning broadcast responses */
+#define HPI_ETHERNET_UDP_PORT (44600)	/*!< UDP messaging port */
=20
 /** \defgroup tonedet_attr Tonedetector attributes
 \{
@@ -2118,10 +2117,10 @@
 	typedef struct {
 		union {
 			HPI_PCI *Pci;
+		} r;
 #ifndef HPI_64BIT		/* keep structure size constant */
=2D			u32 dwPadTo64;
+		u32 dwPadTo64;
 #endif
=2D		} r;
 		u16 wBusType;	/* HPI_BUS_PNPISA, _PCI, _USB etc */
 		u16 wPadding;
=20
@@ -2258,7 +2257,9 @@
 	typedef struct {
 		union {
 			HPI_MSG_DATA Data;
+#ifndef HPI_64BIT
 			HPI_DATA_LEGACY32 Data32;
+#endif
 			u16 wVelocity;
 			HPI_PUNCHINOUT Pio;
 			u32 dwTimeScale;
diff -r 7306cb0ea4fa pci/asihpi/hpicheck.h
=2D-- a/pci/asihpi/hpicheck.h	Mon Jan 29 14:23:31 2007
+++ b/pci/asihpi/hpicheck.h	Tue Jan 30 13:21:54 2007
@@ -60,7 +60,7 @@
=20
 compile_time_size_check(HPI_RESPONSE, 64);
=20
=2Dcompile_time_obj_check(HPI_SUBSYS, 8, 52);
+compile_time_obj_check(HPI_SUBSYS, 12, 52);
 compile_time_obj_check(HPI_ADAPTER, 8, 32);
 compile_time_obj_check(HPI_ADAPTERX, 12, 32);
 compile_time_obj_check(HPI_STREAM, 32, 20);
@@ -83,7 +83,9 @@
 /* API HPI_FORMAT must have fixed size */
 compile_time_size_check(HPI_DATA, 7 * 4);
 compile_time_size_check(HPI_BUFFER, 7 * 4);
+#ifndef HPI_64BIT
 compile_time_size_check(HPI_DATA_LEGACY32, 7 * 4);
+#endif
=20
 /* Message DATA must fit inside API data */
 compile_time_assert((sizeof(HPI_MSG_DATA) <=3D sizeof(HPI_DATA)), data_fit=
);
diff -r 7306cb0ea4fa pci/asihpi/hpifunc.c
=2D-- a/pci/asihpi/hpifunc.c	Mon Jan 29 14:23:31 2007
+++ b/pci/asihpi/hpifunc.c	Tue Jan 30 13:21:54 2007
@@ -2002,7 +2002,7 @@
 *
 * Returns information about the input stream.
 *
=2D*This includes the size of the stream=92s hardware buffer returned in pd=
wBufferSize.=20
+*This includes the size of the streams hardware buffer returned in pdwBuff=
erSize.=20
 * Also includes whether the stream is currently recording (the state) and =
the amount of audio data currently contained in the buffer.
 */
=20
@@ -2023,7 +2023,7 @@
=20
 /** Returns extended information about the input stream.
 *
=2D* This includes the size of the stream=92s hardware buffer returned in p=
dwBufferSize.  Also includes whether the
+* This includes the size of the streams hardware buffer returned in pdwBuf=
ferSize.  Also includes whether the
 * stream is currently recording (the state), the amount of audio data curr=
ently contained in the buffer and how many samples have been recorded.
 *
 * \param pdwSamplesRecorded The SamplesRecorded parameter returns the numb=
er of samples recorded since the
@@ -2084,14 +2084,14 @@
 * Note that when (wMode=3D=3D HPI_MPEG_ANC_HASENERGY, see below) an additi=
onal 5 bytes per frame are
 * automatically allocated for energy information.
 * \param wMode The mode for the ancillary data extraction to operate in. V=
alid settings are HPI_MPEG_ANC_RAW and
=2D* HPI_MPEG_ANC_HASENERGY. The =93RAW=94 mode indicates that the entire a=
ncillary data field is taken up by data from the
=2D* Anc data buffer. The =93HASENERGY=94 option tells the encoder that the=
 MPEG frames have energy information stored in them
+* HPI_MPEG_ANC_HASENERGY. The RAW mode indicates that the entire ancillary=
 data field is taken up by data from the
+* Anc data buffer. The HASENERGY option tells the encoder that the MPEG fr=
ames have energy information stored in them
 * (5 bytes per stereo frame, 3 per mono). The encoder will insert the ener=
gy bytes before filling the remainder of the
 * ancillary data space with data from the ancillary data buffer.
=2D* \param wAlignment HPI_MPEG_ANC_ALIGN_LEFT =96 the wBytesPerFrame data =
immediately follow the audio data.
+* \param wAlignment HPI_MPEG_ANC_ALIGN_LEFT  the wBytesPerFrame data immed=
iately follow the audio data.
 * Spare space is left at the end of the frame.
=2D* HPI_MPEG_ANC_ALIGN_RIGHT =96 the wBytesPerFrame data is packed against=
 the end of the frame. Spare space is left at the start of the frame.
=2D* HPI_MPEG_ANC_ALIGN_FILL =96 all ancillary data space in the frame is u=
sed. wBytesPerFrame or more data is written per frame. There is no spare sp=
ace.
+* HPI_MPEG_ANC_ALIGN_RIGHT  the wBytesPerFrame data is packed against the =
end of the frame. Spare space is left at the start of the frame.
+* HPI_MPEG_ANC_ALIGN_FILL  all ancillary data space in the frame is used. =
wBytesPerFrame or more data is written per frame. There is no spare space.
 *This parameter is ignored for MP3 encoding, effectively it is fixed at HP=
I_MPEG_ANC_ALIGN_FILL  (See Note 2)
 * \param wIdleBit This field tells the encoder what to set all the bits of=
 the ancillary data field to in the case where there is no data waiting to =
be inserted.
 * Valid values are 0 or 1.  This parameter is ignored for MP3 encoding, if=
 no data is available, no data will be inserted  (See Note 2)
@@ -2148,7 +2148,7 @@
 }
=20
 /**
=2D* Writes dwNumberOfAncDataFramesToWrite frames from pAncFrameBuffer to t=
he stream=92s ancillary data buffer.
+* Writes dwNumberOfAncDataFramesToWrite frames from pAncFrameBuffer to the=
 streams ancillary data buffer.
 *
 *The first bit of ancillary information that follows the valid audio data =
is bit 7 of  bData[0]. The first 8 bits of ancillary information following
 * valid audio data are from bData[0]. In the case where there are 6 bytes =
total of ancillary information (48 bits) the last byte inserted in the fram=
e is bData[5].
@@ -2190,8 +2190,8 @@
 * for the buffer can be calculated using HPI_StreamEstimateHostBufferSize()
 *
 * \return Error 0 upon success\n
=2D* HPI_ERROR_INVALID_DATASIZE if memory can=92t be allocated (retrying th=
e call with a smaller size may succeed)\n
=2D* HPI_ERROR_INVALID_OPERATION if virtual address of buffer can=92t be fo=
und.
+* HPI_ERROR_INVALID_DATASIZE if memory cant be allocated (retrying the cal=
l with a smaller size may succeed)\n
+* HPI_ERROR_INVALID_OPERATION if virtual address of buffer cant be found.
 */
 u16 HPI_InStreamHostBufferAllocate(HPI_HSUBSYS * phSubSys,	///< Pointer to=
 HPI subsystem handle
 				   HPI_HISTREAM hInStream,	///< Handle of the InStream
@@ -2374,7 +2374,8 @@
 *
 * \note Not all adapters have controls at all nodes, or between all nodes.=
  Consult the Mixer Map for your particular
 *adapter to find out the location and type of controls in its mixer.
=2D* \example Say you have an audio adapter with a mixer that has the follo=
wing layout:=20
+*
+* Say you have an audio adapter with a mixer that has the following layout=
:=20
 * (Need to add diagram.)
 * You can see that the mixer has two meter controls, located on each of th=
e Outstream source nodes, two volume controls, located between
 * the OutStream sources and the LineOut destination nodes and one level co=
ntrol located on the LineOut destination node.
@@ -2395,7 +2396,7 @@
 			u16 wSrcNodeTypeIndex,	///< Index of particular source node type i.e. t=
he 2nd HPI_SOURCENODE_OSTREAM would be specified as index=3D1
 			u16 wDstNodeType,	///< Destination node type i.e. HPI_DESTNODE_LINEOUT
 			u16 wDstNodeTypeIndex,	///< Index of particular source node type i.e. t=
he 3rd HPI_DESTNODE_LINEOUT would be specified as index=3D2
=2D			u16 wControlType,	// HPI_CONTROL_METER, _VOLUME etc///< Type of mixer=
 control i.e. HPI_CONTROL_METER,  VOLUME, METER or LEVEL. See additional HP=
I_CONTROL_xxxx types defined in HPI.H
+			u16 wControlType,	///< Type of mixer control i.e. HPI_CONTROL_METER,  V=
OLUME, METER or LEVEL. See additional HPI_CONTROL_xxxx types defined in HPI=
=2EH
 			HPI_HCONTROL * phControlHandle	///< Handle to the particular control
     )
 {
diff -r 7306cb0ea4fa pci/asihpi/hpimod.c
=2D-- a/pci/asihpi/hpimod.c	Mon Jan 29 14:23:31 2007
+++ b/pci/asihpi/hpimod.c	Tue Jan 30 13:21:54 2007
@@ -623,7 +623,9 @@
 	       __stringify(DRIVER_VERSION), hpiDebugLevel);
 	printk("Spinlock on=3D%d Local copy=3D%d\n", USE_SPINLOCK, COPY_TO_LOCAL);
 	HPI_SubSysGetVersionEx(NULL, &dwVersion);
=2D	printk(KERN_INFO "HPI_SubSysGetVersion=3D%x\n", dwVersion);
+	printk(KERN_INFO "SubSys Version=3D%d.%02d.%02d\n",
+	       HPI_VER_MAJOR(dwVersion),
+	       HPI_VER_MINOR(dwVersion), HPI_VER_RELEASE(dwVersion));
=20
 	HPI_InitMessage(&hm, HPI_OBJ_SUBSYSTEM, HPI_SUBSYS_DRIVER_LOAD);
 	HPI_MessageEx(&hm, &hr, HOWNER_KERNEL);
diff -r 7306cb0ea4fa pci/asihpi/hpios.h
=2D-- a/pci/asihpi/hpios.h	Mon Jan 29 14:23:31 2007
+++ b/pci/asihpi/hpios.h	Tue Jan 30 13:21:54 2007
@@ -73,8 +73,12 @@
 /* /////////////////////////// PROTOTYPES ////////////////////////////////=
/// */
=20
 /* memory allocation */
+#ifndef HpiOs_MemAlloc
 void *HpiOs_MemAlloc(u32 dwSize);
+#endif
+#ifndef HpiOs_MemFree
 void HpiOs_MemFree(void *ptr);
+#endif
=20
 /* physical memory allocation */
 #ifndef NO_HPIOS_LOCKEDMEM_OPS
@@ -105,14 +109,14 @@
=20
 /** Get the physical PCI address of memory represented by LockedMemHandle.
=20
=2DIf handle is NULL *pPhysicalAddr is set to zero and return 1=20
+If handle is NULL *pPhysicalAddr is set to zero and return 1
 */
 u16 HpiOs_LockedMem_GetPhysAddr(HpiOs_LockedMem_Handle LockedMemHandle,
 				u32 * pPhysicalAddr);
=20
 /** Get the CPU address of of memory represented by LockedMemHandle.
=20
=2DIf handle is NULL *ppvVirtualAddr is set to NULL and return 1=20
+If handle is NULL *ppvVirtualAddr is set to NULL and return 1
 */
 u16 HpiOs_LockedMem_GetVirtAddr(HpiOs_LockedMem_Handle LockedMemHandle,
 				void **ppvVirtualAddr);

--Boundary-00=_oFpvF1Y+OMapXf2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_oFpvF1Y+OMapXf2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_oFpvF1Y+OMapXf2--
