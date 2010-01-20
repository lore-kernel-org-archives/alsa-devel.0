From: Jacopo De Simoi <jacopods@gmail.com>
Subject: Re: Conexant CX20561 on HP Pavilion dv2700
Date: Wed, 20 Jan 2010 15:16:39 +0100
Message-ID: <201001201516.39754.jacopods@gmail.com>
References: <201001201327.50727.jacopods@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 15D3624566
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 15:15:23 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so1141978eyw.16
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 06:15:22 -0800 (PST)
In-Reply-To: <201001201327.50727.jacopods@gmail.com>
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

> in any case I noticed that the noise background  is very much correlated between R and L; would it be possible to write an alsa-plugin to mix the two channels with an inversion to mix away the noise? It sounds fairly simple, but I couldn't find any documentation on how to make a plugin

 ok, for that I used the route plugin, I must say it's working remarkably well! no more noise from the internal mic.
Still, no noise also with a working mic would be great, so my offer to work on it is still standing.
Cheers
 __J
