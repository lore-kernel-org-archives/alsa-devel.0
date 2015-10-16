From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: USB-audio: Add support for
	Novation	Nocturn MIDIcontrol surface
Date: Fri, 16 Oct 2015 18:25:58 +0200
Message-ID: <56212516.2050003@ladisch.de>
References: <alpine.DEB.2.02.1510161332480.4075@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 87192266715
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:26:01 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510161332480.4075@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ricard at home <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> I've noticed that checkpatch complains about the space between the & and (,
> but in the interest of consistency I've not changed this. Is there some
> reason for the space

Yes.   But it's not a particularly substantial reason, and you're not
the first person to mention this checkpatch complaint, so feel free to
kill them.

> would it be worth while cleaning up the file?

Yes, it would be worth while cleaning up the file by restoring the
proper VID/PID order of the entries.  :)


Regards,
Clemens
