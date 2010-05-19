From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove CPVSS supply
Date: Wed, 19 May 2010 09:53:45 +0300
Message-ID: <20100519095345.a0fdcd52.jhnikula@gmail.com>
References: <1274211085-20261-1-git-send-email-jhnikula@gmail.com>
	<F80267346F10C541946CBE8909F1C39E26E7BF8C34@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com
	[209.85.219.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 0315A2452F
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:53:46 +0200 (CEST)
Received: by ewy9 with SMTP id 9so2092143ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 18 May 2010 23:53:46 -0700 (PDT)
In-Reply-To: <F80267346F10C541946CBE8909F1C39E26E7BF8C34@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ilkka.koskinen@nokia.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 19 May 2010 08:51:13 +0200
<ilkka.koskinen@nokia.com> wrote:

> 
> Hi,
> 
> On Tue, 18 May 2010, Jarkko Nikila wrote:
> >I believe there is no need for the CPVSS supply as this pin is for
> >decoupling capacitor for the internal charge pump.
> 
> Yes, you're right. I have a vague feeling that I put it there due to
> some previous comments...
> 
> Anyway, I believe tpa6140's HPVdd is similar case and, thus, not
> needed either. Would you like to make a patch for that or shall I do
> it?
> 
I can do it and repost as it makes the patch even more simpler :-)


-- 
Jarkko
