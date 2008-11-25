From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: pcm_prepare, and pcm_trigger
Date: Tue, 25 Nov 2008 14:48:18 +0000
Message-ID: <20081125144817.GC12414@sirena.org.uk>
References: <520f0cf10811250559r4f57297fi663a3cbd7608a08a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 850412445E
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 15:48:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520f0cf10811250559r4f57297fi663a3cbd7608a08a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 25, 2008 at 02:59:46PM +0100, John Kacur wrote:

> cat 8k8bitpcm.wav > /dev/dsp

>         myplatform_pcm_prepare,
>        myplatform_pcm_trigger

> Is this normal? Who calls these functions?

I'd expect to see those called.  They're called by the core in response
to ALSA API operations - since you're using /dev/dsp the actual ALSA API
client will be the OSS emulation you're using (normally the in-kernel
one).  For the purposes of development it's generally easier if you work
with the ALSA APIs and use utilities like aplay to test.  This avoids
the layer of indirection added by OSS emulation, making bringup a bit
clearer.
