From: Winfried Ritsch <ritsch@iem.at>
Subject: Re: Questions: hw_param rules in rme9652, hdsp.c, also for hdspm.c ?
Date: Thu, 9 Oct 2003 10:22:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16261.6857.620430.156788@seneca.iemnet>
References: <1065636181.3f8451558cf65@iem.at>
	<200310081907.h98J7NBv032021@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310081907.h98J7NBv032021@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: ritsch@iem.at, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Thanx,
 that make it clear.


>> [hw_rules to make min channels max channels]
>>
>>Why ? Is there a reason to let channels min not to be 1 ?
>

>ALSA kernel drivers mirror hardware capabilities. its not possible to
>configure the hardware to use just 1 channel. user space (alsa-lib)
>allows use of other numbers of channels.
>
Ok, on the rme9652 this is definitive true, I agree.

Since I can enable DMA individual on the HDSP-MADI card as a new
function, I can say hardware supports the use of less channels and so
 
 so I will set min channels to 1.

Even I saw in the hdsp.c driver, 

static inline int snd_hdsp_enable_io (hdsp_t *hdsp);
...	
	for (i = 0; i < HDSP_MAX_CHANNELS; ++i) {
		hdsp_write (hdsp, HDSP_inputEnable + (4 * i), 1);
		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
	}
...

which I think, but I am not sure about, can turn DMA-channels for each
channel on and off, so the card can be used with lesser channels (and
DMA-.., PCI-Load) for better performance.

But I think, this isnt a big problem not to use this. On 64channels
with DMA in/out it make sense to scale Bus-usage, since setting  the
matrix mixer you can play all outputs with lesser channels, even with
one.

>
>>C) Rule set rate according to channels:
>   [ ... ]
>>Why is it not allowed to use single speed wenn less channels than double speed
>>can handle are needed ?
>
>same reason.
>

Rule C) Here is a little different question:


	if (c->min >= hdsp->ss_channels) {
		snd_interval_t t = {
			.min = 32000,
			.max = 48000,
			.integer = 1,
		};
		return snd_interval_refine(r, &t);
	} else if (c->max <= hdsp->ds_channels) {
		snd_interval_t t = {
			.min = 64000,
			.max = 96000,
			.integer = 1,
		};
		return snd_interval_refine(r, &t);
	}

should be if (c->min >= hdsp->ds_channels) since ds_channels are lower
count than ss_channels and then single speed should be used if more
channels are requested than ds_channels, that
would make sense.

and second part if (c->max <= hdsp->ds_channels) 
i dont know why to force to double speed ?



mfg winfried






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
