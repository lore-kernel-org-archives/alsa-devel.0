From: "John Kacur" <jkacur@gmail.com>
Subject: Re: pcm_prepare, and pcm_trigger
Date: Tue, 25 Nov 2008 15:50:21 +0100
Message-ID: <520f0cf10811250650r50044050j722503efcde11eb8@mail.gmail.com>
References: <520f0cf10811250559r4f57297fi663a3cbd7608a08a@mail.gmail.com>
	<20081125144817.GC12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 71B0C24466
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 15:50:22 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2503588rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 06:50:21 -0800 (PST)
In-Reply-To: <20081125144817.GC12414@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 25, 2008 at 3:48 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Nov 25, 2008 at 02:59:46PM +0100, John Kacur wrote:
>
>> cat 8k8bitpcm.wav > /dev/dsp
>
>>         myplatform_pcm_prepare,
>>        myplatform_pcm_trigger
>
>> Is this normal? Who calls these functions?
>
> I'd expect to see those called.  They're called by the core in response
> to ALSA API operations - since you're using /dev/dsp the actual ALSA API
> client will be the OSS emulation you're using (normally the in-kernel
> one).  For the purposes of development it's generally easier if you work
> with the ALSA APIs and use utilities like aplay to test.  This avoids
> the layer of indirection added by OSS emulation, making bringup a bit
> clearer.
>

Thanks again for the info.

On the embedded board I'm working on, compiling the alsa utilities
isn't an option, we have the OSS emulation as a requirement.
