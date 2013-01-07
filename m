From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Alsa snapshot directory layout changed
Date: Mon, 07 Jan 2013 16:00:27 +0100
Message-ID: <50EAE30B.4090808@perex.cz>
References: <50EAAA42.9020701@canonical.com> <s5htxqtnmm4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 79FEC26512A
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 16:00:29 +0100 (CET)
In-Reply-To: <s5htxqtnmm4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Date 7.1.2013 14:33, Takashi Iwai wrote:
> At Mon, 07 Jan 2013 11:58:10 +0100,
> David Henningsson wrote:
>>
>> I have a script that picks daily snapshots from 
>> ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>> ...and I just noticed that the directory layout has changed, so what was 
>> "alsa-driver" is now "alsa-driver/alsa".
>>
>> Is this expected, i e, should I update my script to follow this new 
>> layout, or was it a mistake?
> 
> It's no mistake, done intentionally so.
> But I'm going to change the script to create a tarball without alsa/
> subdirectory later.  But right now no time.

I would like to keep the structure same in GIT repo and tarball for the
patch processing.

> As a workaround, just put a line like below in your script.
> 
> 	test -d alsa && cd alsa

Perhaps a README in the root directory with this information may be
sufficient.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
