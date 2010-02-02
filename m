From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: Support for floating point controls?
Date: Tue, 02 Feb 2010 11:08:10 +0100
Message-ID: <4B67F98A.1000208@emlix.com>
References: <4B60C841.9010306@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 869CE243C1
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 11:08:11 +0100 (CET)
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

On 01/28/2010 12:12 AM, Eliot Blennerhassett wrote:
> I wonder if a patch implementing float ctl elements would be accepted?
> Note that the floats are not manipulated in the kernel at all, the
> values are just passed through from the hardware to userspace (?)
> =

> Adding something like:
> =

> #define	SNDRV_CTL_ELEM_TYPE_FLOAT	((__force snd_ctl_elem_type_t) 7)
> =

> struct snd_ctl_elem_info {
> ...
>   union {
> 	struct {
> 		float min;		/* R: minimum value */
> 		float max;		/* R: maximum value */
> 		float step;		/* R: step (0 variable) */
> 	} float;
> ...
> }
> =

> struct snd_ctl_elem_value {
>   union {
> 	union {
> 		float value[128];
> 	} float;

I see several issues here.
There might be some day an architecture where float is not the
IEEE 754 single precision type. Or there might be a compiler that
insists on using floating point instructions to read those values
from memory. Therefore I prefer __s32 here instead of float.

Drivers would have to check if a passed control value is in the
range [min, max] and filter out INFs and NANs. So one needs to
implement an in-kernel version of C99's fpclassify and isgreater
working on floating point values kept in integer variables for
all drivers to use.

Alsa-lib may need to convert the IEEE floats to the native floats
if they are not the same. Just look at the issues with double on
ARM. There the order of the two 32 bit halves in memory depends on
the ABI IIRC.

Just my 2 cents

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
