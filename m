From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Sat, 22 Dec 2007 12:39:55 +0500
Message-ID: <fkif0k$adr$1@ger.gmane.org>
References: <s5hprx12x6x.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E9E01037FC
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 08:55:27 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J5zCJ-0001jf-1M
	for alsa-devel@alsa-project.org; Sat, 22 Dec 2007 07:55:03 +0000
Received: from 212.220.119.5 ([212.220.119.5])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 07:55:03 +0000
Received: from patrakov by 212.220.119.5 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 07:55:03 +0000
In-Reply-To: <Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 20 Dec 2007, Takashi Iwai wrote:
> 
>> Hi,
>>
>> another thing I'd like to push into the next kernel is the virtual
>> master volume control.  As I posted in earlier posts, it adds virtual
>> controls that have several slave controls with the same types,
>> e.g. Front, Surround, Center, LFE, etc.  Then these are adjusted
>> simultaneously via the master control.
>>
>> It'd be appreciated if some one can test the patches with HD-audio h/w
>> that has no master control yet (e.g. some STAC codecs).
>>
>> Note that this won't add the master volumes if there are no real
>> volume controls.  Some codecs have really no volume control, and this
>> won't help for such devices.
>>
>> Two (and one for driver) patches will follow after this.
> 
> NAK from my side. I am convinced that this code can be implemented in the 
> user space even without any daemon just in the mixer abstract layer using 
> standard control elements and using eventually new user controls to store 
> data for virtual mixer controls.

Aren't the patches supposed to be useful also for OSS-only apps, where userspace 
solutions can't work without LD_PRELOAD hacks? Currently, without the patch and 
the "aoss" wrapper, OSS apps sound too loud. I have not tested the patch, but I 
am too lazy to change each .desktop file for each OSS-only application provided 
by the distribution.

-- 
Alexander E. Patrakov
