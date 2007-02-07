From: "Micha Nelissen" <micha.nelissen@Prodrive.nl>
Subject: Re: Driver mmap kernel memory
Date: Wed, 7 Feb 2007 09:31:50 +0100
Message-ID: <4CD35CD1F8085945B597F80EEC894213092024@exc01.bk.prodrive.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Development List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> Has anyone seen this behaviour before, and how to fix it ? Or, any
>> hints how to reproduce the alsa mmap behaviour in a smaller software
>> stack ? 
> 
> Which architecture is it?  It might be a memory coherency problem.
> Does the normal snd_pcm_writei() work as expected?

The CPU architecture is armeb.

I have more information now. The problem disappears if I do the endian
swap in the kernel driver. That means that I specify
SNDDRV_PCM_FMTBIT_S16_BE | SNDDRV_PCM_FMTBIT_S16_LE, instead of only
SNDDRV_PCM_FMTBIT_S16_BE, and I decide using the runtime->format whether
to swap or not.

Hope this helps,

Micha

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
