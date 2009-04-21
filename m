From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Asterisk 1.4.17 and alsa 1.0.19 dmix plugin
 problem.
Date: Tue, 21 Apr 2009 14:38:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904211437260.4553@eeebox2.perex-int.cz>
References: <359c5480904201122m7a45dbe8hd1f6b597dea57283@mail.gmail.com>
	<alpine.LNX.2.00.0904202039160.4553@eeebox2.perex-int.cz>
	<359c5480904210335o25d636a4i14b7fe5f7391c839@mail.gmail.com>
	<alpine.LNX.2.00.0904211238470.4553@eeebox2.perex-int.cz>
	<359c5480904210509w8ae7b11w2695bf60888851e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CFF2610381F
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 14:38:07 +0200 (CEST)
In-Reply-To: <359c5480904210509w8ae7b11w2695bf60888851e6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicola Mfb <nicola.mfb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Apr 2009, Nicola Mfb wrote:

> 2009/4/21 Jaroslav Kysela <perex@perex.cz>:
>> On Tue, 21 Apr 2009, Nicola Mfb wrote:
>>
>>> 2009/4/20 Jaroslav Kysela <perex@perex.cz>:
>>>>
>>>> On Mon, 20 Apr 2009, Nicola Mfb wrote:
> [...]
>>> First level documentation on www.alsa-project.org says that you may
>>> use select or poll as you need, should be this corrected?
>>
>> Could you point me where is documentation unclear exactly?
>
> For example at:
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
> in "event waiting routines" you see "snd_pcm_poll_descriptors can be
> used to get a file descriptor to poll or select on".
>
> And at: http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gfc99365835bb429cac8c994fa56a42d7
> the sentence "You can use output from this function as arguments for
> the select() syscall, too." may be confusing. At first look reader may
> suppose that bogus results affects only poll.

I added more notes about events mangling there. Thanks.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
