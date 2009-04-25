From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: .pointer return value
Date: Sat, 25 Apr 2009 14:20:02 +0200
Message-ID: <20090425142002.1e2ddb1a@Jay>
References: <98769532B4BB14429434178695419EAE4AA6D20B@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A9D1243A9
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 14:19:57 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE4AA6D20B@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Apr 2009 19:34:08 +0530
"Harsha, Priya" <priya.harsha@intel.com> wrote:

> Can anyone educate me on what value should be returned to .pointer function?
> 	Should I be passing the number of frames played till that point from the time stream started or thnumber of frames played such that the bytes is within the buf_size?

The latter: it's the index of the last transferred frame in the ring buffer.


> And if I am using, snd_pcm_indirect_playback_pointer, what should be my input to it?
> 	Should I be passing the number of bytes played till that point from the time stream started or the number of bytes within buf_size?

In practice, they're both fine. After a quick look at the sources
in /include/sound/pcm-indirect.h:

----
static inline snd_pcm_uframes_t
snd_pcm_indirect_playback_pointer(struct snd_pcm_substream *substream,
				struct snd_pcm_indirect *rec, unsigned int ptr) {
        int bytes = ptr - rec->hw_io;
        if (bytes < 0)
                bytes += rec->hw_buffer_size;
        rec->hw_io = ptr;
----

It cares about the difference from the last position to the current one and
it adds hw_buffer_size if ptr wrapped around.

Side note:
I can guess it may not behave correctly in case of long latencies when
bytes < -hw_buffer_size. Perhaps should the "if" be changed to "while" ?



-- 
Giuliano.
