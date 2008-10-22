From: "Nir Tzachar" <nir.tzachar@gmail.com>
Subject: Re: Nvidia hdmi problems
Date: Wed, 22 Oct 2008 19:09:06 +0200
Message-ID: <9b2db90b0810221009p6fc8e34awa8332c973e520700@mail.gmail.com>
References: <9b2db90b0810200735g61cad43dr538c3afc495398ec@mail.gmail.com>
	<s5hr66a8kr7.wl%tiwai@suse.de>
	<9b2db90b0810210039y223adcd7nd94053274b6eae18@mail.gmail.com>
	<s5hod1e8jz8.wl%tiwai@suse.de>
	<9b2db90b0810210052o6b2720f4h37a67e3cc0eeae49@mail.gmail.com>
	<s5hiqrm8j2b.wl%tiwai@suse.de>
	<9b2db90b0810210428q2dd16d94va85a0cb5594ec15d@mail.gmail.com>
	<s5hskqq15px.wl%tiwai@suse.de>
	<9b2db90b0810210546i67d54038rcbfe0f356109c545@mail.gmail.com>
	<s5htzb5ywbi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 746C624671
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 19:09:25 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so1075662yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 10:09:06 -0700 (PDT)
In-Reply-To: <s5htzb5ywbi.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Wei Ni <wni@nvidia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 8:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 21 Oct 2008 14:46:19 +0200,
> Nir Tzachar wrote:
>>
>> >> The bad news are that mplayer misbehaves and will get stuck every time
>> >> I try to change the volume. However, this does not happen in vlc.  Any
>> >> ideas?
>> >
>> > Well, we need to sort out where the problem comes from.
>> > Try the vanilla Linus tree without sound-2.6 whether the problem
>> > persists.
>>
>> I'll try to remove the sound-2.6 tree and report.
>
> Nir, do you have any results?
> I tried to reproduce the problem by myself, but I couldn't.
> So I wonder whether it's a codec specific or I missed something...

No results yet, as I did not have time to test linus's tree. Ill be
able to do it over the weekend, and will come back with updates. For
now, the way I got it to work nicely was just taking the sound and
include/sound dirs, sticking them on a 2.6.27.1 tree, and adding the
device id as Wei instructed. Otherwise, there were segfaults all over
the place.


>
> thanks,
>
> Takashi
>
