From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Sat, 31 Dec 2011 15:23:33 +0100
Message-ID: <CAFz=ag41GGEB6X6AzZi9xshpQLUUuzqkd3qtjiFNEYAs=6N+qQ@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 88ADF2436F
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 15:23:33 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so7946741wib.38
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 06:23:33 -0800 (PST)
In-Reply-To: <4EFDC32B.10808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

> On 12/23/2011 05:15 PM, Daniel Mack wrote:
> Any chance that more people who've been waiting for support of the FTU
> can use the lazy time between the years and quickly test this set?


OK, it doesn't work for me. Each time I try to start a stream I get
error messages like this:

cannot submit urb 0, error -28: not enough bandwidth


This doesn't need to be related to your patch. I might even have
messed something up in the rc3 kernels config. How can I tell?
