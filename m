From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop issues
Date: Fri, 27 Apr 2007 14:37:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0704271432010.8211@tm8103.perex-int.cz>
References: <4631EC14.2060802@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2073D24348
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 14:37:51 +0200 (CEST)
In-Reply-To: <4631EC14.2060802@btinternet.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gordon Miller <gordonamiller@btinternet.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Apr 2007, Gordon Miller wrote:

> Hi
> 
> All my snd_pcm_readi calls return too few frames. Also when I switch to 
> stereo, the sound is muted. I cannot change this by adjusting period & 
> buffer sizes. dsnoop is enabled by default. The documentation for 
> snd_pcm_readi says that the only way that the frame count can be short 
> is because of a signal or xrun. Well this clearly isn't the case.
> 
> I think that direct snoop is the cause of this. Are there any remedies ? 
> because I am roundly SICK of being told that my application must be 
> wrong "because everyone else's works". I have spent the last 3 weeks 
> debugging an app - that always worked properly - because of the faulty 
> dsnoop implementation.
> 
> It is abundantly clear that dsnoop is far from ready for use, but I am 
> prepared to put some work into this.
> Whose idea was it to enable dsnoop by default, when it doesn't even work 
> ? I was quite happy with OSS. Changing everything to be alsa entailed a 
> lot of work, and I am beginning to think it was a complete waste of my time.
>
> ICE1712, 2.6.20.6 kernel, alsa 1.0.14rc1

Send us a clear example which configuration does not work as you expect. 
We need:

a) simple test tool
b) reproduce error with arecord
c) debug output from snd_pcm_dump() before / while you read samples

It might be that it's no dsnoop fault, but some other plugin on way 
screw samples / stream position.

Your e-mail gives us nothing than "Houston, we have a problem". So it's 
almost useless.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
