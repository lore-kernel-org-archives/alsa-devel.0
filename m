From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: HD-Audio: How to reduce driver initializaton time if
 multiple codecs present on the bus?
Date: Thu, 28 Nov 2013 14:57:22 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141EEE6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BC1C261A1B
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:57:33 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Takashi
 Iwai (tiwai@suse.de)" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

We're trying to reduce the HD-A driver initialization time when more than one codecs are connected to the bus, but are blocked.
Would you please share some advices on this?

Usually, there is one HD-A controller connecting to two codecs: one on-board codec and one integrated display codec.
During initialization, the codecs are created and configured in a serial way.

Creating a codec may cost 6~20ms, and then building controls make cost about 15~30ms.
So I had thought it's helpful to build controls for different codecs in parallel in function snd_hda_build_controls(), as we did in driver suspend/resume.

But the test shows this doesn't work:

(1)     Using a workqueue without WQ_UNBOUND, the work items, which calls snd_hda_codec_build_controls(), are processed one after one

(I think because there is no explicit sleep in the work function). So the total time does not change.



(2)     Using an unbouned work queue for the bus or using separate kthreads for each codec, the work items for different codecs are processed in parallel.

However, the total time is still the sum of two codec as that without parallel.
I think that because snd_hda_codec_read() are used during initialization, the command execution on bus is serialized in the low level.
So even if we parallel initializing two codecs in high level, commands on bus are still processed one by one so the total time cannot reduce.

We're blocked here. Is there any other means to reduce the time?

Thanks
Mengdong
