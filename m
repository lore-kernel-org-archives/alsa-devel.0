From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: alsa git: which version of ac97_codec.c am i
 supposed to hxr?
Date: Mon, 18 Aug 2008 11:26:10 -0700
Message-ID: <op.uf3hhwja647oa9@jutz-gnto64>
References: <op.ufyawjke647oa9@jutz-gnto64>
	<Pine.LNX.4.61.0808161727550.21669@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D9452446A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 20:27:23 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0808161727550.21669@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thankyou Jaroslav!

On Sat, 16 Aug 2008 08:30:23 -0700, Jaroslav Kysela <perex@perex.cz> wrote:

> On Fri, 15 Aug 2008, John L. Utz III wrote:
>
>> Hello All;
>>
>> I feel confused by the presence of 2 different copies of ac97_codec.c:
>>
>>    jutz-gnto ~ # find . -name ac97_codec.c
>>      ./alsa-driver/pci/ac97/ac97_codec.c
>>      ./alsa-kmirror/pci/ac97/ac97_codec.c
>>
>> worse yet,they are not in sync:
>>
>> Which of these am i supposed to use? am i supposed to change both of  
>> them
>> for some backward compatibility purpose?
>
> Modify the alsa-kmirror code. When you run make in alsa-driver tree, the
> file from alsa-kmirror is patched to retain compatibility for older linux
> kernels. The ac97_codec.c file in alsa-driver tree is just a temporary
> file (not in our repository) used for building. See to .gitignore which
> files are temporary only.
>
> 					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>
