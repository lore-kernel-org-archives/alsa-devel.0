From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: Merging hg sources into kernel tree
Date: Tue, 19 Feb 2008 18:57:02 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0802191854070.25872@shell4.speakeasy.net>
References: <6a316a6e0802191818j4a02dcc8s5a2d4a687c605749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8]) by alsa0.perex.cz (Postfix) with ESMTP id 73370243B5
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 03:57:04 +0100 (CET)
In-Reply-To: <6a316a6e0802191818j4a02dcc8s5a2d4a687c605749@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Boettcher <a.boettcher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2008, Andrew Boettcher wrote:
> Is there a script to merge the hg sources into a kernel tree?  If not do I
> need to worry about any changes other than the include/ directory?  I have
> another module (cx88-alsa) that is in v4l but needs the newer alsa tree or I
> get "cx88_alsa: disagrees about version of symbol xxx", so I have to merge
> the sources for now.

You can merge the v4l-dvb Hg sources into the kernel tree with "make
kernel-links"
