From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 13:42:13 +0200
Message-ID: <20090403114213.GA15646@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B931810380A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:42:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
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

On Fri, 03.04.09 09:12, Jaroslav Kysela (perex@perex.cz) wrote:

> - dynamic device creation at runtime - for example we have an
>    experimental HDA driver configuration code which might change
>    the arrangement of PCM devices on request from the user space

Hmm, this could be handled by issueing a 'change' event on the control
device after all those changes have been applied.

> I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> devices to get the usual static arrangement working and handle extra
> dynamic cases, too.

We used to do this. But it's ugly. If the system is loaded .5s might
not be enough. We managed to get rid of all those waits for hotplugged
USB sticks and everyone is enjoying it. I think it is equally
advisable to do the same for audio devices.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
