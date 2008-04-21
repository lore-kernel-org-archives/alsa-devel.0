From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 21 Apr 2008 19:10:51 +0200
Message-ID: <480CCA9B.9030500@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<s5h8wzf4e35.wl%tiwai@suse.de>	<20080420000051.GA20381@tango.0pointer.de>
	<s5hfxtfcoza.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DC9E24436
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 19:10:53 +0200 (CEST)
In-Reply-To: <s5hfxtfcoza.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On 21-04-08 15:32, Takashi Iwai wrote:

> At Sun, 20 Apr 2008 02:00:51 +0200,
> Lennart Poettering wrote:

>> My understanding is that the dB values of this USB device are relative          
>> to its maximum gain, and as such consistent in itself. Does the USB
>> spec define the reference level for the dB values?       
> 
> Not clearly.  IIRC, it's against the line level...

The 1.0 spec calls 0 dB line level indeed and (at least in the context of 
the dynamic range compressor, section 3.5.6.6) suggests that it's "usually 
15-20 dB below the maximum level".

Rene.
