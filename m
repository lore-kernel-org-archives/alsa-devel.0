From: "Shilin Yu" <lunziyu@gmail.com>
Subject: Re: Where can I find ALSA driver for smdk2410-UDA1341?
Date: Tue, 6 May 2008 20:52:44 +0800
Message-ID: <9bbf02010805060552x1a73f0fdn616db272a2472d8c@mail.gmail.com>
References: <F360252464DB3C448CCADCBCE8276CCF17D196@inmail.hopen.com>
	<20080506123331.GC31939@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C4EA243BF
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 14:52:56 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1409761ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 06 May 2008 05:52:44 -0700 (PDT)
In-Reply-To: <20080506123331.GC31939@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: yushilin <lunziyu@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Mark:)
I do study the driver and found some patch for S3C24XX - UDA1341, but it
doesn't work probably, and I can't fix the bug:(
So anyone has a worked patch? and I think my problem is mainly about L3 code
:(

2008/5/6 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> On Tue, May 06, 2008 at 04:49:34PM +0800, yushilin wrote:
>
> > Any one knows?
>
> You probably want to look at the ASoC subsystem[1] - see sound/soc and
> Documentation/sound/alsa/soc.  There is support for s3c24xx CPUs in
> the mainline kernel distribution already, although no specific support
> for the UDA1341 codec or that specific board.
>
> [1] http://opensource.wolfsonmicro.com/node/6
> _______________________________________________
>  Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Sincerely yours,
Shilin Yu
