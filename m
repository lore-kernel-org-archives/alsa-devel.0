From: Mark Knecht <markknecht@comcast.net>
Subject: Re: M-Audio firewire device
Date: Tue, 02 Sep 2003 05:42:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062506521.27592.5.camel@Wizard.knechthome.com>
References: <20030902085428.GA29782@ecs.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030902085428.GA29782@ecs.soton.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-09-02 at 01:54, Steve Harris wrote:
> http://www.m-audio.com/products/m-audio/fw410.php
> 
> Maybe the first supported firewire audio device for alsa? If M-Audio give
> up the details. Could be a better option for laptop use than USB.
> 
> - Steve

I'm going to guess that the issue is that this is probably an MLAN
device. The MLAN spec comes under NDA from Yamaha. I have a copy at
work. The problem is how do we get a driver to support it?

I talked to my lawyer a while back about this. His opinion was that it
is probably possible to develop an open source driver under NDA. My
company, however, is not in this business and really doesn't have any
reason to undertake doing that.

Assuming this train of thought is correct, I don't really know how to
proceed? Some driver developer could get under NDA with Yamaha directly,
or work with a company like M-Audio under NDA on the MLAN part of it,
and then possibly release a driver.

If the device was purely a 61883 device it might be a bit easier. There
are some 'early' Linux 61883 drivers out there.

Complicated...

- Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
