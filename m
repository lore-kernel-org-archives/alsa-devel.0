From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Sat, 23 Jun 2007 01:33:57 +0530
Message-ID: <61445c750706221303q1fbd1d19u55480e109997841b@mail.gmail.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
	<1182251430.29389.1195911445@webmail.messagingengine.com>
	<61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
	<1182263378.1273.1195944481@webmail.messagingengine.com>
	<61445c750706200318h6758cf78o64dfd3e6a88ea8bb@mail.gmail.com>
	<61445c750706200412i52e6666fjc7a5552972b18f7b@mail.gmail.com>
	<61445c750706200416y4654fcfcq8a064c645956f5e@mail.gmail.com>
	<1182355995.14744.1196173731@webmail.messagingengine.com>
	<61445c750706200929t79393137uf8f1ff29d9c16e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id EA2CF2434D
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 22:03:58 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so898079wag
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 13:03:57 -0700 (PDT)
In-Reply-To: <61445c750706200929t79393137uf8f1ff29d9c16e82@mail.gmail.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Problem solved guys...many misc things were wrong..after fixing them
it worked. Thank you all.

On 6/20/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Value of pcm pointer doesn't change. Other fields which are populated
> by me do not change except private_data.
>
> The following shows it:
>
> # cat a.sh > dev/audio
> pcm name is omap  alsa pcm //Intact
> pcm id is OMAP PCM               //Intact
> pcm private is 00000000       //Only this changes
>
> On 6/20/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > Pharaoh . wrote:
> > > Registering the sound card
> > > pcm->private in snd_device_register_all is c1d7d310 //correct
> > > Inside snd_pcm_dev_register, pcm is c1f05d44(correct), pcm->pvt_data
> > > is 00000000(This shouldn't be NULL)
> >
> > Does the value of pcm itself change?
> > Do other fields in pcm change?
> >
> >
> > Regards,
> > Clemens
> >
>
