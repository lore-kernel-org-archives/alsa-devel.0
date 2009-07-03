From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 1/13] Intel SST drivers documentation
Date: Fri,  3 Jul 2009 12:28:30 +0530
Message-ID: <1246604310-12812-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D9BF7103890
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:49:29 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This is the first patch of the series.

This patch contains the documentation describing the
new audio drivers for upcoming Intel MID platform using Atom
Processor which uses DSP core for audio processing named
Intel smart sound Technology (SST). There are two drivers involved.
One driver is SST driver which governs the DSP engine and the
other is MAD (MID Audio driver) driver that governs three
different sound cards.

The intel SST driver enables offload architecture where by the
encoded files like mp3, aac and wma can be directly decoded,
post processed and rendered by the DSP engine. More details
to follow in the following patches

The interfaces exposed are documented here as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   Documentation/sound/alsa/intel_sst.txt
---
 Documentation/sound/alsa/intel_sst.txt |  426 ++++++++++++++++++++++++++++++++
 1 files changed, 426 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/sound/alsa/intel_sst.txt

diff --git a/Documentation/sound/alsa/intel_sst.txt b/Documentation/sound/alsa/intel_sst.txt
new file mode 100644
index 0000000..e5d6346
--- /dev/null
+++ b/Documentation/sound/alsa/intel_sst.txt
@@ -0,0 +1,426 @@
+		Intel Smart Sound Technology API documentation
+		==============================================
+
+			Vinod Koul <vinod.koul@intel.com>
+			Harsha Priya <priya.harsha@intel.com>
+
+General
+-------
+
+Intel SST is a new hardware component that is capable of decoding and
+rendering. This hardware takes in encoded data, decodes and renders the same.
+The activity on the CPU is much reduced thus reducing the C0 residency time.
+This enables low power playback and increases the battery life. This concept
+is made use of in Intel Moblin Internet devices. Intel SST driver is the one
+that enables this hardware for use. The firmare file is required to be placed
+in /lib/firmware for the driver to download the binary to hardware.
+
+There are 3 sound cards that Intel SST hardware supports and enables.
+Intel SST is the only hardware in the platform that can render to sound card.
+These sound cards are exposed and mapped through Intel MID driver which is an
+ALSA driver. This driver uses Intel SST driver to send data and controls to the
+hardware.
+
+To make use of the low power playback feature, the application or framework
+needs to open a Intel SST driver handle and send the encoded stream
+like MP3, AAC or WMA through this driver to play out. If its a PCM stream
+the application or framework should use ALSA framework. The PCM stream will
+be handled by Intel MID driver which will inturn make use of Intel SST driver
+to send out pcm data to sound card.
+
+To enable the applications or framework to send encoded data, the Intel SST
+driver exposes few IOCTLS. The following documentation provides how to use the
+Intel SST driver interface.
+
+This documentation provides the interfaces for rendering audio streams and
+tones from the operating system and applications to an audio codec, and
+ultimately to the speaker or headphones and capturing/recording
+audio streams from input devices
+
+Interfaces supported:
+---------------------
+Intel SST driver supports the following set of file operations listed below for
+device /dev/intel_sst:
+	* open
+	* close
+	* mmap
+	* munmap
+	* read
+	* write
+	* readv
+	* writev
+	* ioctl
+
+Intel SST driver supports the following set of file operations for
+device /dev/intel_sst_ctl:
+	* open
+	* close
+	* ioctl
+The description of each the above file operations are provided in the following
+sections.
+
+The /dev/intel_sst device can be used by framework/application to send encoded
+data
+
+The /dev/intel_sst_ctl device needs to be opened only by a privilaged
+application that can control the policy decisions of the system. (AKA Audio
+manager).
+
+open:
+~~~~~
+Application can open the character device through /dev/intel_sst or
+/dev/intel_sst_ctl. Open call through /dev/intel_sst will succeed only when a
+stream can be allocated for the application. But the stream allocation happens
+when the application invokes ioctl system call with SNDRV_SST_STREAM_SET_PARAMS
+IO Control to set the stream parameters. Each handle is specific to a stream
+only and one stream cannot have multiple handles.
+For multiple streams, multiple handles are required to be opened.
+/dev/intel_sst_ctl is expected to be used only by Audio Manager.
+Audio Manager is also assumed to be running as a privileged process with its
+own UID. There is no stream associated when opening with /dev/intel_sst_ctl.
+Multiple handles for /dev/intel_sst are not allowed, and only ONE handle is
+allowed for Audio Manager.
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		- EACCES	Max handles reached
+		- ENODEV	Device is not working
+		- EBUSY	Firmware load fail
+		- EINVAL	Invalid params, Major or minor number
+close:
+~~~~~~
+Appication can close the character device through standard linux close call
+when it completes the playing or recoding The driver will clean up the stream
+related data structures. The driver will free/close the streams allocated.
+In case the stream consists of a mmapped buffer then that will be unmapped.
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		- EBADF	Invalid/Corrupted handle
+		- ENODEV	Device is not working
+		- EBUSY	Device is busy, should retry after delay
+
+mmap:
+~~~~~
+Applicatiion can call this standard linux call to get mmaped buffers. This call
+needs to be called only after stream alloation, else the call would fail
+The optimal  size of buffer which can be requested using this call is provided
+by SNDRV_SST_DRIVER_INFO ioctl. SST Driver will allocate and return the memory
+which needs to be used in SNDRV_SST_MMAP_PLAY/ SNDRV_SST_MMAP_CAPTURE.
+This call is not required to be called in case the application wants to send
+user buffers for playback/capture.Please note that a stream is required to be
+mmapped once in lifetime of stream and unmapped once before close.
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		- EBADF	Invalid handle
+		- EINVAL	Invalid arguments
+		- ENOMEM	Memory allocation failed,
+				retry with smaller size
+		- EBUSY	Device is busy, should retry after delay
+munmap:
+~~~~~~~
+Application should call this the standard Linux munmap system call to free any
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		- EBADF	Invalid handle
+		- EINVAL	Invalid arguments, address ranges
+		- EBUSY	Device is busy, should retry after delay
+write/writev:
+~~~~~~~~~~~~
+The application needs to use this system call when it needs to send buffer(s)
+containing frames to play audio/speech to the output devices such as
+speakers. It is mandatory to invoke SNSDRV_SST_STREAM_SET_PARAMS
+ioctl to set up the parameters for the streams before invoking this
+system call. This system call will return error if it
+is called for a mmapped stream as its expected that mmapped stream uses
+SNDRV_SST_MMAP_PLAY ioctl. The buffer doesnt have any max
+frames/byte/word length constraints but needs a minimal of one frame size.
+For optimization it is recommended that buffer size be a multiple of 20KB along
+the frame boundaries.
+This call will return when
+1)	SNDRV_SST_STREAM_DROP is invoked using another application thread
+2)	The SST firmware has the watermark level for the PCM samples reached
+3)	The stream encounters an error
+	Possible Return Values:
+	~~~~~~~~~~~~~~~~~~~~~~~
+		+ve		Bytes written successfully
+		- EBADF	Invalid handle
+		- EINVAL	Invalid arguments
+		- EBADRQC	Invalid request for the stream
+		- EIO		FW error in write
+read/readv:
+~~~~~~~~~~~
+The application can call this system call when it needs to capture buffer(s) of
+recorded audio/speech from the microphone or any other capture device. It is
+mandatory to invoke SNDRV_SST_SET_PARAMS ioctl to set up the parameters for the
+streams before invoking this system call. This system call will return error if
+it is called for a mmapped stream as its expected that mmapped stream used
+SNDRV_SST_MMAP_CAPTURE ioctl. The buffer doesnt have any max frames/byte/word
+length constraints but needs minimal of one frame size. For optimization its
+recommended that buffer size be multiple of 20KB.
+The read() will return when
+1)	SNDRV_SST_STREAM_DROP is invoked using another application thread
+2)	The SST firmware identifies the watermark level for the PCM samples is reached
+3)	The stream encounters an error
+	Possible Return Values:
+	~~~~~~~~~~~~~~~~~~~~~~~
+	+ve		Bytes read successfully.
+	- EBADF	Invalid handle
+	- EINVAL	Invalid arguments
+	- EBADRQC	Invalid request for the stream
+	- EIO		FW error in read
+ioctl:
+~~~~~~
+SST driver supports a set of IO controls for each device, /dev/intel_sst and
+/dev/intel_sst_ctl. All the IOCTLS are blocked till the corresponding operation
+is complete. The IO controls are;
+
+ioctls for /dev/intel_sst:
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+SNDRV_SST_STREAM_SET_PARAMS	- Set the stream parameter. If sent first
+				time, the stream will be allocated and be kept
+				in initialized state. It is required to send
+				START IO control to start playing.
+SNDRV_SST_STREAM_DROP		- Stop the stream dropping all the frames.
+				ALSA IOCTL reused.
+SNDRV_SST_STREAM_PAUSE		- Pause the stream, no samples are lost
+				ALSA IOCTL reused.
+SNDRV_SST_STREAM_RESUME		- Resume from pause, no samples are lost
+				ALSA IOCTL reused.
+SNDRV_SST_STREAM_GET_TSTAMP	- Get the time stamp
+SNDRV_SST_STREAM_START		- Start the stream playback or capture
+				ALSA IOCTL reused.
+SNDRV_SST_MMAP_PLAY		- Send the mmap buffer to driver for playback
+SNDRV_SST_MMAP_CAPTURE		- Send the mmap buffer to driver for capture
+
+ioctls for /dev/intel_sst_ctrl: (yet to be implemented in the code)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+SNDRV_SST_FW_INFO		- To get or set SST firmware info.
+SNDRV_SST_SET_TARGET_DEVICE	- To select the target device
+				(BT/headphones/speakers/etc)
+
+Common ioctls for /dev/intel_sst and /dev/intel_sst_ctrl:
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+SNDRV_SST_DRIVER_INFO		- To obtain version & capabilities of driver
+
+
+SNDRV_SST_STREAM_SET_PARAMS:
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This IO Control is to allocate a new stream with the firmware for playback or
+capture. The parameters will be used to set up the stream for encoding or
+decoding. This operation should be invoked to allocate a stream successfully
+before using mmap or write or read system call for playback or capture or any
+other ioctl.  Upon successful completion of this IO Control, the stream id is
+filled with a valid number. If the stream is already allocated then driver will
+treat this IOCTL as change of stream parameters. Please note that the
+parameters can be only changed when  SNDRV_SST_STREAM_DROP has been called.
+
+Note: When the application or middleware has stopped playing or recording and
+the stream is idle, it is recommended to close the device and reopen when it
+starts again. It will allow other applications to use the stream for playback
+or recording as the platform allows only limited number of parallel streams.
+
+The set of parameters provided in the structure are:
+
+Codec Parameters which specify the codec specific parameters.
+Post/Pre Processing Parameters specify the post/pre processing enabled
+for each of the stream.
+
+	Data Structures:
+	~~~~~~~~~~~~~~~~
+	struct snd_sst_params {
+		unsigned long 	result;
+		unsigned int 		stream_id;
+		enum sst_codec_type 	codec;
+		enum snd_sst_stream_op	ops;
+		unsigned int		stream_type;
+		struct snd_sst_stream_params sparams;
+	};
+
+	/*result: This field contains the completion status of the
+	requested operation. The value will vary according the stream
+	control operations.
+
+	Result Codes	Description
+		0	Success
+		1	Stream is not available
+		2	Codec is not available
+		3	Codec is not supported
+		4	Invalid Stream Parameters
+		5	Parameter Modified
+		6	Invalid stream identifier*/
+
+	/*stream_id: This is to identify a particular stream
+		0	 Request to allocate new stream.
+		Non Zero Valid stream id*/
+	/*codec: This field specifies which codec is required for this stream
+		Please refer to the code for more info*/
+	/*ops: This field specifies if this stream is for playback or capture.
+
+	Operation		Code	Description
+	STREAM_OPS_PLAYBACK	0x00	For Playback
+	STREAM_OPS_CAPTURE	0x01	For Recording
+	STREAM_OPS_PLAYBACK_DRM	0x02	For Protected content playback
+	STREAM_OPS_PLAYBACK_ALERT 0x03	Alert playback is treated as same as
+					STREAM_OPS_PLAYBACK.
+	STREAM_OPS_CAPTURE_VOICE_CALL 0x04 For Voice conversation recording*/
+
+	/*stream_type: This field will be used in conjunction with stream_op to
+	determine the specific operation of the stream
+
+	Stream Type		Code	Description
+	STREAM_TYPE_MUSIC	0x01	This stream is for Music capture or playback
+	STREAM_TYPE_VOICE	0x02	This stream is for Voice capture or playback*/
+
+	/*params: This field contains the stream parameters. Plese refer the code for
+	the structure*/
+
+
+SNDRV_SST_STREAM_DROP:
+~~~~~~~~~~~~~~~~~~~~~~
+This IO control is to stop the current stream immediately by dropping all
+the frames. If the stream is for playback and it is playing currently,
+the SST driver shall discard the remaining frames before entering into the
+stopped state. If the stream is for capture (recording) and it is capturing
+currently, the driver shall return the current captured data and enter into
+the stopped state Any data threads which are blocked and waiting will be
+unblocked and returned.
+
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+	-EBADF	- Invalid File Descriptor
+	-ENODEV	- Device FW/codec not available or Sound card not available
+	-EINVAL	- Invalid argument
+	-EBADRQC - Bad/Invalid request
+	-EBUSY	- FW didn't respond within timeout
+
+SNDRV_SST_STREAM_PAUSE:
+~~~~~~~~~~~~~~~~~~~~~~~
+This IO Control pauses the running stream. If the stream is already paused,
+the operation will return success. The SST driver and firmware shall maintain
+the current pointers so that it can resume the stream when requested.
+The previously called write/read/writev/readv thread if blocked will continue
+to be blocked.
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		Same as given for SNDRV_SST_STREAM_DROP
+SNDRV_SST_STREAM_RESUME:
+~~~~~~~~~~~~~~~~~~~~~~~~
+This IO Control is to resume the paused stream. If the stream is not paused already
+or it is in running state, the operation will return success
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		Same as given for SNDRV_SST_STREAM_DROP
+
+SNDRV_SST_STREAM_GET_TSTAMP:
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This IO Control returns the rendered stream time in milliseconds
+	Data Structures:
+	~~~~~~~~~~~~~~~~
+		unsigned long long time; /*Elapsed time in milli seconds*/
+
+The timestamp will be constantly incremented and can be read anytime. In case
+of SNDRV_SST_STREAM_PAUSE, the timestamp will also get PAUSED and return the
+same value, as long as resume is not called. In the case of
+SNDRV_SST_STREAM_DROP, the timestamp will not be incremented or reset.
+It will continue to increment from previous value if playback or capture
+is invoked again. When a stream is freed, then timestamp will be reset.
+If the stream is muted with SNDRV_SST_MUTE the stream is still getting
+rendered at zero volume the timestamp will be updated normally
+
+SNDRV_SST_STREAM_START:
+~~~~~~~~~~~~~~~~~~~~~~~
+This IO Control is to start the stream after stream allocation. This call is required
+after any read or write, before which the playback or capture will not start. If the
+SNDRV_SST_STREAM_DROP is called, then application needs to call SNDRV_SST_STREAM_START
+for starting again.
+	Error Codes returned:
+	~~~~~~~~~~~~~~~~~~~~~
+		Same as given for SNDRV_SST_STREAM_DROP
+
+SNDRV_SST_MMAP_PLAY:
+~~~~~~~~~~~~~~~~~~~~
+The application can use this ioctl to send mmapped buffer containing frames to
+play audio/speech to the output devices such as speakers. It is mandatory to
+invoke SNDRV_SST_STREAM_SET_PARAMS ioctl to set up the parameters for the
+streams and mmap() to get mmap buffer before invoking this system call.
+Driver will only accept mmap buffer for this ioctl. Application should fill
+the size and offset fields properly. The buffer doesnt have any max
+frames/byte/word length constraints but needs to be minimal of one frame size.
+To optimize this is recommended to be a multiple of 20KB along the frame
+boundaries.
+This ioctl() will return when
+1)	SNDRV_SST_STREAM_DROP is invoked using another application thread
+2)	The SST firmware identifies watermark level is reached
+3)	The stream encounters an error
+	Data Structures:
+	~~~~~~~~~~~~~~~~
+	struct snd_sst_buff_entry {
+	 	union {
+			void *user;
+			/*user buffer pointer, not valid for this ioctl
+			Used for write() call*/
+			unsigned int offset;
+			/*mmap offset in mmap memory. Valid for this call*/
+		} buffer;
+		unsigned int size;
+		/*size of data valid i.e. the size of mmap buffer sent*/
+	};
+	struct snd_sst_buffs {
+		unsigned int entries;
+		/*Number of buffer entries sent, minimum to be one*/
+		enum snd_sst_buff_type type;
+		/*Buffer type sent, required to SST_BUF_MMAP for this ioctl*/
+		struct snd_sst_buff_entry *buff;
+		/*Pointer to the list of buffers*/
+	};
+
+	Possible Return Values:
+	~~~~~~~~~~~~~~~~~~~~~~~
+	+ve 	- Number of bytes written successfully
+	-EBADF	- Invalid File Descriptor
+	-ENODEV	- Device is not working
+	-EINVAL	- Invalid argument
+	-EBADRQC- Bad request
+
+SNDRV_SST_MMAP_CAPTURE:
+~~~~~~~~~~~~~~~~~~~~~~~
+The application can use this ioctl to send mmapped buffer to capture
+audio/speech from the input devices such as mic. It is mandatory to
+invoke SNDRV_SST_STREAM_SET_PARAMS ioctl to set up the parameters for
+the streams and mmap() to get mmap buffer before invoking this system call.
+Driver will only accept mmap buffer for this ioctl.Application should fill
+the size and offset fields properly. The buffer doesnt have any max
+frames/byte/word length constraints but needs to be minimal of one frame size.
+To optimize this is recommended to be a multiple of 20KB.
+This ioctl() will return when
+1)	SNDRV_SST_STREAM_DROP is invoked using another application thread
+2)	The SST firmware identifies the watermark level for the PCM samples is reached
+3)	The stream encounters an error
+	Data Structures:
+	~~~~~~~~~~~~~~~~
+		Same as given in SNDRV_SST_MMAP_PLAY ioctl.
+
+	Possible Return Values:
+	~~~~~~~~~~~~~~~~~~~~~~~
+		Same as given in SNDRV_SST_MMAP_PLAY ioctl.
+
+SNDRV_SST_DRIVER_INFO:
+~~~~~~~~~~~~~~~~~~~~~~
+This IO Control is to obtain the SST driver static and dynamic information.
+	Data Structures:
+	~~~~~~~~~~~~~~~~
+	struct snd_sst_driver_info {
+		unsigned int    version;
+					/*bit0  - bit7	Minor Version
+					  bit8  - bit15 Major Version
+					  bit16 - bit31 Reserved*/
+		unsigned int    active_pcm_streams;
+		/*total number of PCM streams active at the point*/
+		unsigned int    active_enc_streams;
+		/*total number of encoded streams active at the point*/
+		unsigned int    max_pcm_streams;
+		/*number of PCM streams supported by platform */
+		unsigned int    max_enc_streams;
+		/*number of encoded streams supported by platform*/
+		unsigned int    buf_per_stream;
+		/*optimal size buffer per stream for mmap call*/
+	};
-- 
1.5.4.5
