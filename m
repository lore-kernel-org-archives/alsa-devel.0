From: "j t" <mark473@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset -
	FCC-ID:I38-MMSN846" ?
Date: Sun, 13 May 2007 12:00:55 +0100
Message-ID: <b88f52540705130400qb29de5dhd2a4fcc3c14970e1@mail.gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id BC48324636
	for <alsa-devel@alsa-project.org>;
	Sun, 13 May 2007 13:00:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so366854anc
	for <alsa-devel@alsa-project.org>; Sun, 13 May 2007 04:00:55 -0700 (PDT)
In-Reply-To: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/13/07, ramkromberg@mail.com <ramkromberg@mail.com> wrote:
> Is their something like "beep" only for the sound card ?
> Maybe droping some data to /dev/### to produce a beep ?

Perhaps
cat /dev/urandom | aplay -f cd
or
cat /dev/urandom | aplay -Dhw:0,0 -f cd

HTH...
