From: Przemek Gajos <Przemek.Gajos@datapath.co.uk>
Subject: duplicate timestamps when capturing from multiple
 sources with a single gst-launch-0.1 command (2 pipelines in a single
 command)
Date: Fri, 22 Jul 2016 14:03:02 +0000
Message-ID: <D41405BF79192744BE760C4B5228529895B72C2D@LEICESTER.internal.datapath.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 4658626585A
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 16:03:13 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "przemyslaw.gajos@gmail.com" <przemyslaw.gajos@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,
I hope this is the right place to describe this problem.

I am an ALSA driver developer I have encountered an issue of duplicate timestamps when simultaneously capturing from multiple alsa sources with gst-launch-0.1.

Capture command:
gst-launch-0.10 -v alsasrc device=hw:2 num-buffers=5 ! fakesink name=dig alsasrc device=hw:1 num-buffers=5 ! audiorate ! fakesink name=ANALOG | grep last-message | grep timestamp

These are the initial messages from gst-launch-0.1 app (note that first and second timestamp for the ANALOG source is 0):
/GstPipeline:pipeline0/GstFakeSink:ANALOG: last-message = "chain   ******* (ANALOG:sink) (32768 bytes, timestamp: 0:00:00.000000000, duration: 0:00:00.185759637, offset: 0, offset_end: 8192, flags: 160 discont gap ) 0x1a89f20"
/GstPipeline:pipeline0/GstFakeSink:ANALOG: last-message = "chain   ******* (ANALOG:sink) (32768 bytes, timestamp: 0:00:00.000000000, duration: 0:00:00.185759637, offset: 0, offset_end: 8192, flags: 160 discont gap ) 0x1a89f20"
/GstPipeline:pipeline0/GstFakeSink:ANALOG: last-message = "chain   ******* (ANALOG:sink) (16384 bytes, timestamp: 0:00:00.185759637, duration: 0:00:00.092879818, offset: 8192, offset_end: 12288, flags: 0 ) 0x1a89e80"
/GstPipeline:pipeline0/GstFakeSink:dig: last-message = "chain   ******* (dig:sink) (16384 bytes, timestamp: 0:00:00.092879818, duration: 0:00:00.092879819, offset: 4096, offset_end: 8192, flags: 0 ) 0x7f6164002dc0"

But it does not have to be zero. Sometimes it will have a value though still it will be duplicated.

I never see the issue when capturing form a single source.
Also, timestamps are CORRECT when splitting the above command into 2 separate commands and trying to run them simultaneously from script (commands run in background are run as close to one another as possible).
Therefore, I am thinking: could there be any problems in the layers of ALSA between the driver and an app to set timestamps correctly when the single app does multiple captures from multiple devices (like the first command I wrote at the top)?

I am "looking" into this direction because in my driver I see the following calls:
2016-07-22T13:28:49.788041+01:00 ubuntu-12 kernel: [13830.118539] rgb133: In rgb133_mychip_pcm_trigger(1) OEM_VISIONRGB_AV Analog: DMA START,  chip->last_ptr(0)
2016-07-22T13:28:49.788043+01:00 ubuntu-12 kernel: [13830.118545] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(0)
2016-07-22T13:28:49.788045+01:00 ubuntu-12 kernel: [13830.118581] rgb133: In rgb133_mychip_pcm_trigger(1) OEM_VISIONRGB_AVHD Dig Node1: DMA START,  chip->last_ptr(0)
2016-07-22T13:28:49.788047+01:00 ubuntu-12 kernel: [13830.118587] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(0)
2016-07-22T13:28:49.868018+01:00 ubuntu-12 kernel: [13830.195580] rgb133: -> SndPcmNewDataNotify OEM_VISIONRGB_AV Analog: cur_ptr(16384)
2016-07-22T13:28:49.868031+01:00 ubuntu-12 kernel: [13830.195585] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(16383)
2016-07-22T13:28:49.876011+01:00 ubuntu-12 kernel: [13830.203555] rgb133: -> SndPcmNewDataNotify OEM_VISIONRGB_AVHD Dig Node1: cur_ptr(16384)
2016-07-22T13:28:49.876023+01:00 ubuntu-12 kernel: [13830.203559] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(16383)
2016-07-22T13:28:49.960057+01:00 ubuntu-12 kernel: [13830.287300] rgb133: -> SndPcmNewDataNotify OEM_VISIONRGB_AV Analog: cur_ptr(0)
2016-07-22T13:28:49.960069+01:00 ubuntu-12 kernel: [13830.287304] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(32767)
2016-07-22T13:28:49.960071+01:00 ubuntu-12 kernel: [13830.287336] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(32767)
2016-07-22T13:28:49.960074+01:00 ubuntu-12 kernel: [13830.287342] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(32767)
2016-07-22T13:28:49.960076+01:00 ubuntu-12 kernel: [13830.287395] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(28671)
2016-07-22T13:28:49.960077+01:00 ubuntu-12 kernel: [13830.287409] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(28671)
2016-07-22T13:28:49.960079+01:00 ubuntu-12 kernel: [13830.287457] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(28671)
2016-07-22T13:28:49.960081+01:00 ubuntu-12 kernel: [13830.287464] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(28671)
2016-07-22T13:28:49.960083+01:00 ubuntu-12 kernel: [13830.287514] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(28671)
2016-07-22T13:28:49.968030+01:00 ubuntu-12 kernel: [13830.295282] rgb133: -> SndPcmNewDataNotify OEM_VISIONRGB_AVHD Dig Node1: cur_ptr(0)
2016-07-22T13:28:49.968041+01:00 ubuntu-12 kernel: [13830.295287] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AVHD Dig Node1: return(32767)
2016-07-22T13:28:50.052020+01:00 ubuntu-12 kernel: [13830.379040] rgb133: -> SndPcmNewDataNotify OEM_VISIONRGB_AV Analog: cur_ptr(16384)
2016-07-22T13:28:50.052032+01:00 ubuntu-12 kernel: [13830.379045] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(16383)
2016-07-22T13:28:50.052035+01:00 ubuntu-12 kernel: [13830.379101] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(16383)
2016-07-22T13:28:50.052037+01:00 ubuntu-12 kernel: [13830.379108] rgb133:    <- rgb133_mychip_pcm_pointer OEM_VISIONRGB_AV Analog: return(16383)

Let me explain:

-          SndPcmNewDataNotify is my (driver's) notification to the ALSA middle layer that there is new data ready for it (calling snd_pcm_period_elapsed); period size is 16384 bytes.

-          rgb133_mychip_pcm_pointer is the ALSA layer querying the pointer position in the buffer (I guess this is involved in timestamp creation, correct?).
(note that I actually return bytes_to_frames() of what you see above as ALSA expects)

Above, I have marked what I think is "shady": I notify ALSA of new data for the ANALOG source (blue),  ALSA layer calls back to the driver asking for pointer position for ANALOG (blue),  ALSA layer calls back to the driver asking for pointer position for dig source(red) but the driver has not notified ALSA that there is new data for the dig source!

In the working case, the call stack in the driver is what I would expect, that is:

-          SndPcmNewDataNotify for ANALOG

-          .pointer callback(s) for ANALOG

-          SndPcmNewDataNotify for dig

-          .pointer callback(s) for dig

-          SndPcmNewDataNotify for ANALOG

-          .pointer callback(s) for ANALOG

... and so on...

Thanks a lot for any suggestions,
Przemek Gajos
