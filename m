From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Tue, 27 Aug 2013 10:01:06 +0200
Message-ID: <521C5CC2.7030809@ivitera.com>
References: <Pine.LNX.4.44L0.1308261419100.886-100000@iolanthe.rowland.org>
 <521C5315.3030207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id E311B26087B
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 10:01:06 +0200 (CEST)
In-Reply-To: <521C5315.3030207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, USB list <linux-usb@vger.kernel.org>, Daniel Mack <zonque@gmail.com>, James Stone <jamesmstone@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: alsa-devel@alsa-project.org

On 27.8.2013 09:19, Clemens Ladisch wrote:
> 
> The driver cannot control how many samples actually end up in a capture
> packet,...
Does this reasoning apply to asynchronous playback too? I understand the
driver has some control, but has to satisfy the endpoint feedback requests.

Sorry if this is cluelessly offtopic :-)

Regards,

Pavel.
