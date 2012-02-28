From: "Hilman, Kevin" <khilman@ti.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Tue, 28 Feb 2012 09:55:18 -0800
Message-ID: <CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
References: <87ehtlwen3.fsf@ti.com>
	<4F472D4F.3000904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 37B79246C6
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 18:55:19 +0100 (CET)
Received: by mail-iy0-f182.google.com with SMTP id k25so736209iah.13
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:55:18 -0800 (PST)
In-Reply-To: <4F472D4F.3000904@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 23, 2012 at 10:25 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 02/23/2012 08:09 PM, Kevin Hilman wrote:
>>
>> Hello,
>>
>> I'm trying to get a wired headset with a mic working on MacBookAir
>> running v3.0 (3.0.0-13-generic from Ubuntu to be precise.)
>>
>> It has Intel HDA audio[1] and everything works fine, including the
>> built-in mic. =A0The only think I can't seem to get working is a headset
>> w/mic.
>>
>> I know the HW for dynamic detect works because the mic is detected
>> dynamically under OSX. =A0Is there some setting I need to tweak in order
>> to enable the automatic mic detection?
>>
>> Thanks for any pointers,
>
>
> Hi Kevin,
>
> You can try upgrading your alsa version to the daily snapshot using this
> method: https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS

Hi David,

Thanks for the suggestion.

I tried the latest version but the headset mic still doesn't work.
Are there any particular settings I should be configuring to make this
work?

Note that the jack detect is working for the output.  When I plug in
the headset, it switches the playback from the speakers to the headset
automatically, and I see the 'Connector' drop down in the output tab
of the Sound settings switch between "Analog headpohones' and 'Analog
speakers."

It seems there's still a problem detecting that the headset also has a mic.

Kevin
