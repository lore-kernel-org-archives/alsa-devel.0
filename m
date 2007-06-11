From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: Quirks device not showing up
Date: Mon, 11 Jun 2007 23:25:13 +0200
Message-ID: <466DBDB9.2080309@gmx.net>
References: <46506D9D.4000701@gmx.net>	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>	<s5hk5v2p4az.wl%tiwai@suse.de>	<46520655.7000402@gmx.net>
	<4668715B.1020208@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0616A10381C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 23:25:14 +0200 (CEST)
In-Reply-To: <4668715B.1020208@gmx.net>
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

LCID Fire wrote:
> Well I defined a quirks for my usb device. I mined the probe code with
> output and it creates a new driver instance for my device as well as it
> finds the channels. Nevertheless I don't get my device listed in
> userspace. Is there anything special to be done besides defining a quirks?
I have to correct myself a bit. The patch is actually working - and my
card and it's channels are detected just fine - problem is there seems
to be no mixer available for my channels.
When I try to access my card using alsamixer I get a message "No mixer
elems found". Is there a special .conf file necessary and what's the
format for it?
