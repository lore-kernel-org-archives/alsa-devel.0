From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Question regarding snd_pcm_control_ioctl
Date: Fri, 22 Oct 2010 09:37:32 +0100
Message-ID: <2A84145621092446B6659B8A0F28E26F46FE8E4B5B@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C95A2432C
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 10:37:37 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have question concerning ALSA Core snd_pcm_control_ioctl function.

I have noticed that the IOCTL fails if it's called for a device with substream_count = 0, since I'm implementing a PCM device that supports Record and does not support Playback, the IOCTL fails when called for the Playback stream. I would propose, in such case, to return that the stream has 0 playback substreams instead of failing.

Thanks in advance for your help,

Regards,

Selma.





---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
