From: "Gupta, Suresh" <Suresh.Gupta@lsi.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Thu, 29 Sep 2011 12:42:41 +0530
Message-ID: <B2FD678A64EAAD45B089B123FDFC3ED70166618A6E@inbmail01.lsi.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id DF308103843
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 09:12:50 +0200 (CEST)
In-Reply-To: <s5hipobc1it.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

LSI Modem always checks the "opened" bit of "azx_dev" before opening the stream. Modem sets "opened" bit and 
use stream if and only if that "opened" bit was not set otherwise move to next stream "azx_dev".

I found that the ALSA unset this "opened" bit on close but do not reset  AC_VERB_SET_CHANNEL_STREAMID of IDC codec. 
Due to which IDC Codec always get active and always sending data to stream 0. Now when LSI modem check the "opened" 
bit of stream 0, it found it is not set and open the stream 0 and start reading data from stream 0. As IDC codec 
still sending data on stream 0 the LSI Modem get this unexpected data and stop working.
  
I believe the Code (below) which checks "no_sticky_stream" is the culprit due to which "really_cleanup_stream" 
function is not called. I found the Analog devices codec set "no_sticky_stream" while probing their codec. 
This is the reason, our modem works on HP laptop with Analog device codec.
 
According to me the IDC codec should stop sending data after closing the stream or otherwise they should always acquire the stream which is not right. 

I don't know why "no_sticky_stream" come into new code and what's it significance. Why only Analog devices use this "no_sticky_stream".  

Thanks
SuresH

void __snd_hda_codec_cleanup_stream(struct hda_codec *codec, hda_nid_t nid,
				    int do_now)
{
	struct hda_cvt_setup *p;
	if (!nid)
		return;

	if (codec->no_sticky_stream)
		do_now = 1;

	snd_printdd("hda_codec_cleanup_stream: NID=0x%x\n", nid);
	p = get_hda_cvt_setup(codec, nid);
	if (p) {
		/* here we just clear the active flag when do_now isn't set;
		 * actual clean-ups will be done later in
		 * purify_inactive_streams() called from snd_hda_codec_prpapre()
		 */
		if (do_now)
			really_cleanup_stream(codec, p);
		else
			p->active = 0;
	}
}

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, September 29, 2011 11:51 AM
To: Gupta, Suresh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] LSI HDA Modem is not working on HP new Laptop which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver 1.0.24.

At Thu, 29 Sep 2011 10:51:28 +0530,
Gupta, Suresh wrote:
> 
> Modem receive unwanted data on stream 0 even stream is not open by any device.
> Stream 0 was acquired by IDC 7605 and this codec keep sending something even after closing the stream.

Why does the LSI modem device receive from the stream of IDT codec at
all?  In other words, how does LSI modem driver manage the allocation
of streams?


Takashi
