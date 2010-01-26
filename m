From: Yiliang Bao <yiliangb@gmail.com>
Subject: How to unload a sound module.
Date: Tue, 26 Jan 2010 11:37:07 -0800
Message-ID: <e5baf3861001261137x2b186559ma8dd1756b9a23455@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CA681037F5
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 20:37:10 +0100 (CET)
Received: by pzk1 with SMTP id 1so3539745pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 11:37:09 -0800 (PST)
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

Hi,

I am new to alsa driver development. The first problem I encountered is I
could not unload a module just inserted. I always get the following message
(using snd-dummy as an example).

> sudo rmmod snd-dummy
ERROR: Module snd_dummy is in use

I checked who is using snd-dummy. Here is what I got and I do not know what
applications are using it.

Module                  Size  Used by
snd_dummy               9600  2

Is there any easy way to unload the sound module?

Thanks,
Yiliang
