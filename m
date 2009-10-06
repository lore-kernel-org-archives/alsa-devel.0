From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Tue, 6 Oct 2009 09:42:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910060930120.31529@eeebox2.perex-int.cz>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CE4D1038AE
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 09:42:40 +0200 (CEST)
In-Reply-To: <s5hab05role.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Takashi Iwai wrote:

> At Tue,  6 Oct 2009 08:36:04 +0200 (CEST),
> noreply-git@alsa-project.org wrote:
>> commit fc9e4a3811567f8d1d4c263a89e27b52c90d6098
>> Author:     Clemens Ladisch <clemens@ladisch.de>
>> AuthorDate: Tue Oct 6 08:21:04 2009 +0200
>> Commit:     Clemens Ladisch <clemens@ladisch.de>
>> CommitDate: Tue Oct 6 08:21:04 2009 +0200
>>
>>     sound: via82xx: move DXS volume controls to PCM interface
>>
>>     The "VIA DXS" controls are actually volume controls that apply to the
>>     four PCM substreams, so we better indicate this connection by moving the
>>     controls to the PCM interface.
>>
>>     Commit b452e08e73c0e3dbb0be82130217be4b7084299e in 2.6.30 broke the
>>     restoring of these volumes by "amixer restore" that most distributions

amixer restore == alsactl restore ?

>>     use; the renaming in this patch cures that regression by preventing
>>     amixer from applying the old, wrong volume levels to the new controls.
>>     http://bugzilla.kernel.org/show_bug.cgi?id=14151
>>     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=532613
>>
>>     Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>>     Cc: <stable@kernel.org>
>
> Well, this control was once removed, and then revived due to complains
> by users who have used it in mixer.  Moving this to PCM iface does
> almost the same thing, disabling an easy way to access it.

amixer utility should handle such controls without problems. We have 
similar volume controls in emu10k1 driver, but having 32 PCM volume 
controls in mixer is not much fun.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
