From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 17:56:49 +0100
Message-ID: <47D56851.2000509@keyaccess.nl>
References: <20080310162130.AFFD3DBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 89784103824
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 17:56:24 +0100 (CET)
In-Reply-To: <20080310162130.AFFD3DBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10-03-08 17:21, Bob Tracy wrote:

> Rene Herman wrote:

>>> Bob Tracy wrote:
>>>> Supposedly with the ES1888, dma1 is for capture, dma2 is for playback. 
>>>> dma2 == 5 is a 16-bit channel, yes?  That could explain much...
>> It is, but what would it explain? You're only having playback problems, right?
> 
> dma2 is for playback, I'm having playback problems, dma2 == 5 is a
> a 16-bit channel, and 16-bit DMA is an issue with the es18xx driver
> (according to the comment near the top of the file).

Yes, never mind, misread.

>> Can it be forced to use dma2=0 (an 8-bit channel, and the usual capture 
>> channel on es18xx)? However, that might not be the issue anyway:
> 
> I'll try a few things like dma2 == dma1, and setting dma2 to an 8-bit
> channel, but I think the various configuration parameters are hard-wired
> on the Alpha (not PnP).

Settable through BIOS perhaps? But anyways, if it used to work, it should 
work and I really suspect it's just a matter of a  broken OSS emulation on 
alpha anyways. In fact, I fairly distinctly remember this being an issue not 
too long ago but google is coming up empty...

Takashi? Wasn't there an OSS emulation on Alpha thing a while ago?

>> This sounds very suspiciously like a difference with playing through the 
>> native ALSA interface and the OSS emulaion. Could you and/or Bob confirm 
>> that sox is using the OSS emulation and not ALSA natively?
>>
>> I could very well imagine the ALSA OSS emulation being broken on Alpha. I 
>> doubt any of teh developers has an Alpha. And if aplay works correctly this 
>> seems very likely.
> 
> I'll see if I can verify whether it's a native ALSA vs. OSS emulation
> issue.
> 
> The local version of sox (Debian 12.7.9-1) contains a library dependency
> on libasound.so.2, and a "strings" on the binary yields "ALSA_0.9.0rc4"
> as well as several ALSA error message strings.  However, output by
> default goes to /dev/dsp (major 14, minor 3), which is definitely OSS.

That's an expected string and very likely doesn't mean you have a 0.9.0-rc4 
alsa-lib installed. "strings [ ... ] | grep ^ALSA_" probably shows a few 
later versions as well. But if the problem's the (kernel) OSS emulation then 
userspace dopesn't matter anyway.

You seem to have sox installed, so try

$ sox foo.wav -t alsa default

and

$ sox foo.wav -t ossdsp /dev/dsp

to have it play through the ALSA and OSS interfaces, respectively.

Rene.
