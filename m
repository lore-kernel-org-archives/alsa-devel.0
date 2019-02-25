From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ftp.alsa-project.org connection problems
Date: Mon, 25 Feb 2019 20:52:33 +0100
Message-ID: <f358a020-3166-ec1d-dd88-f08d8c5e6996@perex.cz>
References: <20190225180431.GY6706@michaelspb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6519F89650
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 20:52:36 +0100 (CET)
In-Reply-To: <20190225180431.GY6706@michaelspb>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Michael Niedermayer <michael@niedermayer.cc>
List-Id: alsa-devel@alsa-project.org

Dne 25. 02. 19 v 19:04 Michael Niedermayer napsal(a):
> Hi
> 
> Iam not sure this is the correct place to report this to but i didnt see it
> being reported anywhere yet on the ML archive or google

...

> ==> PASV ... couldn't connect to 207.180.221.201 port 35333: No route to host
Hi,

  it seems that the ftp conntrack module was not loaded correctly after
reboot, so the firewall blocks the passive connections. Could you give a
try again?

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
