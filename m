From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] pulse: Install a PulseAudio config snippet
 into alsa.conf.d
Date: Fri, 16 Sep 2011 10:12:33 +0100
Message-ID: <4E731301.6000408@colin.guthr.ie>
References: <1315949483-15152-1-git-send-email-gmane@colin.guthr.ie>
	<s5haaa5t2j2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id B8706103D12
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:12:35 +0200 (CEST)
In-Reply-To: <s5haaa5t2j2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 16/09/11 07:38 did gyre and gimble:
> At Tue, 13 Sep 2011 22:31:23 +0100,
> gmane@colin.guthr.ie wrote:
>>
>> From: Colin Guthrie <colin@mageia.org>
> 
> Better with a sign-off please (although it's not mandatory for
> user-space trees).

No problem.

> Also, isn't it better to name *.conf files with number prefix like
> udev, et al?  Otherwise the loading order isn't deterministic.

Yeah probably. I picked 50 for the "pulse" PCM and 99 for the default
example. Both kinda arbitrary numbers, so feel free to change them when
you apply if you prefer (filenames and Makefile.am).

New patch sending soon.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
