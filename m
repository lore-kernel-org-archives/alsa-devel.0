From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Support for floating point controls?
Date: Mon, 1 Feb 2010 17:43:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002011740040.25340@eeebox2.perex-int.cz>
References: <4B60C841.9010306@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B80D22438F
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 17:43:22 +0100 (CET)
In-Reply-To: <4B60C841.9010306@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jan 2010, Eliot Blennerhassett wrote:

> Greetings,
>
> some of our products now have control paramters that are 32 bit floating
> point values.
>
> I wonder if a patch implementing float ctl elements would be accepted?
>
> Note that the floats are not manipulated in the kernel at all, the
> values are just passed through from the hardware to userspace (?)

If hardware supports this format, I have no objections against this 
extension.

> Adding something like:
>
> #define	SNDRV_CTL_ELEM_TYPE_FLOAT	((__force snd_ctl_elem_type_t) 7)
>
> struct snd_ctl_elem_info {
> ...
>  union {
> 	struct {
> 		float min;		/* R: minimum value */
> 		float max;		/* R: maximum value */
> 		float step;		/* R: step (0 variable) */
> 	} float;
> ...
> }
>
> struct snd_ctl_elem_value {
>  union {
> 	union {
> 		float value[128];
> 	} float;

Looks good. Also, don't forget to add the support for this type to 
alsa-lib.


 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
