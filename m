From: Brad Midgley <bmidgley@xmission.com>
Subject: documentation tweaks in src/pcm/pcm.c
Date: Fri, 01 Apr 2005 23:24:58 -0700
Message-ID: <424E3ABA.9070707@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I have been reading through some of the generated documentation. It can
be understood as it stands, but some tweaks will avoid
distractions and allow the message to come through more clearly.

I can see the "example_test_pcm" and "example_test_latency" examples in
pcm.c, but the "links" to them in the generated html document
(in my case, file:///home/extra/src/alsa/alsa-lib/src/pcm/pcm.c.html#example_test_pcm
and
file:///home/extra/src/alsa/alsa-lib/src/pcm/pcm.c.html#example_test_latency
respectively) are not found. Did I build the docs incorrectly?
(I did a toplevel "make doc")

Brad

diff -u -b -B -w -p -r1.299 pcm.c
--- src/pcm/pcm.c	29 Mar 2005 16:34:31 -0000	1.299
+++ src/pcm/pcm.c	2 Apr 2005 06:14:05 -0000
@@ -38,52 +38,52 @@

  /*! \page pcm PCM (digital audio) interface

-<P>Although abbreviation PCM stands for Pulse Code Modulation, we are
-understanding it as general digital audio processing with volume samples
+<P>Although the abbreviation PCM stands for Pulse Code Modulation, we
+use it to mean general digital audio processing with samples of varying volume
  generated in continuous time periods.</P>

  <P>The analog signal is recorded via analog to digital converters (ADC).
  The digital value (de-facto a volume at a specific time) obtained
-from ADC can be further processed. The following picture shows a perfect
-sinus waveform:</P>
+from an ADC can be further processed. The following picture shows a perfect
+sinusoidal waveform:</P>

  <BR>
  \image html wave1.gif

-<P>Next image shows digitized representation:</P>
+<P>The next image shows a digitized representation:</P>

  <BR>
  \image html wave2.gif

-<P>As you may see, the quality of digital audio signal depends on the time
+<P>As you may see, the quality of the digital audio signal depends on the time
  (recording rate) and voltage resolution (usually in an linear integer
-representation with basic unit one bit).</P>
+representation with a basic unit of one bit).</P>

-<P>The stored digital signal can be converted back to voltage (analog)
+<P>The stored digital signal can be converted back to a voltage (analog)
  representation via digital to analog converters (DAC).</P>

-<P>One digital value is called sample. More samples are collected to frames
-(frame is terminology for ALSA) depending on count of converters used at one
+<P>One digital value is called a sample. More samples are collected into frames
+(a frame is ALSA terminology) depending on count of converters used at one
  specific time. One frame might contain one sample (when only one converter is
  used - mono) or more samples (for example: stereo has signals from two converters
-recorded at same time). Digital audio stream contains collection of frames
+recorded at the same time). A digital audio stream contains a collection of frames
  recorded at boundaries of continuous time periods.</P>

  \section pcm_general_overview General overview

-ALSA uses the ring buffer to store outgoing (playback) and incoming (capture,
+ALSA uses a ring buffer to store outgoing (playback) and incoming (capture,
  record) samples. There are two pointers being maintained to allow
-a precise communication between application and device pointing to current
-processed sample by hardware and last processed sample by application.
-The modern audio chips allow to program the transfer time periods.
-It means that the stream of samples is divided to small chunks. Device
-acknowledges to application when the transfer of a chunk is complete.
+precise communication between application and device, pointing to the currently
+processed sample by the hardware and the last processed sample by the application.
+Modern audio chips allow one to program the transfer time periods.
+It means that the stream of samples is divided into small chunks. The device
+acknowledges to the application when the transfer of a chunk is complete.

  \section pcm_transfer Transfer methods in UNIX environments

  In the UNIX environment, data chunk acknowledges are received via standard I/O
  calls or event waiting routines (poll or select function). To accomplish
-this list, the asynchronous notification of acknowledges should be listed
+this, the asynchronous notification of acknowledges should be listed
  here. The ALSA implementation for these methods is described in
  the \ref alsa_transfers section.

@@ -93,38 +93,38 @@ The standard I/O transfers are using the
  (see 'man 2 write') C functions. There are two basic behaviours of these
  functions - blocked and non-blocked (see the O_NONBLOCK flag for the
  standard C open function - see 'man 2 open'). In non-blocked behaviour,
-these I/O functions never stops, they return -EAGAIN error code, when no
+these I/O functions never stop--they return a -EAGAIN error code when no
  data can be transferred (the ring buffer is full in our case). In blocked
-behaviour, these I/O functions stop and wait until there is a room in the
-ring buffer (playback) or until there are a new samples (capture). The ALSA
+behaviour, these I/O functions stop and wait until there is room in the
+ring buffer (playback) or until there are new samples (capture). The ALSA
  implementation can be found in the \ref alsa_pcm_rw section.

  \subsection pcm_transfer_event Event waiting routines

  The poll or select functions (see 'man 2 poll' or 'man 2 select' for further
-details) allows to receive requests/events from the device while
-an application is waiting on events from other sources (like keyboard, screen,
-network etc.), too. \ref snd_pcm_poll_descriptors can be used to get a file
+details) allow an application to receive requests/events from the device while
+waiting on events from other sources (like keyboard, screen,
+network etc.). \ref snd_pcm_poll_descriptors can be used to get a file
  descriptor to poll or select on. The implemented
  transfer routines can be found in the \ref alsa_transfers section.

  \subsection pcm_transfer_async Asynchronous notification

-ALSA driver and library knows to handle the asynchronous notifications over
-the SIGIO signal. This signal allows to interrupt application and transfer
-data in the signal handler. For further details see the sigaction function
+The ALSA driver and library accomplish asynchronous notifications using
+the SIGIO signal. This signal interrupts the application and
+data is transferred to it in its signal handler. For further details see the sigaction function
  ('man 2 sigaction'). The section \ref pcm_async describes the ALSA API for
-this extension. The implemented transfer routines can be found in the
+this extension. The transfer routines can be found in the
  \ref alsa_transfers section.

  \section pcm_open_behaviour Blocked and non-blocked open

-The ALSA PCM API uses a different behaviour when the device is opened
-with blocked or non-blocked mode. The mode can be specified with
+The ALSA PCM API uses different behaviour when the device is opened
+in blocked or non-blocked mode. The mode can be specified with
  \a mode argument in #snd_pcm_open() function.
-The blocked mode is the default (without #SND_PCM_NONBLOCK mode).
-In this mode, the behaviour is that if the resources have already used
-with another application, then it blocks the caller, until resources are
+Blocked mode is the default (without #SND_PCM_NONBLOCK mode).
+In this mode, the behaviour is that if the resources have already been used
+with another application, then it blocks the caller until resources are
  free. The non-blocked behaviour (with #SND_PCM_NONBLOCK)
  doesn't block the caller in any way and returns -EBUSY error when the
  resources are not available. Note that the mode also determines the
@@ -135,7 +135,7 @@ the #snd_pcm_nonblock() function.

  \section pcm_async Asynchronous mode

-There is also possibility to receive asynchronous notification after
+It is also possibile to receive asynchronous notifications after
  specified time periods. You may see the #SND_PCM_ASYNC
  mode for #snd_pcm_open() function and
  #snd_async_add_pcm_handler() function for further details.
@@ -144,13 +144,13 @@ mode for #snd_pcm_open() function and

  The ALSA PCM API design uses the states to determine the communication
  phase between application and library. The actual state can be determined
-using #snd_pcm_state() call. There are these states:
+using #snd_pcm_state() call. The states are:

  \par SND_PCM_STATE_OPEN
  The PCM device is in the open state. After the #snd_pcm_open() open call,
  the device is in this state. Also, when #snd_pcm_hw_params() call fails,
-then this state is entered to force application calling
-#snd_pcm_hw_params() function to set right communication
+then this state is entered to force the application calling
+#snd_pcm_hw_params() function to set the right communication
  parameters.

  \par SND_PCM_STATE_SETUP
@@ -159,7 +159,7 @@ for #snd_pcm_prepare() call to prepare t
  selected operation (playback or capture).

  \par SND_PCM_STATE_PREPARE
-The PCM device is prepared for operation. Application can use
+The PCM device is prepared for operation. Applications can use
  #snd_pcm_start() call, write or read data to start
  the operation.

@@ -178,24 +178,24 @@ this state with #snd_pcm_prepare(),
  #snd_pcm_drop() or #snd_pcm_drain() calls.

  \par SND_PCM_STATE_DRAINING
-The device is in this state when application using the capture mode
-called #snd_pcm_drain() function. Until all data are
+The device is in this state when the application using the capture mode
+called the #snd_pcm_drain() function. Until all data are
  read from the internal ring buffer using I/O routines
  (#snd_pcm_readi(), #snd_pcm_readn()),
-then the device stays in this state.
+the device stays in this state.

  \par SND_PCM_STATE_PAUSED
-The device is in this state when application called
+The device is in this state when the application called
  the #snd_pcm_pause() function until the pause is released.
-Not all hardware supports this feature. Application should check the
+Not all hardware supports this feature. Applications should check the
  capability with the #snd_pcm_hw_params_can_pause().

  \par SND_PCM_STATE_SUSPENDED
  The device is in the suspend state provoked with the power management
-system. The stream can be resumed using #snd_pcm_resume()
-call, but not all hardware supports this feature. Application should check
+system. The stream can be resumed using the #snd_pcm_resume()
+call, but not all hardware supports this feature. Applications should check
  the capability with the #snd_pcm_hw_params_can_resume().
-In other case, the calls #snd_pcm_prepare(),
+If it is supported, the calls #snd_pcm_prepare(),
  #snd_pcm_drop(), #snd_pcm_drain() can be used
  to leave this state.

@@ -205,49 +205,49 @@ The device is physicaly disconnected. It
  \section pcm_formats PCM formats

  The full list of formats present the #snd_pcm_format_t type.
-The 24-bit linear samples uses 32-bit physical space, but the sample is
-stored in low three bits. Some hardware does not support processing of full
+24-bit linear samples use 32-bit physical space, but the sample is
+stored in the low three bytes. Some hardware does not support processing the full
  range, thus you may get the significant bits for linear samples via
  #snd_pcm_hw_params_get_sbits() function. The example: ICE1712
-chips support 32-bit sample processing, but low byte is ignored (playback)
+chips support 32-bit sample processing, but the low byte is ignored (playback)
  or zero (capture). The function snd_pcm_hw_params_get_sbits()
  returns 24 in the case.

  \section alsa_transfers ALSA transfers

-There are two methods to transfer samples in application. The first method
-is the standard read / write one. The second method, uses the direct audio
-buffer to communicate with the device while ALSA library manages this space
+There are two methods to transfer samples in the application. The first method
+is the standard read / write one. The second method uses the direct audio
+buffer to communicate with the device while the ALSA library manages this space
  itself. You can find examples of all communication schemes for playback
-in \ref example_test_pcm "Sine-wave generator example". To complete the
-list, we should note that #snd_pcm_wait() function contains
-embedded poll waiting implementation.
+in \ref example_test_pcm "Sine-wave generator example." To complete the
+list, we should note that the #snd_pcm_wait() function contains
+an embedded poll waiting implementation.

  \subsection alsa_pcm_rw Read / Write transfer

  There are two versions of read / write routines. The first expects the
  interleaved samples at input (#SND_PCM_ACCESS_RW_INTERLEAVED access method),
  and the second one expects non-interleaved (samples in separated buffers -
-#SND_PCM_ACCESS_RW_NONINTERLEAVED access method) at input. There are these
-functions for interleaved transfers: #snd_pcm_writei()
-#snd_pcm_readi(). For non-interleaved transfers, there are
-these functions: #snd_pcm_writen() and #snd_pcm_readn().
+#SND_PCM_ACCESS_RW_NONINTERLEAVED access method) at input. The
+functions for interleaved transfers are #snd_pcm_writei() and
+#snd_pcm_readi(). For non-interleaved transfers, the
+functions are #snd_pcm_writen() and #snd_pcm_readn().

  \subsection alsa_mmap_rw Direct Read / Write transfer (via mmap'ed areas)

-Three kinds of organization of ring buffer memory areas exist in ALSA API.
+There are three kinds of of ring buffer memory areas in the ALSA API.
  Access #SND_PCM_ACCESS_MMAP_INTERLEAVED has interleaved samples. Access
  #SND_PCM_ACCESS_MMAP_NONINTERLEAVED expects continous sample areas for
-one channel. Access #SND_PCM_ACCESS_MMAP_COMPLEX does not fit to interleaved
+one channel. Access #SND_PCM_ACCESS_MMAP_COMPLEX does not fit with interleaved
  and non-interleaved ring buffer organization.

  There are two functions for this kind of transfer. Application can get an
  access to memory areas via #snd_pcm_mmap_begin() function.
  This function returns the areas (single area is equal to a channel)
  containing the direct pointers to memory and sample position description
-in #snd_pcm_channel_area_t structure. After application
+in #snd_pcm_channel_area_t structure. After an application
  transfers the data in the memory areas, then it must be acknowledged
-the end of transfer via #snd_pcm_mmap_commit() function
+at the end of transfer via #snd_pcm_mmap_commit() function
  to allow the ALSA library update the pointers to ring buffer. This kind of
  communication is also called "zero-copy", because the device does not require
  to copy the samples from application to another place in system memory.
@@ -262,11 +262,11 @@ and #snd_pcm_writen() functions.
  \section pcm_params Managing parameters

  The ALSA PCM device uses two groups of PCM related parameters. The hardware
-parameters contains the stream description like format, rate, count of
-channels, ring buffer size etc. The software parameters contains the
+parameters contain the stream description like format, rate, count of
+channels, ring buffer size, etc. The software parameters contains the
  software (driver) related parameters. The communication behaviour can be
  controlled via these parameters, like automatic start, automatic stop,
-interrupting (chunk acknowledge) etc. The software parameters can be
+interrupting (chunk acknowledge), etc. The software parameters can be
  modified at any time (when valid hardware parameters are set). It includes
  the running state as well.

@@ -283,14 +283,14 @@ application sets single parameters until
  ALSA knows about five access modes. The first three can be used for direct
  communication. The access mode #SND_PCM_ACCESS_MMAP_INTERLEAVED
  determines the direct memory area and interleaved sample organization.
-Interleaved organization means, that samples from channels are mixed together.
+Interleaved organization means that samples from channels are mixed together.
  The access mode #SND_PCM_ACCESS_MMAP_NONINTERLEAVED
  determines the direct memory area and non-interleaved sample organization.
  Each channel has a separate buffer in the case. The complex direct memory
  organization represents the #SND_PCM_ACCESS_MMAP_COMPLEX
  access mode. The sample organization does not fit the interleaved or
  non-interleaved access modes in the case. The last two access modes
-describes the read / write access methods.
+describe the read / write access methods.
  The #SND_PCM_ACCESS_RW_INTERLEAVED access represents the read /
  write interleaved access and the #SND_PCM_ACCESS_RW_NONINTERLEAVED
  represents the non-interleaved access.
@@ -308,18 +308,18 @@ any time including the running state.
  \par Minimum available count of samples

  This parameter controls the wakeup point. If the count of available samples
-is equal or greater than this value, then application will be activated.
+is equal to or greater than this value, then application will be activated.

  \par Timestamp mode

-The timestamp mode specifies, if timestamps are activated. Currently, only
+The timestamp mode specifies if timestamps are activated. Currently, only
  #SND_PCM_TSTAMP_NONE and #SND_PCM_TSTAMP_MMAP
  modes are known. The mmap mode means that timestamp is taken
  on every period time boundary.

  \par Minimal sleep

-This parameters means the minimum of ticks to sleep using a standalone
+This parameters is the minimum of ticks to sleep using a standalone
  timer (usually the system timer). The tick resolution can be obtained
  via the function #snd_pcm_hw_params_get_tick_time(). This
  function can be used to fine-tune the transfer acknowledge process. It could
@@ -334,28 +334,28 @@ is ignored by device. Usually, this valu
  \par Start threshold

  The start threshold parameter is used to determine the start point in
-stream. For playback, if samples in ring buffer is equal or greater than
+a stream. For playback, if samples in the ring buffer is equal or greater than
  the start threshold parameters and the stream is not running, the stream will
  be started automatically from the device. For capture, if the application wants
  to read count of samples equal or greater then the stream will be started.
  If you want to use explicit start (#snd_pcm_start), you can
-set this value greater than ring buffer size (in samples), but use the
+set this value to be greater than the ring buffer size (in samples), but using the
  constant MAXINT is not a bad idea.

  \par Stop threshold

  Similarly, the stop threshold parameter is used to automatically stop
  the running stream, when the available samples crosses this boundary.
-It means, for playback, the empty samples in ring buffer and for capture,
-the filled (used) samples in ring buffer.
+It means, for playback, the empty samples in the ring buffer and for capture,
+the filled (used) samples in the ring buffer.

  \par Silence threshold

-The silence threshold specifies count of samples filled with silence
+The silence threshold specifies the count of samples filled with silence
  ahead of the current application pointer for playback. It is usable
  for applications when an overrun is possible (like tasks depending on
-network I/O etc.). If application wants to manage the ahead samples itself,
-the #snd_pcm_rewind() function allows to forget the last
+network I/O etc.). If an application wants to manage the ahead samples itself,
+the #snd_pcm_rewind() function allows it to forget the last
  samples in the stream.

  \section pcm_status Obtaining stream status
@@ -392,9 +392,9 @@ r/w pointer for applications, so the fun
  must be called afterwards before any read/write/begin+commit operations.
  <p>
  The function #snd_pcm_delay() returns the delay in samples.
-For playback, it means count of samples in the ring buffer before
-the next sample will be sent to DAC. For capture, it means count of samples
-in the ring buffer before the next sample will be captured from ADC. It works
+For playback, it is the count of samples in the ring buffer before
+the next sample will be sent to a DAC. For capture, it is the count of samples
+in the ring buffer before the next sample will be captured from an ADC. It works
  only when the stream is in the running or draining (playback only) state.
  Note that this function does not update the current r/w pointer for applications,
  so the function #snd_pcm_avail_update() must be called afterwards
@@ -407,10 +407,10 @@ The following functions directly and ind
  \par snd_pcm_hw_params
  The #snd_pcm_hw_params() function brings the stream state
  to #SND_PCM_STATE_SETUP
-if successfully finishes, otherwise the state #SND_PCM_STATE_OPEN
+if it successfully finishes, otherwise the state #SND_PCM_STATE_OPEN
  is entered.
-When it is brought to SETUP state, this function automatically
-calls #snd_pcm_prepare() function to bring to the PREPARE state
+When it is brought to the SETUP state, this function automatically
+calls the #snd_pcm_prepare() function to bring to the PREPARE state
  as below.

  \par snd_pcm_prepare
@@ -447,7 +447,7 @@ functions can conditionally start the st
  #SND_PCM_STATE_RUNNING. They depend on the start threshold
  software parameter.

-\section pcm_sync Streams synchronization
+\section pcm_sync Stream synchronization

  There are two functions allowing link multiple streams together. In the
  case, the linking means that all operations are synchronized. Because the
@@ -505,7 +505,7 @@ hw:DEV=1,CARD=soundwave,SUBDEV=2
  \subsection pcm_dev_names_plughw Plug->HW device

  The plughw device description uses the plug plugin and hw plugin as slave. The arguments
-are same as for hw device.
+are the same as for hw device.

  Example:

@@ -545,8 +545,8 @@ shm:SOCKET='/tmp/alsa.sock',PCM=default

  \subsection pcm_dev_names_tee Tee device

-The tee device stores contents of a stream to given file plus transfers it to given slave plugin.
-The three arguments (in order: SLAVE,FILE,FORMAT) specify slave plugin, filename and file format.
+The tee device stores contents of a stream to given file plus transfers it to the given slave plugin.
+The three arguments (in order: SLAVE,FILE,FORMAT) specify the slave plugin, filename and file format.

  Example:

@@ -567,12 +567,12 @@ file:'/tmp/out.raw',raw

  \subsection pcm_dev_names_null Null device

-The null device is null plugin. This device has not any arguments.
+The null device is a null plugin. This device has no arguments.


  \section pcm_examples Examples

-The full featured examples with cross-links:
+Complete examples with links:

  \par Sine-wave generator
  \ref example_test_pcm "example code"



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
