From: Lieven Moors <lievenmoors@hotmail.com>
Subject: distinguish events based on input ports
Date: Sun, 19 Jul 2009 23:50:43 +0200
Message-ID: <COL110-W58CC5A84D4C828759020B5BE1C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s15.col0.hotmail.com (col0-omc3-s15.col0.hotmail.com
	[65.55.34.153]) by alsa0.perex.cz (Postfix) with ESMTP id 8D3A9244B6
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jul 2009 23:50:52 +0200 (CEST)
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


Hi everybody,

I've just started writing my first little program with alsa,
and I had a question regarding the use of input(read) ports.
What I want to do is distinguish events based on the input port
they came through. Since the destination of the event is mostly
set to 'broadcast', I cannot extract this information from the event
itself. I would like to know if there is another way to do this, or if
it is simply impossible.

Thanks for your help,

Greetings,

Lieven
