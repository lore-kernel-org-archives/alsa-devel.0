From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is the meaning of the mask values in the
	pcm	hw constraints struct ?
Date: Tue, 20 Oct 2009 17:50:38 +0100
Message-ID: <20091020165037.GA15813@sirena.org.uk>
References: <0D107966AF6D79418315B7C5549F4B5101150A39@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DF69B2476F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 18:50:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0D107966AF6D79418315B7C5549F4B5101150A39@lemail1.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neil.jones@imgtec.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2009 at 04:54:32PM +0100, Neil Jones wrote:

> I get the error "aplay: set_params:1022: Unable to install hw params:"
> I have traced the problem to a failing ioctl call
> (snd_pcm_playback_ioctl) the error occurs in snd_pcm_hw_refine when
> refining the mask for the SNDRV_PCM_HW_PARAM_ACCESS mask, all the bit
> fields in my runtime->hw_constraints are zero for this field, but the

You should set these up with snd_soc_set_runtime_hwparams() with the
flags in the info field.

> requested params have the value 7, Im not sure what this means, the
> SNDRV_PCM_ACCESS_xxx defines in asound.h only go upto 4 ?

It's a bitmask at this point, treat those values as shifts.
