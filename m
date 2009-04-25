From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: .pointer return value
Date: Sat, 25 Apr 2009 22:43:06 +0530
Message-ID: <98769532B4BB14429434178695419EAE4AAFABBF@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE4AA6D20B@bgsmsx501.gar.corp.intel.com>
	<20090425142002.1e2ddb1a@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id CC446244BF
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 19:13:11 +0200 (CEST)
In-Reply-To: <20090425142002.1e2ddb1a@Jay>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot. That helps.

>-----Original Message-----
>From: Giuliano Pochini [mailto:pochini@shiny.it]
>Sent: Saturday, April 25, 2009 5:50 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] .pointer return value
>
>On Thu, 23 Apr 2009 19:34:08 +0530
>"Harsha, Priya" <priya.harsha@intel.com> wrote:
>
>> Can anyone educate me on what value should be returned to .pointer function?
>> 	Should I be passing the number of frames played till that point from the time stream started or
>thnumber of frames played such that the bytes is within the buf_size?
>
>The latter: it's the index of the last transferred frame in the ring buffer.
>
>
>> And if I am using, snd_pcm_indirect_playback_pointer, what should be my input to it?
>> 	Should I be passing the number of bytes played till that point from the time stream started or the
>number of bytes within buf_size?
>
>In practice, they're both fine. After a quick look at the sources
>in /include/sound/pcm-indirect.h:
>
>----
>static inline snd_pcm_uframes_t
>snd_pcm_indirect_playback_pointer(struct snd_pcm_substream *substream,
>				struct snd_pcm_indirect *rec, unsigned int ptr) {
>        int bytes = ptr - rec->hw_io;
>        if (bytes < 0)
>                bytes += rec->hw_buffer_size;
>        rec->hw_io = ptr;
>----
>
>It cares about the difference from the last position to the current one and
>it adds hw_buffer_size if ptr wrapped around.
>
>Side note:
>I can guess it may not behave correctly in case of long latencies when
>bytes < -hw_buffer_size. Perhaps should the "if" be changed to "while" ?
>
>
>
>--
>Giuliano.
