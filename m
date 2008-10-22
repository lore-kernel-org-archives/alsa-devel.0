From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Wed, 22 Oct 2008 18:24:16 +0200
Message-ID: <5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<loom.20081016T120322-319@post.gmane.org>
	<s5h8wso3ejg.wl%tiwai@suse.de>
	<48F739F4.5070303@nostalgicnetworxx.org> <48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>
	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>
	<s5h4p34mz0j.wl%tiwai@suse.de>
	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id C6EE6243E9
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 18:24:34 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2562612rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 09:24:16 -0700 (PDT)
In-Reply-To: <5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 18:07, Bjoern Olausson <lkmlist@gmail.com> wrote:
> No, mplayer (using the smplayr GUI) behaves like I reportetd, xine
> works like bevor.
>
> Just one thing changed:
> Running the same file with "mplayer file.avi" instead of "smplayer
> file.avi" now results in a crase.
> Without the patch I could at least run "mplayer file.avi" Now the
> system freezes or just restarts.
> No way to get mot info.
>
> I'll revert the patch and check again.
>

Mhh, I reverted the patch but mplayer still keeps freezing my system now...
smplayer still works (with the stuttering) xine works fine.

>>
>> thanks,
>>
>> Takashi
>>
>> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
>> index 0a1c569..ebe2dee 100644
>> --- a/sound/pci/sbxfi/sbxfi.c
>> +++ b/sound/pci/sbxfi/sbxfi.c
>> @@ -1260,7 +1260,7 @@ static struct snd_pcm_hardware sbxfi_pcm_hardware = {
>>        .channels_min = 2,
>>        .channels_max = 2,
>>        .buffer_bytes_max =     SBXFI_MAX_BUFFER,
>> -       .period_bytes_min =     64,
>> +       .period_bytes_min =     4096,
>>        .period_bytes_max =     SBXFI_MAX_BUFFER,
>>        .periods_min =          1,
>>        .periods_max =          4096,
>>
>
