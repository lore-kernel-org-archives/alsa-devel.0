From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: SoC codec read callback definition
Date: Thu, 23 Jul 2009 02:50:53 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E59BA9D93@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id CFB7910399D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 09:51:00 +0200 (CEST)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6N7osls014835
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 02:50:59 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n6N7osYo018895
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 02:50:54 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n6N7os7J029317
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 02:50:54 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

read callback (of snd_soc_codec struct) is defined as a function
that returns unsigned int:

struct snd_soc_codec {
	...
	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
      ...
}  

However, actual implementation of that callback in many CODEC drivers
may return a negative error value (i.e. when a register is out of cache
reg size). Should the callback definition be changed to return _int_
instead of _unsigned int_? Some drivers (like wm8900, wm9081) handle
invalid registers with BUG_ON, in that case it's not necessary to
return the negative error code.

What should be the best way to handle this? Or is it ok as currently
implemented? Well, it was just a thought.

-Misa
