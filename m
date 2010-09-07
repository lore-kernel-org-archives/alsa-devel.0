From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol
 _snd_pcm_plug_open is not defined inside [builtin]
Date: Tue, 07 Sep 2010 13:19:39 +0200
Message-ID: <4C861FCB.3080502@ladisch.de>
References: <AANLkTimybMC1f_eB04G0-WeOoCapKBeeKGR7wXO3GxWm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B63702433C
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 13:19:15 +0200 (CEST)
In-Reply-To: <AANLkTimybMC1f_eB04G0-WeOoCapKBeeKGR7wXO3GxWm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: asim khan <khan.asim.2009@gmail.com>
Cc: tiwai@suse.de, alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

asim khan wrote:
> *ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol _snd_pcm_plug_open is not
> defined inside [builtin]
> cannot open audio device plughw:0,0 (No such device or address).*

alsa-lib's configure script has the option --with-pcm-plugins=... to
specify which plugins should be included.  In your case, the plug
plugin was obviously not included in this list.

(Many embedded application do need the automatic sample rate/format
conversion and use the "hw" device.)


Regards,
Clemens
