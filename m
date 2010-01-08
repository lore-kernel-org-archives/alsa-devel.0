From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: alsa support for HDA ALC889A nVidia Corporation
 MCP55	High Definition Audio EVGA 122-CK-NF68
Date: Fri, 08 Jan 2010 07:46:44 -0800
Message-ID: <4B475364.60904@gmail.com>
References: <e15870681001071639v5507b254vee2d9892364dd6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 9664A103802
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 16:46:15 +0100 (CET)
Received: by yxe5 with SMTP id 5so14376962yxe.24
	for <alsa-devel@alsa-project.org>; Fri, 08 Jan 2010 07:46:14 -0800 (PST)
In-Reply-To: <e15870681001071639v5507b254vee2d9892364dd6bf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Stieber <oliverthered@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/07/10 16:39, Oliver Stieber wrote:
> Hi,
>
> I'm having some issues, (and think I've discovered some bugs/ performance
> features) in alsa with my card.
>
> Certainly sound used to work on front stereo speakers with mode=auto in
> ubuntu 9, but had to change to
> model=mb5 and have severe stability issues (alsa no longer works, kernel
> gets trashed) when I do things like try to change volume, and kde volume
> changer doesn't work unless I use the mixer etc...
>
> Also, this is the only model where I get sound, other models trash kernel
> space etc...
>
> With this model I can't unload the module as it says it's still in use even
> with the sound app has terminated (didn't have this problem under ubuntu 9)
>
> Have some dmesg dumps in a bug I filed (will dig it out).
>
> Anyhow, I'm more than happy to have a crack at getting my sound card working
> perfectly.
>
> Oliver.
>
> For starters....
>

using model=mb3 gives no effect?

Justin P. Mattock
