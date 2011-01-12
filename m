From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 10:17:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101121013330.28150@eeebox2.perex-int.cz>
References: <igi861$q8o$1@dough.gmane.org>
	<AANLkTikGo8FMVf_9UMBa+iOhgXXdtWFdePk_7=6zwDhA@mail.gmail.com>
	<s5h62tuipeh.wl%tiwai@suse.de> <igjr5i$jjb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C72624481
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:17:22 +0100 (CET)
In-Reply-To: <igjr5i$jjb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Jan 2011, Colin Guthrie wrote:

> 'Twas brillig, and Takashi Iwai at 12/01/11 06:53 did gyre and gimble:
>> I read Colin meant front:CARD=x is incorrect while hw:CARD is a lowlevel
>> access that one doesn't always want.
>
> For capture. Yes that's what I was meaning.
>
>> I'm fine with creating a new name, but wondering which name is best.
>> Basically what you want here is the default use-case but without
>> dsnoop like the current "default".  (If dsnoop were acceptable,
>> "default" should have been used in most places.)
>> "capture" may be also too ambiguous for defining that, I'm afraid.
>
> Yeah, "default" wont work here due to it being redirected to PulseAudio
> (as opposed to dsnoop) in this use case, so we need to avoid that name :s
>
> IMO "capture" is quite clear (or at least as clear as "front" is for
> playback!), but here are a few other suggestions:
>
> "record"
> "input"
> "read"
>
>
> Personally, "input" and "capture" are my two favourites.

The question is, if we should identify more the source of the captured 
data. The default device does the basic job.

analogin
iec958in

Eventually:

linein
micin
iec958in

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
