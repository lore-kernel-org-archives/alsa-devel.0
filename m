From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: snd_pcm_hw_params_get_*() without snd_pcm_open(
Date: Mon, 28 Apr 2003 12:37:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030428123721.pochini@shiny.it>
References: <Pine.LNX.4.44.0304281009570.1603-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304281009570.1603-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 28-Apr-2003 Jaroslav Kysela wrote:
> On 27 Apr 2003, Giuliano Pochini wrote:
>
>> I need to read the properties of a pcm device, but snd_pcm_open() blocks
>> or exits with an error if something is using that device. Is there any
>> workaround ?
>
> No, the characteristic of a PCM device is dynamic (might be changed during
> runtime)

Ah, this is a good news :) My card has digital i/o, but the number of
channels changes when the user switches between S/PDIF and ADAT. Now I
can fix it properly.

> thus it's not useful to obtain this information in another way.
> Also, I think that most of applications want to be clever than user,
> simply use device passed by user and try work with it.

I'm writing a mixer. I need some infos I cannot get from the ctl
interface (eg. # of channels). I can register an "info" ctl to pass
the data I need to userspace, but I don't like that hack. And I don't
like to store a list of capabilities of each card inside the mixer.
Any hints ?


Bye.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
