From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Tue, 6 Oct 2009 10:27:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910061025170.31529@eeebox2.perex-int.cz>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910060930120.31529@eeebox2.perex-int.cz>
	<4ACAF762.8020402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C9EEF1038D7
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 10:27:07 +0200 (CEST)
In-Reply-To: <4ACAF762.8020402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Clemens Ladisch wrote:

>>> almost the same thing, disabling an easy way to access it.
>>
>> amixer utility should handle such controls without problems.
>
> Yes, it should.  I haven't yet found where the hctl functions break it.

It does not work with amixer? The interface type should be specified, but 
all controls should be visible through hctl interface. Something like:

amixer cset iface=PCM,name="some name",index=1 33

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
