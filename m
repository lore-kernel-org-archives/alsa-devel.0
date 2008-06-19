From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Maximum buffer size on HDA
Date: Thu, 19 Jun 2008 19:42:38 +0200
Message-ID: <20080619174238.GA7022@tango.0pointer.de>
References: <20080613191303.GA3899@tango.0pointer.de>
	<s5hzlplpt58.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806161246330.1798@tm8103-a.perex-int.cz>
	<s5hprqhpok8.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806161415010.1798@tm8103-a.perex-int.cz>
	<20080616123740.GA15742@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DD9E2441A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 19:42:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080616123740.GA15742@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 16.06.08 14:37, Lennart Poettering (mznyfn@0pointer.de) wrote:

heya!

> > I'm not quite sure what you like to change. Make 1MB limit smaller? Or 
> > change the default preallocated size? Or remove preallocation? I think 
> > that it might make sense to increase the default preallocation value to 
> > 128KB or 192KB.
> 
> For PulseAudio it would be of big benefit if we could change the
> default in a way the for the highest sensible sampling rate/number of
> channels/sample type we'd always be able to get a two-second
> buffer. Windows and Mac use 2s of buffer by default, and I think it
> would make sense for PulseAudio to do that too. 
> 
> i.e. if the soundcard can do 2ch/16bit/44100hz at best I'd like to
> have a buffer size of up to 344KB; if the soundcard can to
> 5.1/32bit/48000 at best then i'd like to have a buffer of up to 2.2MB
> or so.

Takashi, Jarsolav, how can I bribe you into increasing this limit?

What are the implications of this change? (Just wondering if it would
make sense for us to change this limit in the Fedora kernel packages)

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
