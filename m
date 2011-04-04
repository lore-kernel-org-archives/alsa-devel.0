From: "Sebastian H." <vand2@gmx.de>
Subject: Re: "default" device. Is there a way to detect if it's
 a plugin, and if so which one?
Date: Mon, 04 Apr 2011 13:38:15 +0200
Message-ID: <4D99ADA7.7040403@gmx.de>
References: <in9oqa$46g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id ECFA824388
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 13:38:19 +0200 (CEST)
In-Reply-To: <in9oqa$46g$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 03.04.2011 14:22, schrieb Colin Guthrie:
> Hi,
> 
> If the user opens the "default" device in alsa, is there a way to find
> out if that "device" is actually a plugin?
> 
> i.e. is it possible to tell if you have opened the pulseaudio plugin via
> alsa?
> 
> There are various hacky ways (e.g. checking hints etc.) but that relies
> on downstream packaging which certainly isn't fool proof.

Hi

Maybe one could parse the config files with snd_config_xxx and friends
and look what the type pcm.default is.

I've stumpled upon something similar when qasmixer tries to open
ctl.default which in some cases doesn't exist.

Sebastian H.
