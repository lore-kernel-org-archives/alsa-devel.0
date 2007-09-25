From: James Pearson <james-p@moving-picture.com>
Subject: Re: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Tue, 25 Sep 2007 17:20:12 +0100
Message-ID: <46F9353C.1040105@moving-picture.com>
References: <46EA5F30.7000404@moving-picture.com>
	<s5hwsutkq6o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 1268024393
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Sep 2007 18:20:13 +0200 (CEST)
In-Reply-To: <s5hwsutkq6o.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 14 Sep 2007 11:15:12 +0100,
> James Pearson wrote:
> 
>>alsa-driver-1.0.15rc2 won't build cleanly on RHEL4/CentOS4 (2.6.9 based 
>>kernel).
>>
>>I've included the relevant errors below after running:
>>
>>configure --with-redhat
>>make -i
>>
>>The problem with misc/ac97_bus.c, I've already reported at:
>>
>><http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003119.html>
>>
>>James Pearson
> 
> 
> The fix is pending on my local tree.  Shall be fixed in rc3.

I've just discovered that I can't load snd-ioctl32 from 1.0.15rc2 on 
RHEL4/CentOS4 - dmesg reports:

snd_ioctl32: Unknown symbol snd_ctl_elem_read
snd_ioctl32: Unknown symbol snd_ctl_elem_write

snd-ioctl32 with 1.0.15rc1 loads fine ...

James Pearson
