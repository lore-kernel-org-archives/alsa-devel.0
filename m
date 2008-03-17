From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: /usr/share/alsa/alsa.conf :and file extention
Date: Mon, 17 Mar 2008 13:31:08 +0100
Message-ID: <47DE648C.4070401@keyaccess.nl>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>	
	<47DDE2F7.7000904@keyaccess.nl>
	<cab05a880803162035o1c4d077erf289dcae4371969f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A69E924484
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 13:30:15 +0100 (CET)
In-Reply-To: <cab05a880803162035o1c4d077erf289dcae4371969f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-03-08 04:35, Alexander Indenbaum wrote:

> On Mon, Mar 17, 2008 at 5:18 AM, Rene Herman <rene.herman@keyaccess.nl 

>     Don't do it there. Use /etc/asound.conf or $HOME/.asoundrc ...
> 
> 
> Generally I'd agree with you that $HOME/.asoundrc is way to go if it was 
> my desktop workstation. But this is an embedded system, so I'd like to 
> force it on system level.

As I said, use /etc/asound.conf

> Still it does not  work ( I still use system alsa.conf though ).

That's the reason.

> You touching here an interesting point. How  indeed I could get an PCM 
> header?

You don't really need one if you know the format. Ie, with aplay (and 
foo.wav being CD format):

aplay foo.wav
aplay -D hw:0 -f cd /tmp/pcm.out

Rene.
