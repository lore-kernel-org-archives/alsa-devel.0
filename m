From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kmirror: ALSA kernel mirror
 repository branch, master now at v1.0.21-334-g6739046
Date: Mon, 16 Nov 2009 10:23:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911161020500.4806@eeebox2.perex-int.cz>
References: <20091112095403.1CAAE103807@alsa0.perex.cz>
	<s5hr5s4c9in.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911121154310.4806@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF68243CE
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 10:23:43 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.0911121154310.4806@eeebox2.perex-int.cz>
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

On Thu, 12 Nov 2009, Jaroslav Kysela wrote:

>> Also, both commits give many warnings via checkpatch.pl...
>> So I postpone the merge so far.
>
> I'll fix that, if we agree how to go...

I recoded both patches:

ALSA: hda - proc - add support for dynamic controls to mixer<->NID mapping

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=fb8b61ef469a509b83681795fd593a3c02703a1f

ALSA: hda - proc - introduce Control: lines to show mixer<->NID assignment

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=aedbf6527693078aff7c525506c9f06c1237b5f5

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
