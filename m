From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Wed, 4 Aug 2010 16:20:52 +0800
Message-ID: <AANLkTi=-6DeeoqdOks38Khh0ux3K=aH7OQSwT4UhYdF7@mail.gmail.com>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<201007282012.39291.termtech@rogers.com>
	<201007282110.33065.termtech@rogers.com>
	<201007311506.56614.termtech@rogers.com>
	<AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9@mail.gmail.com>
	<20100801225410.GF4060@zita2>
	<AANLkTi=e_uy_44wmn=zK5Nd=W28wu0M3NocLR7nO+=B0@mail.gmail.com>
	<AANLkTikyxQGAVUj8aY7pMRKfxf1c6cUgn8b4aw2kmWY-@mail.gmail.com>
	<AANLkTi=srCoxcNf9gfbA_Mo8yFbdJe4AMPSHack4XqfY@mail.gmail.com>
	<AANLkTinoDYS_X32A0LcDN-2JBa84vyncvzPOZ5OXFP29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 46AD1103826
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 10:20:53 +0200 (CEST)
Received: by vws20 with SMTP id 20so4329472vws.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 01:20:52 -0700 (PDT)
In-Reply-To: <AANLkTinoDYS_X32A0LcDN-2JBa84vyncvzPOZ5OXFP29@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/4 Niels Mayer <nielsmayer@gmail.com>

> On Tue, Aug 3, 2010 at 10:38 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> > 2010/8/4 Niels Mayer <nielsmayer@gmail.com>
> >>   * fixed --card and --device to allow valid ALSA names and numbers
> >>        ( https://bugzilla.redhat.com/show_bug.cgi?id=602900 ).
> >
> > ./envy24control -Ddefault
> >
> > card_number = atoi(strchr(name, ':') + sizeof(char));
> >
> > This bug seem still occur when name does not contain ":" since ctl device
> is
> > "hw:n" where n is card number
>
> I used similar code to what's in alsamixer to perform the same
> functions as the old broken code. Now the code behaves as follows:
>
> gnulem-238-~> envy24control -Dhw:default
> envy24control: invalid ALSA audio device, invalid index or name for
> card: hw:default
> gnulem-239-~> envy24control -Dhw:M66
> using    --- input_channels: 4
>         --- output_channels: 4
>         --- pcm_output_channels: 8
>         --- spdif in/out channels: 2
> gnulem-240-~> envy24control -Dhw:M66.0
> envy24control: invalid ALSA audio device, invalid index or name for
> card: hw:M66.0
> gnulem-241-~> envy24control -Dhw:M66,0
> envy24control: invalid ALSA audio device, invalid index or name for
> card: hw:M66,0
> gnulem-242-~> envy24control -DM66
> envy24control: ALSA audio device syntax expects ':' character: M66
>
>
The "-D" option seem to be used similar to  "amixer -Dabc"

ctl.abc {

   type hw
   card 2
}
