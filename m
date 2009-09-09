From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Alsa plugin unable to be loaded by Pulseaudio
Date: Wed, 9 Sep 2009 15:59:39 +0200
Message-ID: <20090909135939.GA14530@tango.0pointer.de>
References: <1252365377.11542.5.camel@localhost.localdomain>
	<4f3252890909090110n68cbecefnab64f953d4788850@mail.gmail.com>
	<1252502217.20038.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 586E210387A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 16:00:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252502217.20038.3.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ng Oon-Ee <ngoonee@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 09.09.09 21:16, Ng Oon-Ee (ngoonee@gmail.com) wrote:

> The "test" device is defined as follows (should have put it in
> initially).
> 
> pcm.test {
>  type plug
>  slave { pcm "hw:0,0" }
> }
> 
> It works with aplay. My issue is that the pulseaudio server cannot load
> alsa plugins since 1.0.20 (as far as I can tell, ubuntuforums has a
> thread which suggested as such). When I queried the pulse ML, Lennart
> posted the below reply, which I've forwarded here to alsa-devel.
> 
> Basically, the issue as Lennart sees it is summarized by his last 3
> paragraphs (bottom of this mail). He specifies the difference between
> the way alsa is reacting to pulse and the way it 'should'.

After the discussion we had on alsa-devel about the ordering how buffer
size and period size are initialized i have now changed PA git to try
harder to initialize those values. Would be good if you could check if
that actually makes your problem go away.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
