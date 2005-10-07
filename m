From: Bill Gatliff <bgat@billgatliff.com>
Subject: What is the format of dma_area?
Date: Thu, 06 Oct 2005 22:15:49 -0500
Message-ID: <4345E865.9060102@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from saturn.billgatliff.com (saturn.billgatliff.com [209.251.101.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8669B173
	for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2005 05:16:08 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guys:


I'm trying to write a PCM driver that uses an AC97 codec, on an ARM 
host, but no DMA.  (Please pardon some of my terminology, I'm a bit of 
an ALSA noob).

My trigger() looks something like this:

int *buffer;
int bytes;
...
  switch (cmd) {
  case SNDRV_PCM_TRIGGER_START:
    bytes = frames_to_bytes(substream->runtime, 
substream->runtime->period_size);
    buffer = substream->runtime->dma_area;
...

Then, I copy *buffer++ out to the codec one 32-bit chunk (truncated to 
20 bits) at a time.

One thing I don't understand is how dma_area is formatted.  Is it a 
stream of integers, like this?

int dma_area[channels][samples];

... or like this?

int dma_area[samples][channels];

... or what?  I'm having trouble figuring out where the left- and 
right-channel data is in the dma buffer.


Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
