From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 13:45:45 +0100
Message-ID: <54C636F9.7050009@ladisch.de>
References: <3427562.sVz54J9OhN@linux-le0l.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9C20826054F
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:45:46 +0100 (CET)
In-Reply-To: <3427562.sVz54J9OhN@linux-le0l.site>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "a.renault@kaptalia.com" <a.renault@kaptalia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

a.renault@kaptalia.com wrote:
> My sound crackling after 6.45 hours of music without reinitialization.
> https://bugzilla.libsdl.org/show_bug.cgi?id=2794
> And after some works we discover that the snd_pcm_writei answer "-1073741824".
>
> Any idea would be greatly appreciated.

This sounds like a bug in the hardware driver.


Regards,
Clemens
